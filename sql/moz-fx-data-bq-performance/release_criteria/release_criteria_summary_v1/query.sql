WITH stage_1 AS (
  SELECT
    project,
    normalized_form_factor,
    normalized_device_name,
    normalized_device_os,
    rc_tier,
    rc_test_name,
    app_name,
    rc_value,
    rc_mean_subtest_stddev,
    test_lower_is_better,
    rc_one_week_prior_average,
    rc_two_week_prior_average,
    rc_three_week_prior_average,
    rc_four_week_prior_average,
    task_group_time,
    task_group_id,
    test_tier,
    SAFE_DIVIDE(rc_one_week_prior_average - rc_value, rc_value) AS one_week_pct_change,
    SAFE_DIVIDE(rc_two_week_prior_average - rc_value, rc_value) AS two_week_pct_change,
    SAFE_DIVIDE(rc_three_week_prior_average - rc_value, rc_value) AS three_week_pct_change,
    SAFE_DIVIDE(rc_four_week_prior_average - rc_value, rc_value) AS four_week_pct_change,
    `moz-fx-data-bq-performance.udf.is_change_significant`(
      rc_value,
      rc_mean_subtest_stddev,
      rc_one_week_prior_average,
      rc_one_week_prior_mean_stddev
    ) AS is_one_week_change_significant,
    `moz-fx-data-bq-performance.udf.is_change_significant`(
      rc_value,
      rc_mean_subtest_stddev,
      rc_two_week_prior_average,
      rc_two_week_prior_mean_stddev
    ) AS is_two_week_change_significant,
    `moz-fx-data-bq-performance.udf.is_change_significant`(
      rc_value,
      rc_mean_subtest_stddev,
      rc_three_week_prior_average,
      rc_three_week_prior_mean_stddev
    ) AS is_three_week_change_significant,
    `moz-fx-data-bq-performance.udf.is_change_significant`(
      rc_value,
      rc_mean_subtest_stddev,
      rc_four_week_prior_average,
      rc_four_week_prior_mean_stddev
    ) AS is_four_week_change_significant
  FROM
    release_criteria_v1 AS a
  WHERE
    task_group_time = (
      SELECT
        MAX(task_group_time)
      FROM
        release_criteria_v1 AS b
      WHERE
        a.project = b.project
        AND a.platform = b.platform
        AND a.app_name = b.app_name
        AND a.rc_tier = b.rc_tier
        AND a.rc_test_name = b.rc_test_name
    )
),
stage_2 AS (
  SELECT
    a.*,
    b.rc_value AS target_value,
    b.rc_mean_subtest_stddev AS target_stddev,
    SAFE_DIVIDE(b.rc_value - a.rc_value, a.rc_value) AS target_pct_diff,
  FROM
    stage_1 AS a
  LEFT JOIN
    (
      SELECT
        DISTINCT task_group_id,
        project,
        normalized_device_name,
        normalized_device_os,
        rc_tier,
        rc_test_name,
        rc_value,
        rc_mean_subtest_stddev,
      FROM
        stage_1
      WHERE
        STARTS_WITH(app_name, 'target')
    ) AS b
  USING
    (task_group_id, project, normalized_device_name, normalized_device_os, rc_tier, rc_test_name)
  WHERE
    NOT STARTS_WITH(app_name, 'target')
),
stage_3 AS (
  WITH with_target_diff_significance AS (
    SELECT
      *,
      `moz-fx-data-bq-performance.udf.is_change_significant`(
        rc_value,
        rc_mean_subtest_stddev,
        target_value,
        target_stddev
      ) AS is_target_diff_significant
    FROM
      stage_2
  )
  SELECT
    *,
    `moz-fx-data-bq-performance.udf.interpret_change`(
      is_target_diff_significant.direction,
      test_lower_is_better
    ) AS vs_target,
    `moz-fx-data-bq-performance.udf.interpret_change`(
      is_one_week_change_significant.direction,
      test_lower_is_better
    ) AS vs_one_week_prior,
    `moz-fx-data-bq-performance.udf.interpret_change`(
      is_two_week_change_significant.direction,
      test_lower_is_better
    ) AS vs_two_week_prior,
    `moz-fx-data-bq-performance.udf.interpret_change`(
      is_three_week_change_significant.direction,
      test_lower_is_better
    ) AS vs_three_week_prior,
    `moz-fx-data-bq-performance.udf.interpret_change`(
      is_four_week_change_significant.direction,
      test_lower_is_better
    ) AS vs_four_week_prior,
  FROM
    with_target_diff_significance
),
SELECT
  project,
  normalized_form_factor,
  normalized_device_name,
  normalized_device_os,
  rc_tier,
  rc_test_name,
  app_name,
  ROUND(rc_value, 2) AS `current`,
  CONCAT(
    DATE(task_group_time),
    IF(`moz-fx-data-bq-performance.udf.is_stale_test`(task_group_time, test_tier), ' ⏳', '')
  ) AS last_updated,
  `moz-fx-data-bq-performance.udf.get_formatted_comparison`(
    target_value,
    target_pct_diff,
    vs_target,
    is_target_diff_significant.confidence
  ) AS target,
  `moz-fx-data-bq-performance.udf.get_formatted_comparison`(
    rc_one_week_prior_average,
    one_week_pct_change,
    vs_one_week_prior,
    is_one_week_change_significant.confidence
  ) AS one_week_prior,
  `moz-fx-data-bq-performance.udf.get_formatted_comparison`(
    rc_two_week_prior_average,
    two_week_pct_change,
    vs_two_week_prior,
    is_two_week_change_significant.confidence
  ) AS two_weeks_prior,
  `moz-fx-data-bq-performance.udf.get_formatted_comparison`(
    rc_three_week_prior_average,
    three_week_pct_change,
    vs_three_week_prior,
    is_three_week_change_significant.confidence
  ) AS three_weeks_prior,
  `moz-fx-data-bq-performance.udf.get_formatted_comparison`(
    rc_four_week_prior_average,
    four_week_pct_change,
    vs_four_week_prior,
    is_four_week_change_significant.confidence
  ) AS four_weeks_prior,
  IF(vs_target = 'regression', rc_test_name, NULL) AS vs_target_regression,
  IF(vs_target = 'improvement', rc_test_name, NULL) AS vs_target_unchanged,
  IF(vs_target = 'unchanged', rc_test_name, NULL) AS vs_target_improvement,
  IF(vs_one_week_prior = 'regression', rc_test_name, NULL) AS vs_one_week_prior_regression,
  IF(vs_one_week_prior = 'improvement', rc_test_name, NULL) AS vs_one_week_prior_unchanged,
  IF(vs_one_week_prior = 'unchanged', rc_test_name, NULL) AS vs_one_week_prior_improvement,
  IF(vs_two_week_prior = 'regression', rc_test_name, NULL) AS vs_two_week_prior_regression,
  IF(vs_two_week_prior = 'improvement', rc_test_name, NULL) AS vs_two_week_prior_unchanged,
  IF(vs_two_week_prior = 'unchanged', rc_test_name, NULL) AS vs_two_week_prior_improvement,
  IF(vs_three_week_prior = 'regression', rc_test_name, NULL) AS vs_three_week_prior_regression,
  IF(vs_three_week_prior = 'improvement', rc_test_name, NULL) AS vs_three_week_prior_unchanged,
  IF(vs_three_week_prior = 'unchanged', rc_test_name, NULL) AS vs_three_week_prior_improvement,
  IF(vs_four_week_prior = 'regression', rc_test_name, NULL) AS vs_four_week_prior_regression,
  IF(vs_four_week_prior = 'improvement', rc_test_name, NULL) AS vs_four_week_prior_unchanged,
  IF(vs_four_week_prior = 'unchanged', rc_test_name, NULL) AS vs_four_week_prior_improvement,
FROM
  stage_3
