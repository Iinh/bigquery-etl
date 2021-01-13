CREATE TEMP FUNCTION bucket_country(country STRING) AS (
  CASE
  WHEN
    country IN ('US', 'CA', 'DE', 'FR', 'GB')
  THEN
    [country, 'tier-1']
  WHEN
    country IN ('MX', 'BR')
  THEN
    [country, 'non-tier-1']
  ELSE
    ['non-tier-1']
  END
);

WITH pop AS (
  SELECT
    DISTINCT client_id,
    normalized_country_code AS country_code,
    DATE(submission_timestamp) AS date
  FROM
    telemetry.new_profile
  WHERE
    DATE(submission_timestamp)
    BETWEEN DATE_SUB(@submission_date, INTERVAL 8 DAY)
    AND @submission_date
    AND normalized_channel = 'release'
    AND DATE_DIFF(  -- Only use builds from the last month
      DATE(submission_timestamp),
      SAFE.PARSE_DATE('%Y%m%d', SUBSTR(application.build_id, 0, 8)),
      MONTH
    ) <= 1
    AND payload.processes.parent.scalars.startup_profile_selection_reason = 'firstrun-created-default'
    AND environment.system.os.name = 'Windows_NT'
     -- TODO: make sure source is reliably null and not 0
    AND environment.settings.attribution.source IS NOT NULL
    AND environment.partner.distribution_id IS NULL
    AND coalesce(environment.settings.attribution.ua, '') != 'firefox'
),
raw_info AS (
  SELECT
    client_id,
    submission_date,
    country AS country_code,
    any_value(days_seen_bits) AS days_seen_bits,
  FROM
    telemetry.clients_last_seen
  WHERE
    submission_date
    BETWEEN @submission_date
    AND DATE_ADD(@submission_date, INTERVAL 8 DAY)
    AND normalized_channel = 'release' -- for optimization only (not actually needed)
  GROUP BY
    1,
    2,
    3
),
eight_days_later AS (
  SELECT
    a.*,
    b.days_seen_bits
  FROM
    pop a
  LEFT JOIN
    raw_info b
  ON
    (a.client_id = b.client_id AND DATE_DIFF(b.submission_date, a.date, DAY) = 6)
),
client_conditions AS (
  SELECT
    client_id,
    date,
    country_code,
    coalesce(udf.bitcount_lowest_7(days_seen_bits), 0) >= 5 AS activated
  FROM
    eight_days_later
)
SELECT
  country_group,
  count(*) AS new_profiles,
  COUNTIF(activated = TRUE) AS num_activated,
  COUNTIF(activated = FALSE) AS num_non_activated
FROM
  client_conditions
CROSS JOIN
  UNNEST(ARRAY_CONCAT(['Overall'], bucket_country(country_code))) AS country_group
WHERE
  date = @submission_date
GROUP BY
  1
ORDER BY
  1
