---
title: telemetry
---

##[firefox_nondesktop_exact_mau28_by_dimensions_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/firefox_nondesktop_exact_mau28_by_dimensions_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/firefox_nondesktop_exact_mau28_by_dimensions_v1/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.firefox_nondesktop_exact_mau28_by_dimensions_v1`
AS
SELECT
  raw.*,
  COALESCE(cc.name, raw.country) AS country_name
FROM
  `moz-fx-data-shared-prod.telemetry_derived.firefox_nondesktop_exact_mau28_v1` AS raw
LEFT JOIN
  `moz-fx-data-shared-prod.static.country_codes_v1` cc
ON
  (raw.country = cc.code)
~~~~
##[experiment_error_aggregates](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiment_error_aggregates)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiment_error_aggregates/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.experiment_error_aggregates`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.experiment_error_aggregates_v1`
~~~~
##[nondesktop_clients_last_seen](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/nondesktop_clients_last_seen)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/nondesktop_clients_last_seen/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.nondesktop_clients_last_seen`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry.nondesktop_clients_last_seen_v1`
~~~~
##[experiment_enrollment_daily_active_population](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiment_enrollment_daily_active_population)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiment_enrollment_daily_active_population/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.experiment_enrollment_daily_active_population`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.experiment_enrollment_daily_active_population_v1`
~~~~
##[clients_probe_processes](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/clients_probe_processes)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/clients_probe_processes/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.client_probe_processes`
AS
SELECT
  metric,
  os,
  channel,
  ARRAY_AGG(DISTINCT(process)) AS processes,
FROM
  `moz-fx-data-shared-prod.telemetry_derived.client_probe_counts_v1`
GROUP BY
  metric,
  os,
  channel
ORDER BY
  metric,
  os
~~~~
##[addon_names](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/addon_names)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/addon_names/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.addon_names`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.addon_names_v1`
~~~~
##[addons_daily](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/addons_daily)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/addons_daily/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.addons_daily`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.addons_daily_v1`
~~~~
##[lockwise_mobile_events](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/lockwise_mobile_events)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/lockwise_mobile_events/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.lockwise_mobile_events`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry.lockwise_mobile_events_v1`
~~~~
##[firefox_nondesktop_exact_mau28_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/firefox_nondesktop_exact_mau28_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/firefox_nondesktop_exact_mau28_v1/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.firefox_nondesktop_exact_mau28_v1`
AS
SELECT
  submission_date,
  SUM(mau) AS mau,
  SUM(wau) AS wau,
  SUM(dau) AS dau,
  SUM(IF(country IN ('US', 'FR', 'DE', 'GB', 'CA'), mau, 0)) AS tier1_mau,
  SUM(IF(country IN ('US', 'FR', 'DE', 'GB', 'CA'), wau, 0)) AS tier1_wau,
  SUM(IF(country IN ('US', 'FR', 'DE', 'GB', 'CA'), dau, 0)) AS tier1_dau
FROM
  `moz-fx-data-shared-prod.telemetry.firefox_nondesktop_exact_mau28_by_dimensions_v1`
GROUP BY
  submission_date
~~~~
##[crash_aggregates_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/crash_aggregates_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/crash_aggregates_v1/view.sql)

~~~~sql
-- Query generated by: templates/unnest_parquet_view.sql.py crash_aggregates_v1 telemetry_derived.crash_aggregates_v1
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.crash_aggregates_v1`
AS
SELECT
  * REPLACE (dimensions.key_value AS dimensions, stats.key_value AS stats)
FROM
  `moz-fx-data-shared-prod.telemetry_derived.crash_aggregates_v1`
~~~~
##[clients_first_seen](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/clients_first_seen)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/clients_first_seen/metadata.yaml)

**Friendly name**: Clients first seen

**Description**: Identical in schema to clients_daily except that each client appears only once over all time; includes fields first_seen_date and second_seen_date for determining user "activation"

**Owners**: [jklukas@mozilla.com](mailto:jklukas@mozilla.com)

### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/clients_first_seen/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.clients_first_seen`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.clients_first_seen_v1`
~~~~
##[telemetry_ip_privacy_parquet](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_ip_privacy_parquet)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_ip_privacy_parquet/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.telemetry_ip_privacy_parquet`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.telemetry_ip_privacy_parquet_v1`
~~~~
##[telemetry_downgrade_parquet](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_downgrade_parquet)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_downgrade_parquet/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.telemetry_downgrade_parquet`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.telemetry_downgrade_parquet_v1`
~~~~
##[firefox_nondesktop_exact_mau28](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/firefox_nondesktop_exact_mau28)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/firefox_nondesktop_exact_mau28/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.firefox_nondesktop_exact_mau28`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry.firefox_nondesktop_exact_mau28_v1`
~~~~
##[firefox_nondesktop_exact_mau28_by_client_count_dimensions](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/firefox_nondesktop_exact_mau28_by_client_count_dimensions)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/firefox_nondesktop_exact_mau28_by_client_count_dimensions/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.firefox_nondesktop_exact_mau28_by_client_count_dimensions`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.firefox_nondesktop_exact_mau28_by_client_count_dimensions_v1`
~~~~
##[clients_histogram_aggregates_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/clients_histogram_aggregates_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/clients_histogram_aggregates_v1/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.clients_histogram_aggregates`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.clients_histogram_aggregates_v1`
~~~~
##[telemetry_ip_privacy](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_ip_privacy)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_ip_privacy/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.telemetry_ip_privacy`
AS
SELECT
  DATE(submission_timestamp) AS submission_date,
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.telemetry_ip_privacy_v2`
~~~~
##[core](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/core)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/core/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.core`
AS
WITH unioned AS (
  SELECT
    *
  FROM
    `moz-fx-data-shared-prod.telemetry_stable.core_v2`
  UNION ALL
  SELECT
    *
  FROM
    `moz-fx-data-shared-prod.telemetry_stable.core_v3`
  UNION ALL
  SELECT
    *
  FROM
    `moz-fx-data-shared-prod.telemetry_stable.core_v4`
  UNION ALL
  SELECT
    *
  FROM
    `moz-fx-data-shared-prod.telemetry_stable.core_v5`
  UNION ALL
  SELECT
    *
  FROM
    `moz-fx-data-shared-prod.telemetry_stable.core_v6`
  UNION ALL
  SELECT
    *
  FROM
    `moz-fx-data-shared-prod.telemetry_stable.core_v7`
  UNION ALL
  SELECT
    *
  FROM
    `moz-fx-data-shared-prod.telemetry_stable.core_v8`
  UNION ALL
  SELECT
    *
  FROM
    `moz-fx-data-shared-prod.telemetry_stable.core_v9`
  UNION ALL
  SELECT
    *
  FROM
    `moz-fx-data-shared-prod.telemetry_stable.core_v10`
)
  --
SELECT
  * REPLACE (
    -- The pipeline ensures lowercase client_id since 2020-01-10, but we apply
    -- LOWER here to provide continuity for older data that still contains
    -- some uppercase IDs; see https://github.com/mozilla/gcp-ingestion/pull/1069
    LOWER(client_id) AS client_id,
    `moz-fx-data-shared-prod.udf.normalize_metadata`(metadata) AS metadata
  )
FROM
  unioned
~~~~
##[firefox_nondesktop_exact_mau28_by_dimensions](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/firefox_nondesktop_exact_mau28_by_dimensions)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/firefox_nondesktop_exact_mau28_by_dimensions/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.firefox_nondesktop_exact_mau28_by_dimensions`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry.firefox_nondesktop_exact_mau28_by_dimensions_v1`
~~~~
##[crash_summary](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/crash_summary)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/crash_summary/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.crash_summary`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry.crash_summary_v2`
~~~~
##[smoot_usage_day_0](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/smoot_usage_day_0)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/smoot_usage_day_0/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.smoot_usage_day_0`
AS WITH
  unioned AS (
  SELECT * FROM `moz-fx-data-shared-prod.telemetry_derived.smoot_usage_desktop_v2`
  UNION ALL
  SELECT * FROM `moz-fx-data-shared-prod.telemetry_derived.smoot_usage_nondesktop_v2`
  UNION ALL
  SELECT * FROM `moz-fx-data-shared-prod.telemetry_derived.smoot_usage_fxa_v2` )
  --
SELECT
  submission_date AS `date`,
  usage,
  metrics.day_0.*,
  * EXCEPT (submission_date, usage, metrics)
FROM
  unioned
UNION ALL
SELECT
  DATE_SUB(submission_date, INTERVAL 6 DAY) AS `date`,
  usage,
  new_profiles AS dau,
  NULL AS wau,
  NULL AS mau,
  NULL AS active_days_in_week,
  * EXCEPT (submission_date, usage, new_profiles)
FROM
  `moz-fx-data-shared-prod.telemetry_derived.smoot_usage_new_profiles_v2`
~~~~
##[crash_aggregates](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/crash_aggregates)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/crash_aggregates/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.crash_aggregates`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry.crash_aggregates_v1`
~~~~
##[focus_event](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/focus_event)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/focus_event/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.focus_event`
AS
SELECT
  * REPLACE (
    -- The pipeline ensures lowercase client_id since 2020-01-10, but we apply
    -- LOWER here to provide continuity for older data that still contains
    -- some uppercase IDs; see https://github.com/mozilla/gcp-ingestion/pull/1069
    LOWER(client_id) AS client_id,
    `moz-fx-data-shared-prod.udf.normalize_metadata`(metadata) AS metadata
  )
FROM
  `moz-fx-data-shared-prod.telemetry_stable.focus_event_v1`
~~~~
##[experiment_cumulative_search_with_ads_count](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiment_cumulative_search_with_ads_count)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiment_cumulative_search_with_ads_count/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.experiment_cumulative_search_with_ads_count`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.experiment_cumulative_search_with_ads_count_v1`
~~~~
##[clients_daily_scalar_aggregates_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/clients_daily_scalar_aggregates_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/clients_daily_scalar_aggregates_v1/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.clients_daily_scalar_aggregates`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.clients_daily_scalar_aggregates_v1`
~~~~
##[experiment_search_aggregates_hourly](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiment_search_aggregates_hourly)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiment_search_aggregates_hourly/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.experiment_search_aggregates_hourly`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.experiment_search_aggregates_hourly_v1`
~~~~
##[telemetry_shield_study_parquet](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_shield_study_parquet)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_shield_study_parquet/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.telemetry_shield_study_parquet`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry.telemetry_shield_study_parquet_v1`
~~~~
##[experiments_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiments_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiments_v1/view.sql)

~~~~sql
-- Query generated by: templates/unnest_parquet_view.sql.py experiments_v1 telemetry_derived.experiments_v1
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.experiments_v1`
AS
SELECT
  submission_date AS submission_date_s3,
  * REPLACE (
    ARRAY(SELECT * FROM UNNEST(active_addons.list)) AS active_addons,
    ARRAY(SELECT * FROM UNNEST(antispyware.list)) AS antispyware,
    ARRAY(SELECT * FROM UNNEST(antivirus.list)) AS antivirus,
    boolean_addon_scalars.key_value AS boolean_addon_scalars,
    ARRAY(SELECT * FROM UNNEST(disabled_addons_ids.list)) AS disabled_addons_ids,
    ARRAY(
      SELECT
        *
      FROM
        UNNEST(environment_settings_intl_accept_languages.list)
    ) AS environment_settings_intl_accept_languages,
    ARRAY(
      SELECT
        *
      FROM
        UNNEST(environment_settings_intl_app_locales.list)
    ) AS environment_settings_intl_app_locales,
    ARRAY(
      SELECT
        *
      FROM
        UNNEST(environment_settings_intl_available_locales.list)
    ) AS environment_settings_intl_available_locales,
    ARRAY(
      SELECT
        *
      FROM
        UNNEST(environment_settings_intl_regional_prefs_locales.list)
    ) AS environment_settings_intl_regional_prefs_locales,
    ARRAY(
      SELECT
        *
      FROM
        UNNEST(environment_settings_intl_requested_locales.list)
    ) AS environment_settings_intl_requested_locales,
    ARRAY(
      SELECT
        *
      FROM
        UNNEST(environment_settings_intl_system_locales.list)
    ) AS environment_settings_intl_system_locales,
    ARRAY(
      SELECT AS STRUCT
        _0.element.* REPLACE (_0.element.map_values.key_value AS map_values)
      FROM
        UNNEST(events.list) AS _0
    ) AS events,
    experiments.key_value AS experiments,
    ARRAY(
      SELECT AS STRUCT
        * REPLACE (_0.value.key_value AS value)
      FROM
        UNNEST(experiments_details.key_value) AS _0
    ) AS experiments_details,
    ARRAY(SELECT * FROM UNNEST(firewall.list)) AS firewall,
    histogram_content_cert_validation_success_by_ca.key_value AS histogram_content_cert_validation_success_by_ca,
    histogram_content_checkerboard_severity.key_value AS histogram_content_checkerboard_severity,
    histogram_content_composite_time.key_value AS histogram_content_composite_time,
    histogram_content_content_paint_time.key_value AS histogram_content_content_paint_time,
    histogram_content_cycle_collector_max_pause.key_value AS histogram_content_cycle_collector_max_pause,
    histogram_content_devtools_accessibility_picker_time_active_seconds.key_value AS histogram_content_devtools_accessibility_picker_time_active_seconds,
    histogram_content_devtools_accessibility_service_time_active_seconds.key_value AS histogram_content_devtools_accessibility_service_time_active_seconds,
    histogram_content_devtools_accessibility_time_active_seconds.key_value AS histogram_content_devtools_accessibility_time_active_seconds,
    histogram_content_devtools_toolbox_time_active_seconds.key_value AS histogram_content_devtools_toolbox_time_active_seconds,
    histogram_content_fx_new_window_ms.key_value AS histogram_content_fx_new_window_ms,
    histogram_content_fx_page_load_ms_2.key_value AS histogram_content_fx_page_load_ms_2,
    histogram_content_fx_searchbar_selected_result_method.key_value AS histogram_content_fx_searchbar_selected_result_method,
    histogram_content_fx_session_restore_restore_window_ms.key_value AS histogram_content_fx_session_restore_restore_window_ms,
    histogram_content_fx_session_restore_startup_init_session_ms.key_value AS histogram_content_fx_session_restore_startup_init_session_ms,
    histogram_content_fx_session_restore_startup_onload_initial_window_ms.key_value AS histogram_content_fx_session_restore_startup_onload_initial_window_ms,
    histogram_content_fx_tab_close_time_anim_ms.key_value AS histogram_content_fx_tab_close_time_anim_ms,
    histogram_content_fx_tab_switch_update_ms.key_value AS histogram_content_fx_tab_switch_update_ms,
    histogram_content_fx_urlbar_selected_result_index.key_value AS histogram_content_fx_urlbar_selected_result_index,
    ARRAY(
      SELECT AS STRUCT
        * REPLACE (_0.value.key_value AS value)
      FROM
        UNNEST(histogram_content_fx_urlbar_selected_result_index_by_type.key_value) AS _0
    ) AS histogram_content_fx_urlbar_selected_result_index_by_type,
    histogram_content_fx_urlbar_selected_result_method.key_value AS histogram_content_fx_urlbar_selected_result_method,
    histogram_content_fx_urlbar_selected_result_type.key_value AS histogram_content_fx_urlbar_selected_result_type,
    histogram_content_gc_animation_ms.key_value AS histogram_content_gc_animation_ms,
    histogram_content_gc_max_pause_ms.key_value AS histogram_content_gc_max_pause_ms,
    histogram_content_gc_max_pause_ms_2.key_value AS histogram_content_gc_max_pause_ms_2,
    histogram_content_geolocation_request_granted.key_value AS histogram_content_geolocation_request_granted,
    histogram_content_ghost_windows.key_value AS histogram_content_ghost_windows,
    histogram_content_gpu_process_initialization_time_ms.key_value AS histogram_content_gpu_process_initialization_time_ms,
    histogram_content_gpu_process_launch_time_ms_2.key_value AS histogram_content_gpu_process_launch_time_ms_2,
    histogram_content_http_channel_disposition.key_value AS histogram_content_http_channel_disposition,
    histogram_content_http_pageload_is_ssl.key_value AS histogram_content_http_pageload_is_ssl,
    histogram_content_http_transaction_is_ssl.key_value AS histogram_content_http_transaction_is_ssl,
    histogram_content_input_event_response_coalesced_ms.key_value AS histogram_content_input_event_response_coalesced_ms,
    ARRAY(
      SELECT AS STRUCT
        * REPLACE (_0.value.key_value AS value)
      FROM
        UNNEST(histogram_content_ipc_read_main_thread_latency_ms.key_value) AS _0
    ) AS histogram_content_ipc_read_main_thread_latency_ms,
    ARRAY(
      SELECT AS STRUCT
        * REPLACE (_0.value.key_value AS value)
      FROM
        UNNEST(histogram_content_memory_distribution_among_content.key_value) AS _0
    ) AS histogram_content_memory_distribution_among_content,
    histogram_content_memory_heap_allocated.key_value AS histogram_content_memory_heap_allocated,
    histogram_content_memory_resident_fast.key_value AS histogram_content_memory_resident_fast,
    histogram_content_memory_total.key_value AS histogram_content_memory_total,
    histogram_content_memory_unique.key_value AS histogram_content_memory_unique,
    histogram_content_memory_unique_content_startup.key_value AS histogram_content_memory_unique_content_startup,
    histogram_content_memory_vsize.key_value AS histogram_content_memory_vsize,
    histogram_content_memory_vsize_max_contiguous.key_value AS histogram_content_memory_vsize_max_contiguous,
    histogram_content_network_cache_metadata_first_read_time_ms.key_value AS histogram_content_network_cache_metadata_first_read_time_ms,
    histogram_content_network_cache_v2_hit_time_ms.key_value AS histogram_content_network_cache_v2_hit_time_ms,
    histogram_content_network_cache_v2_miss_time_ms.key_value AS histogram_content_network_cache_v2_miss_time_ms,
    histogram_content_places_autocomplete_6_first_results_time_ms.key_value AS histogram_content_places_autocomplete_6_first_results_time_ms,
    histogram_content_plugin_shutdown_ms.key_value AS histogram_content_plugin_shutdown_ms,
    histogram_content_pwmgr_form_autofill_result.key_value AS histogram_content_pwmgr_form_autofill_result,
    histogram_content_pwmgr_login_page_safety.key_value AS histogram_content_pwmgr_login_page_safety,
    histogram_content_sandbox_rejected_syscalls.key_value AS histogram_content_sandbox_rejected_syscalls,
    histogram_content_search_reset_result.key_value AS histogram_content_search_reset_result,
    histogram_content_search_service_init_ms.key_value AS histogram_content_search_service_init_ms,
    histogram_content_ssl_handshake_result.key_value AS histogram_content_ssl_handshake_result,
    histogram_content_ssl_handshake_version.key_value AS histogram_content_ssl_handshake_version,
    histogram_content_ssl_tls12_intolerance_reason_pre.key_value AS histogram_content_ssl_tls12_intolerance_reason_pre,
    histogram_content_ssl_tls13_intolerance_reason_pre.key_value AS histogram_content_ssl_tls13_intolerance_reason_pre,
    histogram_content_time_to_dom_complete_ms.key_value AS histogram_content_time_to_dom_complete_ms,
    histogram_content_time_to_dom_content_loaded_end_ms.key_value AS histogram_content_time_to_dom_content_loaded_end_ms,
    histogram_content_time_to_dom_content_loaded_start_ms.key_value AS histogram_content_time_to_dom_content_loaded_start_ms,
    histogram_content_time_to_dom_interactive_ms.key_value AS histogram_content_time_to_dom_interactive_ms,
    histogram_content_time_to_dom_loading_ms.key_value AS histogram_content_time_to_dom_loading_ms,
    histogram_content_time_to_first_click_ms.key_value AS histogram_content_time_to_first_click_ms,
    histogram_content_time_to_first_interaction_ms.key_value AS histogram_content_time_to_first_interaction_ms,
    histogram_content_time_to_first_key_input_ms.key_value AS histogram_content_time_to_first_key_input_ms,
    histogram_content_time_to_first_mouse_move_ms.key_value AS histogram_content_time_to_first_mouse_move_ms,
    histogram_content_time_to_first_scroll_ms.key_value AS histogram_content_time_to_first_scroll_ms,
    histogram_content_time_to_load_event_end_ms.key_value AS histogram_content_time_to_load_event_end_ms,
    histogram_content_time_to_load_event_start_ms.key_value AS histogram_content_time_to_load_event_start_ms,
    histogram_content_time_to_non_blank_paint_ms.key_value AS histogram_content_time_to_non_blank_paint_ms,
    histogram_content_time_to_response_start_ms.key_value AS histogram_content_time_to_response_start_ms,
    histogram_content_tracking_protection_enabled.key_value AS histogram_content_tracking_protection_enabled,
    ARRAY(
      SELECT AS STRUCT
        * REPLACE (_0.value.key_value AS value)
      FROM
        UNNEST(histogram_content_uptake_remote_content_result_1.key_value) AS _0
    ) AS histogram_content_uptake_remote_content_result_1,
    histogram_content_webext_content_script_injection_ms.key_value AS histogram_content_webext_content_script_injection_ms,
    histogram_content_webext_storage_local_get_ms.key_value AS histogram_content_webext_storage_local_get_ms,
    histogram_content_webext_storage_local_set_ms.key_value AS histogram_content_webext_storage_local_set_ms,
    histogram_content_webvr_time_spent_viewing_in_2d.key_value AS histogram_content_webvr_time_spent_viewing_in_2d,
    histogram_content_webvr_users_view_in.key_value AS histogram_content_webvr_users_view_in,
    histogram_gpu_checkerboard_severity.key_value AS histogram_gpu_checkerboard_severity,
    histogram_gpu_composite_time.key_value AS histogram_gpu_composite_time,
    histogram_gpu_content_frame_time.key_value AS histogram_gpu_content_frame_time,
    histogram_gpu_gpu_process_initialization_time_ms.key_value AS histogram_gpu_gpu_process_initialization_time_ms,
    ARRAY(
      SELECT AS STRUCT
        * REPLACE (_0.value.key_value AS value)
      FROM
        UNNEST(histogram_gpu_ipc_read_main_thread_latency_ms.key_value) AS _0
    ) AS histogram_gpu_ipc_read_main_thread_latency_ms,
    ARRAY(
      SELECT AS STRUCT
        * REPLACE (_0.value.key_value AS value)
      FROM
        UNNEST(histogram_gpu_uptake_remote_content_result_1.key_value) AS _0
    ) AS histogram_gpu_uptake_remote_content_result_1,
    histogram_gpu_webvr_time_spent_viewing_in_oculus.key_value AS histogram_gpu_webvr_time_spent_viewing_in_oculus,
    histogram_gpu_webvr_time_spent_viewing_in_openvr.key_value AS histogram_gpu_webvr_time_spent_viewing_in_openvr,
    histogram_gpu_webvr_users_view_in.key_value AS histogram_gpu_webvr_users_view_in,
    histogram_parent_a11y_consumers.key_value AS histogram_parent_a11y_consumers,
    histogram_parent_a11y_instantiated_flag.key_value AS histogram_parent_a11y_instantiated_flag,
    histogram_parent_cert_validation_success_by_ca.key_value AS histogram_parent_cert_validation_success_by_ca,
    histogram_parent_checkerboard_severity.key_value AS histogram_parent_checkerboard_severity,
    histogram_parent_composite_time.key_value AS histogram_parent_composite_time,
    histogram_parent_content_frame_time.key_value AS histogram_parent_content_frame_time,
    histogram_parent_content_paint_time.key_value AS histogram_parent_content_paint_time,
    histogram_parent_cookie_behavior.key_value AS histogram_parent_cookie_behavior,
    histogram_parent_cycle_collector_max_pause.key_value AS histogram_parent_cycle_collector_max_pause,
    histogram_parent_devtools_about_devtools_opened_key.key_value AS histogram_parent_devtools_about_devtools_opened_key,
    histogram_parent_devtools_about_devtools_opened_reason.key_value AS histogram_parent_devtools_about_devtools_opened_reason,
    histogram_parent_devtools_accessibility_picker_time_active_seconds.key_value AS histogram_parent_devtools_accessibility_picker_time_active_seconds,
    histogram_parent_devtools_accessibility_service_time_active_seconds.key_value AS histogram_parent_devtools_accessibility_service_time_active_seconds,
    histogram_parent_devtools_accessibility_time_active_seconds.key_value AS histogram_parent_devtools_accessibility_time_active_seconds,
    histogram_parent_devtools_entry_point.key_value AS histogram_parent_devtools_entry_point,
    histogram_parent_devtools_fonteditor_font_type_displayed.key_value AS histogram_parent_devtools_fonteditor_font_type_displayed,
    histogram_parent_devtools_fonteditor_n_font_axes.key_value AS histogram_parent_devtools_fonteditor_n_font_axes,
    histogram_parent_devtools_fonteditor_n_fonts_rendered.key_value AS histogram_parent_devtools_fonteditor_n_fonts_rendered,
    histogram_parent_devtools_toolbox_time_active_seconds.key_value AS histogram_parent_devtools_toolbox_time_active_seconds,
    histogram_parent_dns_failed_lookup_time.key_value AS histogram_parent_dns_failed_lookup_time,
    histogram_parent_dns_lookup_time.key_value AS histogram_parent_dns_lookup_time,
    histogram_parent_fx_new_window_ms.key_value AS histogram_parent_fx_new_window_ms,
    histogram_parent_fx_page_load_ms_2.key_value AS histogram_parent_fx_page_load_ms_2,
    histogram_parent_fx_searchbar_selected_result_method.key_value AS histogram_parent_fx_searchbar_selected_result_method,
    histogram_parent_fx_session_restore_restore_window_ms.key_value AS histogram_parent_fx_session_restore_restore_window_ms,
    histogram_parent_fx_session_restore_startup_init_session_ms.key_value AS histogram_parent_fx_session_restore_startup_init_session_ms,
    histogram_parent_fx_session_restore_startup_onload_initial_window_ms.key_value AS histogram_parent_fx_session_restore_startup_onload_initial_window_ms,
    histogram_parent_fx_tab_close_time_anim_ms.key_value AS histogram_parent_fx_tab_close_time_anim_ms,
    histogram_parent_fx_tab_switch_total_e10s_ms.key_value AS histogram_parent_fx_tab_switch_total_e10s_ms,
    histogram_parent_fx_tab_switch_update_ms.key_value AS histogram_parent_fx_tab_switch_update_ms,
    histogram_parent_fx_urlbar_selected_result_index.key_value AS histogram_parent_fx_urlbar_selected_result_index,
    ARRAY(
      SELECT AS STRUCT
        * REPLACE (_0.value.key_value AS value)
      FROM
        UNNEST(histogram_parent_fx_urlbar_selected_result_index_by_type.key_value) AS _0
    ) AS histogram_parent_fx_urlbar_selected_result_index_by_type,
    histogram_parent_fx_urlbar_selected_result_method.key_value AS histogram_parent_fx_urlbar_selected_result_method,
    histogram_parent_fx_urlbar_selected_result_type.key_value AS histogram_parent_fx_urlbar_selected_result_type,
    histogram_parent_gc_animation_ms.key_value AS histogram_parent_gc_animation_ms,
    histogram_parent_gc_max_pause_ms.key_value AS histogram_parent_gc_max_pause_ms,
    histogram_parent_gc_max_pause_ms_2.key_value AS histogram_parent_gc_max_pause_ms_2,
    histogram_parent_geolocation_request_granted.key_value AS histogram_parent_geolocation_request_granted,
    histogram_parent_ghost_windows.key_value AS histogram_parent_ghost_windows,
    histogram_parent_gpu_process_initialization_time_ms.key_value AS histogram_parent_gpu_process_initialization_time_ms,
    histogram_parent_gpu_process_launch_time_ms_2.key_value AS histogram_parent_gpu_process_launch_time_ms_2,
    histogram_parent_http_channel_disposition.key_value AS histogram_parent_http_channel_disposition,
    histogram_parent_http_pageload_is_ssl.key_value AS histogram_parent_http_pageload_is_ssl,
    histogram_parent_http_transaction_is_ssl.key_value AS histogram_parent_http_transaction_is_ssl,
    histogram_parent_input_event_response_coalesced_ms.key_value AS histogram_parent_input_event_response_coalesced_ms,
    ARRAY(
      SELECT AS STRUCT
        * REPLACE (_0.value.key_value AS value)
      FROM
        UNNEST(histogram_parent_ipc_read_main_thread_latency_ms.key_value) AS _0
    ) AS histogram_parent_ipc_read_main_thread_latency_ms,
    ARRAY(
      SELECT AS STRUCT
        * REPLACE (_0.value.key_value AS value)
      FROM
        UNNEST(histogram_parent_memory_distribution_among_content.key_value) AS _0
    ) AS histogram_parent_memory_distribution_among_content,
    histogram_parent_memory_heap_allocated.key_value AS histogram_parent_memory_heap_allocated,
    histogram_parent_memory_resident_fast.key_value AS histogram_parent_memory_resident_fast,
    histogram_parent_memory_total.key_value AS histogram_parent_memory_total,
    histogram_parent_memory_unique.key_value AS histogram_parent_memory_unique,
    histogram_parent_memory_vsize.key_value AS histogram_parent_memory_vsize,
    histogram_parent_memory_vsize_max_contiguous.key_value AS histogram_parent_memory_vsize_max_contiguous,
    histogram_parent_network_cache_metadata_first_read_time_ms.key_value AS histogram_parent_network_cache_metadata_first_read_time_ms,
    histogram_parent_network_cache_v2_hit_time_ms.key_value AS histogram_parent_network_cache_v2_hit_time_ms,
    histogram_parent_network_cache_v2_miss_time_ms.key_value AS histogram_parent_network_cache_v2_miss_time_ms,
    histogram_parent_places_autocomplete_6_first_results_time_ms.key_value AS histogram_parent_places_autocomplete_6_first_results_time_ms,
    histogram_parent_plugin_shutdown_ms.key_value AS histogram_parent_plugin_shutdown_ms,
    histogram_parent_pwmgr_blocklist_num_sites.key_value AS histogram_parent_pwmgr_blocklist_num_sites,
    histogram_parent_pwmgr_form_autofill_result.key_value AS histogram_parent_pwmgr_form_autofill_result,
    histogram_parent_pwmgr_login_last_used_days.key_value AS histogram_parent_pwmgr_login_last_used_days,
    histogram_parent_pwmgr_login_page_safety.key_value AS histogram_parent_pwmgr_login_page_safety,
    histogram_parent_pwmgr_manage_opened.key_value AS histogram_parent_pwmgr_manage_opened,
    histogram_parent_pwmgr_manage_visibility_toggled.key_value AS histogram_parent_pwmgr_manage_visibility_toggled,
    histogram_parent_pwmgr_num_passwords_per_hostname.key_value AS histogram_parent_pwmgr_num_passwords_per_hostname,
    histogram_parent_pwmgr_num_saved_passwords.key_value AS histogram_parent_pwmgr_num_saved_passwords,
    histogram_parent_pwmgr_prompt_remember_action.key_value AS histogram_parent_pwmgr_prompt_remember_action,
    histogram_parent_pwmgr_prompt_update_action.key_value AS histogram_parent_pwmgr_prompt_update_action,
    histogram_parent_pwmgr_saving_enabled.key_value AS histogram_parent_pwmgr_saving_enabled,
    histogram_parent_sandbox_rejected_syscalls.key_value AS histogram_parent_sandbox_rejected_syscalls,
    histogram_parent_search_reset_result.key_value AS histogram_parent_search_reset_result,
    histogram_parent_search_service_init_ms.key_value AS histogram_parent_search_service_init_ms,
    histogram_parent_ssl_handshake_result.key_value AS histogram_parent_ssl_handshake_result,
    histogram_parent_ssl_handshake_version.key_value AS histogram_parent_ssl_handshake_version,
    histogram_parent_ssl_tls12_intolerance_reason_pre.key_value AS histogram_parent_ssl_tls12_intolerance_reason_pre,
    histogram_parent_ssl_tls13_intolerance_reason_pre.key_value AS histogram_parent_ssl_tls13_intolerance_reason_pre,
    histogram_parent_time_to_first_click_ms.key_value AS histogram_parent_time_to_first_click_ms,
    histogram_parent_time_to_first_interaction_ms.key_value AS histogram_parent_time_to_first_interaction_ms,
    histogram_parent_time_to_first_key_input_ms.key_value AS histogram_parent_time_to_first_key_input_ms,
    histogram_parent_time_to_first_mouse_move_ms.key_value AS histogram_parent_time_to_first_mouse_move_ms,
    histogram_parent_time_to_first_scroll_ms.key_value AS histogram_parent_time_to_first_scroll_ms,
    histogram_parent_time_to_non_blank_paint_ms.key_value AS histogram_parent_time_to_non_blank_paint_ms,
    histogram_parent_time_to_response_start_ms.key_value AS histogram_parent_time_to_response_start_ms,
    histogram_parent_touch_enabled_device.key_value AS histogram_parent_touch_enabled_device,
    histogram_parent_tracking_protection_enabled.key_value AS histogram_parent_tracking_protection_enabled,
    histogram_parent_update_bits_result_complete.key_value AS histogram_parent_update_bits_result_complete,
    histogram_parent_update_bits_result_partial.key_value AS histogram_parent_update_bits_result_partial,
    histogram_parent_update_can_use_bits_notify.key_value AS histogram_parent_update_can_use_bits_notify,
    histogram_parent_update_download_code_complete.key_value AS histogram_parent_update_download_code_complete,
    histogram_parent_update_download_code_partial.key_value AS histogram_parent_update_download_code_partial,
    histogram_parent_update_state_code_complete_stage.key_value AS histogram_parent_update_state_code_complete_stage,
    histogram_parent_update_state_code_complete_startup.key_value AS histogram_parent_update_state_code_complete_startup,
    histogram_parent_update_state_code_partial_stage.key_value AS histogram_parent_update_state_code_partial_stage,
    histogram_parent_update_state_code_partial_startup.key_value AS histogram_parent_update_state_code_partial_startup,
    histogram_parent_update_status_error_code_complete_stage.key_value AS histogram_parent_update_status_error_code_complete_stage,
    histogram_parent_update_status_error_code_complete_startup.key_value AS histogram_parent_update_status_error_code_complete_startup,
    histogram_parent_update_status_error_code_partial_stage.key_value AS histogram_parent_update_status_error_code_partial_stage,
    histogram_parent_update_status_error_code_partial_startup.key_value AS histogram_parent_update_status_error_code_partial_startup,
    ARRAY(
      SELECT AS STRUCT
        * REPLACE (_0.value.key_value AS value)
      FROM
        UNNEST(histogram_parent_uptake_remote_content_result_1.key_value) AS _0
    ) AS histogram_parent_uptake_remote_content_result_1,
    histogram_parent_webext_background_page_load_ms.key_value AS histogram_parent_webext_background_page_load_ms,
    histogram_parent_webext_browseraction_popup_open_ms.key_value AS histogram_parent_webext_browseraction_popup_open_ms,
    histogram_parent_webext_browseraction_popup_preload_result_count.key_value AS histogram_parent_webext_browseraction_popup_preload_result_count,
    histogram_parent_webext_content_script_injection_ms.key_value AS histogram_parent_webext_content_script_injection_ms,
    histogram_parent_webext_extension_startup_ms.key_value AS histogram_parent_webext_extension_startup_ms,
    histogram_parent_webext_pageaction_popup_open_ms.key_value AS histogram_parent_webext_pageaction_popup_open_ms,
    histogram_parent_webext_storage_local_get_ms.key_value AS histogram_parent_webext_storage_local_get_ms,
    histogram_parent_webext_storage_local_set_ms.key_value AS histogram_parent_webext_storage_local_set_ms,
    histogram_parent_webvr_time_spent_viewing_in_2d.key_value AS histogram_parent_webvr_time_spent_viewing_in_2d,
    histogram_parent_webvr_time_spent_viewing_in_oculus.key_value AS histogram_parent_webvr_time_spent_viewing_in_oculus,
    histogram_parent_webvr_time_spent_viewing_in_openvr.key_value AS histogram_parent_webvr_time_spent_viewing_in_openvr,
    histogram_parent_webvr_users_view_in.key_value AS histogram_parent_webvr_users_view_in,
    ARRAY(
      SELECT AS STRUCT
        * REPLACE (_0.value.key_value AS value)
      FROM
        UNNEST(keyed_boolean_addon_scalars.key_value) AS _0
    ) AS keyed_boolean_addon_scalars,
    ARRAY(
      SELECT AS STRUCT
        * REPLACE (_0.value.key_value AS value)
      FROM
        UNNEST(keyed_string_addon_scalars.key_value) AS _0
    ) AS keyed_string_addon_scalars,
    ARRAY(
      SELECT AS STRUCT
        * REPLACE (_0.value.key_value AS value)
      FROM
        UNNEST(keyed_uint_addon_scalars.key_value) AS _0
    ) AS keyed_uint_addon_scalars,
    popup_notification_stats.key_value AS popup_notification_stats,
    scalar_content_dom_event_confluence_load_count.key_value AS scalar_content_dom_event_confluence_load_count,
    scalar_content_dom_event_office_online_load_count.key_value AS scalar_content_dom_event_office_online_load_count,
    scalar_content_gfx_small_paint_phase_weight.key_value AS scalar_content_gfx_small_paint_phase_weight,
    scalar_content_images_webp_content_frequency.key_value AS scalar_content_images_webp_content_frequency,
    scalar_content_pictureinpicture_opened_method.key_value AS scalar_content_pictureinpicture_opened_method,
    scalar_content_telemetry_accumulate_unknown_histogram_keys.key_value AS scalar_content_telemetry_accumulate_unknown_histogram_keys,
    scalar_content_telemetry_event_counts.key_value AS scalar_content_telemetry_event_counts,
    scalar_content_webrtc_sdp_parser_diff.key_value AS scalar_content_webrtc_sdp_parser_diff,
    scalar_content_webrtc_video_recv_codec_used.key_value AS scalar_content_webrtc_video_recv_codec_used,
    scalar_content_webrtc_video_send_codec_used.key_value AS scalar_content_webrtc_video_send_codec_used,
    scalar_gpu_telemetry_accumulate_unknown_histogram_keys.key_value AS scalar_gpu_telemetry_accumulate_unknown_histogram_keys,
    scalar_gpu_telemetry_event_counts.key_value AS scalar_gpu_telemetry_event_counts,
    scalar_parent_a11y_theme.key_value AS scalar_parent_a11y_theme,
    scalar_parent_browser_engagement_navigation_about_home.key_value AS scalar_parent_browser_engagement_navigation_about_home,
    scalar_parent_browser_engagement_navigation_about_newtab.key_value AS scalar_parent_browser_engagement_navigation_about_newtab,
    scalar_parent_browser_engagement_navigation_contextmenu.key_value AS scalar_parent_browser_engagement_navigation_contextmenu,
    scalar_parent_browser_engagement_navigation_searchbar.key_value AS scalar_parent_browser_engagement_navigation_searchbar,
    scalar_parent_browser_engagement_navigation_urlbar.key_value AS scalar_parent_browser_engagement_navigation_urlbar,
    scalar_parent_browser_engagement_navigation_webextension.key_value AS scalar_parent_browser_engagement_navigation_webextension,
    scalar_parent_browser_errors_collected_count_by_filename.key_value AS scalar_parent_browser_errors_collected_count_by_filename,
    scalar_parent_browser_search_ad_clicks.key_value AS scalar_parent_browser_search_ad_clicks,
    scalar_parent_browser_search_with_ads.key_value AS scalar_parent_browser_search_with_ads,
    scalar_parent_devtools_accessibility_accessible_context_menu_item_activated.key_value AS scalar_parent_devtools_accessibility_accessible_context_menu_item_activated,
    scalar_parent_devtools_accessibility_audit_activated.key_value AS scalar_parent_devtools_accessibility_audit_activated,
    scalar_parent_devtools_accessibility_select_accessible_for_node.key_value AS scalar_parent_devtools_accessibility_select_accessible_for_node,
    scalar_parent_devtools_accessibility_simulation_activated.key_value AS scalar_parent_devtools_accessibility_simulation_activated,
    scalar_parent_devtools_current_theme.key_value AS scalar_parent_devtools_current_theme,
    scalar_parent_devtools_inspector_three_pane_enabled.key_value AS scalar_parent_devtools_inspector_three_pane_enabled,
    scalar_parent_devtools_responsive_open_trigger.key_value AS scalar_parent_devtools_responsive_open_trigger,
    scalar_parent_devtools_tool_registered.key_value AS scalar_parent_devtools_tool_registered,
    scalar_parent_devtools_toolbox_tabs_reordered.key_value AS scalar_parent_devtools_toolbox_tabs_reordered,
    scalar_parent_devtools_tooltip_shown.key_value AS scalar_parent_devtools_tooltip_shown,
    scalar_parent_extensions_updates_rdf.key_value AS scalar_parent_extensions_updates_rdf,
    scalar_parent_gfx_advanced_layers_failure_id.key_value AS scalar_parent_gfx_advanced_layers_failure_id,
    scalar_parent_images_webp_content_frequency.key_value AS scalar_parent_images_webp_content_frequency,
    scalar_parent_networking_data_transferred.key_value AS scalar_parent_networking_data_transferred,
    scalar_parent_networking_data_transferred_kb.key_value AS scalar_parent_networking_data_transferred_kb,
    scalar_parent_networking_data_transferred_v3_kb.key_value AS scalar_parent_networking_data_transferred_v3_kb,
    scalar_parent_normandy_recipe_freshness.key_value AS scalar_parent_normandy_recipe_freshness,
    scalar_parent_pictureinpicture_closed_method.key_value AS scalar_parent_pictureinpicture_closed_method,
    scalar_parent_preferences_browser_home_page_change.key_value AS scalar_parent_preferences_browser_home_page_change,
    scalar_parent_preferences_browser_home_page_count.key_value AS scalar_parent_preferences_browser_home_page_count,
    scalar_parent_preferences_search_query.key_value AS scalar_parent_preferences_search_query,
    scalar_parent_preferences_use_bookmark.key_value AS scalar_parent_preferences_use_bookmark,
    scalar_parent_preferences_use_current_page.key_value AS scalar_parent_preferences_use_current_page,
    scalar_parent_qm_origin_directory_unexpected_filename.key_value AS scalar_parent_qm_origin_directory_unexpected_filename,
    scalar_parent_resistfingerprinting_content_window_size.key_value AS scalar_parent_resistfingerprinting_content_window_size,
    scalar_parent_sandbox_no_job.key_value AS scalar_parent_sandbox_no_job,
    scalar_parent_security_client_cert.key_value AS scalar_parent_security_client_cert,
    scalar_parent_security_contentblocker_permissions.key_value AS scalar_parent_security_contentblocker_permissions,
    scalar_parent_security_pkcs11_modules_loaded.key_value AS scalar_parent_security_pkcs11_modules_loaded,
    scalar_parent_security_webauthn_used.key_value AS scalar_parent_security_webauthn_used,
    scalar_parent_services_sync_sync_login_state_transitions.key_value AS scalar_parent_services_sync_sync_login_state_transitions,
    scalar_parent_storage_sync_api_usage_items_stored.key_value AS scalar_parent_storage_sync_api_usage_items_stored,
    scalar_parent_storage_sync_api_usage_storage_consumed.key_value AS scalar_parent_storage_sync_api_usage_storage_consumed,
    scalar_parent_telemetry_accumulate_clamped_values.key_value AS scalar_parent_telemetry_accumulate_clamped_values,
    scalar_parent_telemetry_accumulate_unknown_histogram_keys.key_value AS scalar_parent_telemetry_accumulate_unknown_histogram_keys,
    scalar_parent_telemetry_event_counts.key_value AS scalar_parent_telemetry_event_counts,
    scalar_parent_telemetry_keyed_scalars_exceed_limit.key_value AS scalar_parent_telemetry_keyed_scalars_exceed_limit,
    scalar_parent_update_binarytransparencyresult.key_value AS scalar_parent_update_binarytransparencyresult,
    scalar_parent_update_bitshresult.key_value AS scalar_parent_update_bitshresult,
    scalar_parent_widget_ime_name_on_linux.key_value AS scalar_parent_widget_ime_name_on_linux,
    scalar_parent_widget_ime_name_on_mac.key_value AS scalar_parent_widget_ime_name_on_mac,
    scalar_parent_widget_ime_name_on_windows.key_value AS scalar_parent_widget_ime_name_on_windows,
    ARRAY(SELECT * FROM UNNEST(search_counts.list)) AS search_counts,
    ssl_handshake_result.key_value AS ssl_handshake_result,
    string_addon_scalars.key_value AS string_addon_scalars,
    uint_addon_scalars.key_value AS uint_addon_scalars
  ),
  CAST(NULL AS STRING) AS experiment_enrollment_id
FROM
  -- This table was called experiments_v1 in the moz-fx-data-derived-datasets
  -- project, but we renamed to v0 when copying to shared-prod so that we
  -- could maintain this query that unions the old and new structures.
  `moz-fx-data-shared-prod.telemetry_derived.experiments_v0`
WHERE
  submission_date < '2019-12-04'
UNION ALL
SELECT
  submission_date AS submission_date_s3,
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.experiments_v1`
WHERE
  submission_date >= '2019-12-04'
~~~~
##[addon_aggregates](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/addon_aggregates)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/addon_aggregates/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.addon_aggregates`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry.addon_aggregates_v2`
~~~~
##[firefox_accounts_exact_mau28_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/firefox_accounts_exact_mau28_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/firefox_accounts_exact_mau28_v1/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.firefox_accounts_exact_mau28_v1`
AS
SELECT
  submission_date,
  SUM(mau) AS mau,
  SUM(wau) AS wau,
  SUM(dau) AS dau,
  SUM(seen_in_tier1_country_mau) AS tier1_mau
FROM
  `moz-fx-data-shared-prod.telemetry.firefox_accounts_exact_mau28_by_dimensions_v1`
GROUP BY
  submission_date
~~~~
##[fenix_clients_last_seen](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/fenix_clients_last_seen)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/fenix_clients_last_seen/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.fenix_clients_last_seen`
AS
-- For context on naming and channels of Fenix apps, see:
-- https://docs.google.com/document/d/1Ym4eZyS0WngEP6WdwJjmCoxtoQbJSvORxlQwZpuSV2I/edit#heading=h.69hvvg35j8un
WITH fenix_union AS (
  SELECT
    *,
    'org_mozilla_fenix' AS _dataset
  FROM
    `moz-fx-data-shared-prod.org_mozilla_fenix.baseline_clients_last_seen`
  UNION ALL
  SELECT
    *,
    'org_mozilla_fenix_nightly' AS _dataset
  FROM
    `moz-fx-data-shared-prod.org_mozilla_fenix_nightly.baseline_clients_last_seen`
  UNION ALL
  SELECT
    *,
    'org_mozilla_firefox' AS _dataset
  FROM
    `moz-fx-data-shared-prod.org_mozilla_firefox.baseline_clients_last_seen`
  UNION ALL
  SELECT
    *,
    'org_mozilla_firefox_beta' AS _dataset
  FROM
    `moz-fx-data-shared-prod.org_mozilla_firefox_beta.baseline_clients_last_seen`
  UNION ALL
  SELECT
    *,
    'org_mozilla_fennec_aurora' AS _dataset
  FROM
    `moz-fx-data-shared-prod.org_mozilla_fennec_aurora.baseline_clients_last_seen`
),
fenix_app_info AS (
  SELECT
    *,
    mozfun.norm.fenix_app_info(_dataset, app_build) AS _app_info
  FROM
    fenix_union
)
SELECT
  * EXCEPT (_dataset, _app_info) REPLACE(_app_info.channel AS normalized_channel),
  _app_info.app_name,
FROM
  fenix_app_info
~~~~
##[experiment_enrollment_other_events_overall](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiment_enrollment_other_events_overall)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiment_enrollment_other_events_overall/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.experiment_enrollment_other_events_overall`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.experiment_enrollment_other_events_overall_v1`
~~~~
##[attitudes_daily](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/attitudes_daily)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/attitudes_daily/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.attitudes_daily`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.attitudes_daily_v1`
~~~~
##[telemetry_heartbeat_parquet](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_heartbeat_parquet)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_heartbeat_parquet/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.telemetry_heartbeat_parquet`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.telemetry_heartbeat_parquet_v1`
~~~~
##[main_summary](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/main_summary)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/main_summary/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.main_summary`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry.main_summary_v4`
~~~~
##[asn_aggregates](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/asn_aggregates)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/asn_aggregates/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.asn_aggregates`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.asn_aggregates_v1`
~~~~
##[buildhub2](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/buildhub2)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/buildhub2/view.sql)

~~~~sql
-- This is an authorized view that allows us to read specific data from
-- a project owned by CloudOps; if the definition here changes,
-- it may need to be manually redeployed by Data Ops.
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.buildhub2`
AS
SELECT
  *
FROM
  `moz-fx-buildhub2-prod-4784.build_metadata.buildhub2`
~~~~
##[telemetry_mobile_event_parquet_v2](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_mobile_event_parquet_v2)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_mobile_event_parquet_v2/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.telemetry_mobile_event_parquet_v2` AS
SELECT
  DATE(submission_timestamp) AS submission_date_s3,
  DATE(submission_timestamp) AS submission_date,
  metadata.uri.app_name,
  os,
  STRUCT( document_id,
    UNIX_MICROS(submission_timestamp) * 1000 AS `timestamp`,
    metadata.header.date AS `date`,
    IFNULL(metadata.geo.country,
      '??') AS geo_country,
    IFNULL(metadata.geo.city,
      '??') AS geo_city,
    metadata.uri.app_build_id,
    metadata.uri.app_name,
    metadata.uri.app_version,
    sample_id,
    metadata.uri.app_update_channel ) AS metadata,
  v,
  client_id,
  seq,
  locale,
  osversion,
  device,
  arch,
  created,
  process_start_timestamp,
  tz,
  settings,
  ARRAY(
    SELECT
      AS STRUCT f0_ AS timestamp,
      f1_ AS category,
      f2_ AS method,
      f3_ AS object,
      f4_ AS value,
      f5_ AS extra
  FROM
    UNNEST(events)) AS events,
  experiments
FROM
  `moz-fx-data-shared-prod.telemetry.mobile_event`
~~~~
##[telemetry_focus_event_parquet_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_focus_event_parquet_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_focus_event_parquet_v1/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.telemetry_focus_event_parquet_v1` AS
SELECT
  DATE(submission_timestamp) AS submission_date_s3,
  DATE(submission_timestamp) AS submission_date,
  metadata.uri.app_update_channel AS channel,
  STRUCT( document_id,
    UNIX_MICROS(submission_timestamp) * 1000 AS `timestamp`,
    metadata.header.date AS `date`,
    IFNULL(metadata.geo.country,
      '??') AS geo_country,
    IFNULL(metadata.geo.city,
      '??') AS geo_city,
    metadata.uri.app_build_id,
    metadata.uri.app_name ) AS metadata,
  v,
  client_id,
  seq,
  locale,
  os,
  osversion,
  created,
  tz,
  settings,
  events,
  arch,
  device,
  process_start_timestamp,
  experiments
FROM
  `moz-fx-data-shared-prod.telemetry.focus_event`
~~~~
##[clients_last_seen](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/clients_last_seen)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/clients_last_seen/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.clients_last_seen`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry.clients_last_seen_v1`
~~~~
##[experiments](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiments)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiments/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.experiments`
AS
SELECT
  * EXCEPT (
    scalar_content_webrtc_nicer_stun_retransmits,
    scalar_parent_devtools_aboutdevtools_noinstall_exits,
    scalar_parent_media_blocked_autoplay_no_audio_track_count,
    histogram_content_devtools_computedview_opened_count,
    histogram_content_pwmgr_manage_deleted,
    scalar_parent_devtools_changesview_contextmenu_copy,
    scalar_content_telemetry_process_creation_timestamp_inconsistent,
    scalar_parent_devtools_changesview_contextmenu_copy_rule,
    active_experiment_id,
    plugins_infobar_shown,
    scalar_parent_media_page_had_media_count,
    scalar_parent_webrtc_peerconnection_legacy_callback_stats_used,
    histogram_content_devtools_responsive_opened_count,
    histogram_parent_devtools_webaudioeditor_opened_count,
    histogram_content_pwmgr_manage_copied_password,
    scalar_content_sw_cors_res_for_so_req_count,
    scalar_parent_browser_errors_sample_rate,
    scalar_parent_browser_feeds_livebookmark_item_opened,
    scalar_parent_browser_session_restore_worker_restart_count,
    scalar_parent_formautofill_creditcards_fill_type_autofill_modified,
    histogram_content_devtools_netmonitor_opened_count,
    scalar_parent_encoding_override_used,
    scalar_parent_gfx_hdr_windows_display_colorspace_bitfield,
    scalar_parent_corroborate_system_addons_corrupted,
    scalar_parent_pdf_viewer_print,
    scalar_parent_datasanitization_network_cookie_lifetimepolicy,
    scalar_parent_webrtc_peerconnection_promise_and_callback_stats_used,
    scalar_parent_telemetry_about_telemetry_pageload,
    scalar_parent_devtools_changesview_copy,
    scalar_parent_networking_http_connections_captive_portal,
    plugins_infobar_block,
    scalar_parent_browser_errors_collected_with_stack_count,
    histogram_parent_devtools_developertoolbar_opened_count,
    histogram_content_devtools_picker_eyedropper_opened_count,
    histogram_content_devtools_shadereditor_opened_count,
    histogram_content_devtools_paintflashing_opened_count,
    web_notification_shown,
    scalar_parent_media_autoplay_would_be_allowed_count,
    scalar_parent_navigator_storage_persist_count,
    scalar_parent_media_blocked_no_metadata_endup_no_audio_track,
    scalar_parent_devtools_changesview_contextmenu_copy_declaration,
    scalar_parent_webrtc_peerconnection_datachannel_max_retx_used,
    plugins_infobar_dismissed,
    scalar_parent_aushelper_websense_reg_version,
    scalar_parent_browser_feeds_livebookmark_opened,
    histogram_content_devtools_scratchpad_window_opened_count,
    histogram_content_devtools_animationinspector_opened_count,
    histogram_content_devtools_inspector_opened_count,
    scalar_parent_security_tls_delegated_credentials_txn,
    scalar_parent_datasanitization_privacy_clearonshutdown_downloads,
    crashes_detected_content,
    scalar_content_webrtc_peerconnection_connected,
    scalar_parent_browser_usage_graphite,
    scalar_parent_preferences_read_user_js,
    histogram_content_devtools_developertoolbar_opened_count,
    scalar_parent_datasanitization_privacy_clearonshutdown_history,
    scalar_parent_datasanitization_session_permission_exceptions,
    scalar_parent_telemetry_profile_directory_scans,
    histogram_content_devtools_custom_opened_count,
    histogram_content_devtools_menu_eyedropper_opened_count,
    histogram_content_devtools_jsprofiler_opened_count,
    scalar_content_webrtc_hostnameobfuscation_enabled_failed,
    scalar_parent_browser_session_restore_tabbar_restore_available,
    scalar_parent_devtools_onboarding_is_devtools_user,
    scalar_parent_telemetry_profile_directory_scan_date,
    histogram_content_devtools_layoutview_opened_count,
    scalar_parent_identity_fxaccounts_missed_commands_fetched,
    plugins_infobar_allow,
    scalar_content_media_blocked_autoplay_no_audio_track_count,
    scalar_parent_idb_type_temporary_count,
    scalar_parent_preferences_prevent_accessibility_services,
    histogram_content_devtools_webaudioeditor_opened_count,
    histogram_content_devtools_eyedropper_opened_count,
    histogram_content_pwmgr_manage_copied_username,
    user_pref_marionette_enabled,
    scalar_parent_telemetry_ecosystem_old_send_time,
    scalar_content_webrtc_hostnameobfuscation_disabled_failed,
    scalar_parent_webrtc_hostnameobfuscation_enabled_failed,
    scalar_content_navigator_storage_estimate_count,
    scalar_parent_browser_errors_reported_success_count,
    scalar_parent_storage_sync_api_usage_extensions_using,
    histogram_parent_devtools_canvasdebugger_opened_count,
    scalar_parent_media_allowed_autoplay_no_audio_track_count,
    scalar_parent_telemetry_process_creation_timestamp_inconsistent,
    loop_activity_counter,
    scalar_content_browser_feeds_preview_loaded,
    scalar_parent_media_autoplay_would_not_be_allowed_count,
    scalar_parent_media_blocked_no_metadata,
    histogram_content_devtools_jsdebugger_opened_count,
    scalar_parent_webrtc_peerconnection_datachannel_created,
    scalar_parent_webrtc_hostnameobfuscation_disabled_failed,
    scalar_content_webrtc_hostnameobfuscation_enabled_succeeded,
    scalar_parent_datasanitization_privacy_clearonshutdown_cache,
    scalar_parent_browser_session_restore_tabbar_restore_clicked,
    scalar_gpu_browser_usage_graphite,
    scalar_parent_idb_type_persistent_count,
    scalar_parent_webrtc_nicer_stun_retransmits,
    histogram_content_devtools_styleeditor_opened_count,
    histogram_content_devtools_fontinspector_opened_count,
    scalar_parent_devtools_webreplay_reload_recording,
    scalar_parent_devtools_webreplay_save_recording,
    scalar_content_webrtc_peerconnection_datachannel_max_retx_and_life_used,
    scalar_parent_pdf_viewer_fallback_shown,
    scalar_parent_datasanitization_privacy_sanitize_sanitizeonshutdown,
    scalar_parent_datasanitization_privacy_clearonshutdown_formdata,
    scalar_parent_datasanitization_privacy_clearonshutdown_sessions,
    scalar_parent_services_sync_fxa_verification_method,
    scalar_content_idb_type_persistent_count,
    scalar_content_mediarecorder_recording_count,
    scalar_parent_screenshots_upload,
    scalar_parent_telemetry_os_shutting_down,
    histogram_content_devtools_ruleview_opened_count,
    histogram_content_devtools_dom_opened_count,
    scalar_parent_webrtc_hostnameobfuscation_enabled_succeeded,
    scalar_content_webrtc_peerconnection_promise_stats_used,
    scalar_gpu_telemetry_profile_directory_scans,
    scalar_parent_browser_feeds_livebookmark_count,
    scalar_parent_devtools_webreplay_stop_recording,
    scalar_parent_devtools_webreplay_load_recording,
    scalar_parent_corroborate_omnijar_corrupted,
    scalar_parent_pdf_viewer_used,
    scalar_parent_browser_session_restore_number_of_tabs,
    scalar_content_telemetry_profile_directory_scans,
    scalar_content_webrtc_peerconnection_promise_and_callback_stats_used,
    scalar_parent_mediarecorder_recording_count,
    scalar_parent_sw_cors_res_for_so_req_count,
    scalar_parent_telemetry_pending_operations_highwatermark_reached,
    user_pref_privacy_fuzzyfox_enabled,
    scalar_content_memoryreporter_max_ghost_windows,
    scalar_parent_devtools_aboutdevtools_opened,
    scalar_parent_datasanitization_privacy_clearonshutdown_cookies,
    user_pref_extensions_allow_non_mpc_extensions,
    scalar_content_idb_type_temporary_count,
    scalar_content_webrtc_peerconnection_legacy_callback_stats_used,
    scalar_parent_media_page_had_play_revoked_count,
    scalar_parent_webrtc_peerconnection_promise_stats_used,
    histogram_content_devtools_aboutdebugging_opened_count,
    histogram_content_devtools_webconsole_opened_count,
    histogram_content_devtools_browserconsole_opened_count,
    histogram_content_number_of_profiles,
    user_pref_browser_launcherprocess_enabled,
    scalar_parent_webrtc_peerconnection_datachannel_max_life_used,
    scalar_parent_datasanitization_privacy_clearonshutdown_sitesettings,
    scalar_parent_datasanitization_privacy_clearonshutdown_offlineapps,
    scalar_parent_browser_feeds_preview_loaded,
    scalar_parent_devtools_application_opened_count,
    scalar_parent_dom_contentprocess_troubled_due_to_memory,
    scalar_parent_navigator_storage_estimate_count,
    scalar_parent_telemetry_ecosystem_new_send_time,
    active_experiment_branch,
    histogram_content_devtools_webide_opened_count,
    histogram_content_devtools_scratchpad_opened_count,
    scalar_parent_datasanitization_privacy_clearonshutdown_openwindows,
    scalar_parent_browser_usage_plugin_instantiated,
    scalar_parent_telemetry_persistence_timer_hit_count,
    histogram_content_devtools_memory_opened_count,
    scalar_parent_devtools_changesview_contextmenu,
    scalar_parent_webrtc_peerconnection_datachannel_max_retx_and_life_used,
    scalar_parent_browser_session_restore_number_of_win,
    scalar_content_browser_usage_graphite,
    scalar_parent_preferences_created_new_user_prefs_file,
    scalar_content_webrtc_peerconnection_datachannel_max_retx_used,
    scalar_parent_webrtc_hostnameobfuscation_disabled_succeeded,
    push_api_notification_received,
    plugins_notification_user_action,
    user_prefs,
    histogram_parent_devtools_shadereditor_opened_count,
    scalar_parent_devtools_webreplay_new_recording,
    scalar_content_media_autoplay_default_blocked,
    scalar_parent_networking_data_transferred_captive_portal,
    scalar_parent_browser_feeds_feed_subscribed,
    histogram_content_devtools_storage_opened_count,
    histogram_content_devtools_options_opened_count,
    scalar_content_webrtc_hostnameobfuscation_disabled_succeeded,
    scalar_content_navigator_storage_persist_count,
    scalar_parent_browser_errors_collected_count,
    histogram_content_devtools_canvasdebugger_opened_count,
    histogram_content_devtools_jsbrowserdebugger_opened_count,
    scalar_parent_networking_http_transactions_captive_portal,
    scalar_parent_browser_errors_reported_failure_count,
    scalar_parent_devtools_aboutdevtools_installed,
    scalar_parent_preferences_prefs_file_was_invalid,
    scalar_parent_webrtc_peerconnection_connected
  )
FROM
  `moz-fx-data-shared-prod.telemetry.experiments_v1`
~~~~
##[windows_10_build_distribution](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/windows_10_build_distribution)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/windows_10_build_distribution/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.windows_10_build_distribution` AS
WITH
  channel_summary AS (
  SELECT
    normalized_channel,
    build_group,
    max(build_number) AS max_build_number,
    sum(count) AS frequency
  FROM
    `moz-fx-data-shared-prod.telemetry.windows_10_aggregate`
  GROUP BY
    normalized_channel,
    build_group
  ORDER BY
    build_group ASC),
  counts AS (
  SELECT
    normalized_channel,
    sum(frequency) AS total
  FROM
    channel_summary
  GROUP BY
    normalized_channel)
SELECT
  normalized_channel,
  build_group,
  (frequency / total) AS frequency,
  frequency AS `count`
FROM
  channel_summary
INNER JOIN
  counts
USING
  (normalized_channel)
ORDER BY
  max_build_number ASC
~~~~
##[crash_summary_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/crash_summary_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/crash_summary_v1/view.sql)

~~~~sql
-- Query generated by: templates/unnest_parquet_view.sql.py crash_summary_v1 telemetry_derived.crash_summary_v1
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.crash_summary_v1`
AS
SELECT
  * REPLACE (
    experiments.key_value AS experiments,
    (SELECT AS STRUCT payload.* REPLACE (payload.metadata.key_value AS metadata)) AS payload
  )
FROM
  `moz-fx-data-shared-prod.telemetry_derived.crash_summary_v1`
~~~~
##[core_clients_daily_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/core_clients_daily_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/core_clients_daily_v1/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.core_clients_daily_v1`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.core_clients_daily_v1`
~~~~
##[core_clients_daily](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/core_clients_daily)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/core_clients_daily/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.core_clients_daily`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry.core_clients_daily_v1`
~~~~
##[health](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/health)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/health/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.health`
AS
SELECT
  * REPLACE (
    `moz-fx-data-shared-prod.udf.normalize_metadata`(metadata) AS metadata,
    (
      SELECT AS STRUCT
        payload.* REPLACE (
          STRUCT(
            SAFE_CAST(
              JSON_EXTRACT(additional_properties, '$.payload.sendFailure.undefined') AS INT64
            ) AS undefined,
            SAFE_CAST(
              JSON_EXTRACT(additional_properties, '$.payload.sendFailure.timeout') AS INT64
            ) AS timeout,
            SAFE_CAST(
              JSON_EXTRACT(additional_properties, '$.payload.sendFailure.abort') AS INT64
            ) AS abort,
            SAFE_CAST(
              JSON_EXTRACT(additional_properties, '$.payload.sendFailure.eUnreachable') AS INT64
            ) AS e_unreachable,
            SAFE_CAST(
              JSON_EXTRACT(additional_properties, '$.payload.sendFailure.eTerminated') AS INT64
            ) AS e_terminated,
            SAFE_CAST(
              JSON_EXTRACT(additional_properties, '$.payload.sendFailure.eChannelOpen') AS INT64
            ) AS e_channel_open
          ) AS send_failure,
          STRUCT(
            SAFE_CAST(
              JSON_EXTRACT(additional_properties, '$.payload.pingDiscardedForSize.sync') AS INT64
            ) AS sync,
            SAFE_CAST(
              JSON_EXTRACT(additional_properties, '$.payload.pingDiscardedForSize.prio') AS INT64
            ) AS prio,
            SAFE_CAST(
              JSON_EXTRACT(additional_properties, '$.payload.pingDiscardedForSize.main') AS INT64
            ) AS main,
            SAFE_CAST(
              JSON_EXTRACT(additional_properties, '$.payload.pingDiscardedForSize.crash') AS INT64
            ) AS crash,
            SAFE_CAST(
              JSON_EXTRACT(
                additional_properties,
                "$.payload.pingDiscardedForSize['<unknown>']"
              ) AS INT64
            ) AS unknown
          ) AS ping_discarded_for_size
        )
    ) AS payload
  )
FROM
  `moz-fx-data-shared-prod.telemetry_stable.health_v4`
~~~~
##[mobile_event](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/mobile_event)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/mobile_event/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.mobile_event`
AS
SELECT
  * REPLACE (
    -- The pipeline ensures lowercase client_id since 2020-01-10, but we apply
    -- LOWER here to provide continuity for older data that still contains
    -- some uppercase IDs; see https://github.com/mozilla/gcp-ingestion/pull/1069
    LOWER(client_id) AS client_id,
    `moz-fx-data-shared-prod.udf.normalize_metadata`(metadata) AS metadata
  )
FROM
  `moz-fx-data-shared-prod.telemetry_stable.mobile_event_v1`
~~~~
##[core_clients_last_seen_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/core_clients_last_seen_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/core_clients_last_seen_v1/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.core_clients_last_seen_v1`
AS
WITH with_days_since AS (
  SELECT
    mozfun.bits28.days_since_seen(days_seen_bits) AS days_since_seen,
    mozfun.bits28.days_since_seen(days_created_profile_bits) AS days_since_created_profile,
    *
  FROM
    `moz-fx-data-shared-prod.telemetry_derived.core_clients_last_seen_v1`
)
SELECT
  -- Include date_last_seen for compatibility with existing queries.
  DATE_SUB(submission_date, INTERVAL days_since_seen DAY) AS date_last_seen,
  *
FROM
  with_days_since
~~~~
##[firefox_desktop_exact_mau28_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/firefox_desktop_exact_mau28_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/firefox_desktop_exact_mau28_v1/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.firefox_desktop_exact_mau28_v1`
AS
WITH base AS (
  SELECT
    submission_date,
    SUM(mau) AS mau,
    SUM(wau) AS wau,
    SUM(dau) AS dau,
    sum(IF(country IN ('US', 'GB', 'FR', 'DE', 'CA'), mau, 0)) AS tier1_mau,
    sum(IF(country IN ('US', 'GB', 'FR', 'DE', 'CA'), wau, 0)) AS tier1_wau,
    sum(IF(country IN ('US', 'GB', 'FR', 'DE', 'CA'), dau, 0)) AS tier1_dau,
    SUM(visited_5_uri_mau) AS visited_5_uri_mau,
    SUM(visited_5_uri_wau) AS visited_5_uri_wau,
    SUM(visited_5_uri_dau) AS visited_5_uri_dau
  FROM
    `moz-fx-data-shared-prod.telemetry_derived.firefox_desktop_exact_mau28_by_dimensions_v1`
  GROUP BY
    submission_date
),
  -- We use imputed values for the period after the Armag-add-on deletion event;
  -- see https://bugzilla.mozilla.org/show_bug.cgi?id=1552558
imputed_global AS (
  SELECT
    `date` AS submission_date,
    mau
  FROM
    `moz-fx-data-shared-prod.static.firefox_desktop_imputed_mau28_v1`
  WHERE
    datasource = 'desktop_global'
),
    --
imputed_tier1 AS (
  SELECT
    `date` AS submission_date,
    mau
  FROM
    `moz-fx-data-shared-prod.static.firefox_desktop_imputed_mau28_v1`
  WHERE
    datasource = 'desktop_tier1'
)
SELECT
  base.* REPLACE (
    COALESCE(imputed_global.mau, base.mau) AS mau,
    COALESCE(imputed_tier1.mau, base.tier1_mau) AS tier1_mau
  )
FROM
  base
FULL JOIN
  imputed_global
USING
  (submission_date)
FULL JOIN
  imputed_tier1
USING
  (submission_date)
ORDER BY
  submission_date
~~~~
##[addons](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/addons)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/addons/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.addons`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.addons_v2`
~~~~
##[main_summary_v3](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/main_summary_v3)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/main_summary_v3/view.sql)

~~~~sql
-- Query generated by: templates/unnest_parquet_view.sql.py main_summary_v3 telemetry_derived.main_summary_v3
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.main_summary_v3`
AS
SELECT
  submission_date AS submission_date_s3,
  * REPLACE (
    ARRAY(SELECT * FROM UNNEST(active_addons.list)) AS active_addons,
    ARRAY(
      SELECT AS STRUCT
        _0.element.* REPLACE (_0.element.map_values.key_value AS map_values)
      FROM
        UNNEST(events.list) AS _0
    ) AS events,
    popup_notification_stats.key_value AS popup_notification_stats,
    ARRAY(SELECT * FROM UNNEST(search_counts.list)) AS search_counts,
    ssl_handshake_result.key_value AS ssl_handshake_result
  )
FROM
  `moz-fx-data-shared-prod.telemetry_derived.main_summary_v3`
~~~~
##[experiment_enrollment_aggregates_recents](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiment_enrollment_aggregates_recents)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiment_enrollment_aggregates_recents/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.experiment_enrollment_aggregates_recents`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.experiment_enrollment_aggregates_recents_v1`
~~~~
##[main_summary_v4](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/main_summary_v4)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/main_summary_v4/view.sql)

~~~~sql
-- Query generated by: templates/unnest_parquet_view.sql.py main_summary_v4 telemetry_derived.main_summary_v4
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.main_summary_v4`
AS
SELECT
  submission_date AS submission_date_s3,
  * EXCEPT (
    histogram_content_devtools_computedview_opened_count,
    histogram_content_devtools_fontinspector_opened_count,
    histogram_content_devtools_storage_opened_count,
    scalar_parent_datasanitization_privacy_clearOnShutdown_downloads,
    histogram_content_devtools_eyedropper_opened_count,
    histogram_content_devtools_netmonitor_opened_count,
    scalar_parent_pdf_viewer_fallback_shown,
    histogram_content_devtools_paintflashing_opened_count,
    histogram_content_devtools_custom_opened_count,
    histogram_content_devtools_aboutdebugging_opened_count,
    histogram_content_devtools_layoutview_opened_count,
    scalar_parent_telemetry_ecosystem_new_send_time,
    scalar_parent_media_blocked_autoplay_no_audio_track_count,
    push_api_notification_received,
    histogram_content_devtools_jsbrowserdebugger_opened_count,
    scalar_parent_webrtc_peerconnection_datachannel_max_life_used,
    histogram_content_pwmgr_manage_deleted,
    scalar_parent_webrtc_peerconnection_promise_stats_used,
    scalar_content_webrtc_peerconnection_promise_and_callback_stats_used,
    scalar_parent_devtools_aboutdevtools_installed,
    histogram_content_devtools_webide_opened_count,
    histogram_content_devtools_picker_eyedropper_opened_count,
    scalar_parent_devtools_aboutdevtools_opened,
    scalar_parent_datasanitization_privacy_clearOnShutdown_offlineApps,
    scalar_parent_datasanitization_privacy_clearOnShutdown_siteSettings,
    scalar_parent_mediarecorder_recording_count,
    scalar_parent_sw_cors_res_for_so_req_count,
    scalar_parent_telemetry_ecosystem_old_send_time,
    scalar_parent_webrtc_peerconnection_legacy_callback_stats_used,
    scalar_parent_idb_type_temporary_count,
    scalar_gpu_telemetry_profile_directory_scans,
    scalar_parent_telemetry_persistence_timer_hit_count,
    histogram_content_devtools_scratchpad_window_opened_count,
    scalar_parent_datasanitization_privacy_clearOnShutdown_cookies,
    histogram_content_devtools_memory_opened_count,
    scalar_parent_datasanitization_privacy_sanitize_sanitizeOnShutdown,
    histogram_content_devtools_webaudioeditor_opened_count,
    scalar_content_webrtc_peerconnection_datachannel_max_retx_and_life_used,
    scalar_parent_webrtc_hostnameobfuscation_disabled_failed,
    histogram_content_devtools_jsdebugger_opened_count,
    scalar_parent_webrtc_peerconnection_datachannel_max_retx_used,
    scalar_gpu_browser_usage_graphite,
    histogram_content_pwmgr_manage_copied_password,
    scalar_parent_browser_errors_sample_rate,
    scalar_parent_webrtc_hostnameobfuscation_enabled_succeeded,
    scalar_parent_datasanitization_privacy_clearOnShutdown_openWindows,
    scalar_parent_devtools_aboutdevtools_noinstall_exits,
    scalar_parent_datasanitization_privacy_clearOnShutdown_sessions,
    scalar_parent_webrtc_peerconnection_connected,
    scalar_content_webrtc_peerconnection_datachannel_max_retx_used,
    scalar_parent_webrtc_hostnameobfuscation_disabled_succeeded,
    scalar_parent_datasanitization_session_permission_exceptions,
    scalar_content_telemetry_profile_directory_scans,
    histogram_content_devtools_developertoolbar_opened_count,
    histogram_content_pwmgr_manage_copied_username,
    scalar_parent_telemetry_process_creation_timestamp_inconsistent,
    scalar_content_idb_type_temporary_count,
    scalar_parent_webrtc_peerconnection_datachannel_max_retx_and_life_used,
    scalar_parent_telemetry_pending_operations_highwatermark_reached,
    histogram_content_devtools_inspector_opened_count,
    histogram_content_number_of_profiles,
    scalar_content_media_autoplay_default_blocked,
    scalar_parent_devtools_application_opened_count,
    histogram_content_devtools_shadereditor_opened_count,
    scalar_parent_devtools_webreplay_save_recording,
    histogram_content_devtools_animationinspector_opened_count,
    histogram_content_devtools_dom_opened_count,
    histogram_content_devtools_styleeditor_opened_count,
    scalar_parent_webrtc_hostnameobfuscation_enabled_failed,
    histogram_content_devtools_ruleview_opened_count,
    scalar_parent_webrtc_peerconnection_promise_and_callback_stats_used,
    histogram_content_devtools_options_opened_count,
    scalar_parent_datasanitization_privacy_clearOnShutdown_cache,
    scalar_parent_datasanitization_privacy_clearOnShutdown_formdata,
    scalar_content_webrtc_peerconnection_legacy_callback_stats_used,
    histogram_content_devtools_responsive_opened_count,
    loop_activity_counter,
    scalar_parent_pdf_viewer_print,
    scalar_parent_browser_session_restore_tabbar_restore_clicked,
    histogram_content_devtools_webconsole_opened_count,
    histogram_content_devtools_scratchpad_opened_count,
    scalar_parent_datasanitization_privacy_clearOnShutdown_history,
    user_pref_browser_launcherprocess_enabled,
    histogram_content_devtools_canvasdebugger_opened_count,
    scalar_content_telemetry_process_creation_timestamp_inconsistent,
    scalar_content_sw_cors_res_for_so_req_count,
    scalar_parent_datasanitization_network_cookie_lifetimePolicy,
    scalar_content_media_blocked_autoplay_no_audio_track_count,
    histogram_content_devtools_jsprofiler_opened_count
  ) REPLACE(
    histogram_content_cert_validation_success_by_ca.list AS histogram_content_cert_validation_success_by_ca,
    histogram_content_checkerboard_severity.list AS histogram_content_checkerboard_severity,
    histogram_content_composite_time.list AS histogram_content_composite_time,
    histogram_content_content_paint_time.list AS histogram_content_content_paint_time,
    histogram_content_cycle_collector_max_pause.list AS histogram_content_cycle_collector_max_pause,
    histogram_content_devtools_accessibility_picker_time_active_seconds.list AS histogram_content_devtools_accessibility_picker_time_active_seconds,
    histogram_content_devtools_accessibility_service_time_active_seconds.list AS histogram_content_devtools_accessibility_service_time_active_seconds,
    histogram_content_devtools_accessibility_time_active_seconds.list AS histogram_content_devtools_accessibility_time_active_seconds,
    histogram_content_devtools_toolbox_time_active_seconds.list AS histogram_content_devtools_toolbox_time_active_seconds,
    histogram_content_fx_new_window_ms.list AS histogram_content_fx_new_window_ms,
    histogram_content_fx_page_load_ms_2.list AS histogram_content_fx_page_load_ms_2,
    histogram_content_fx_searchbar_selected_result_method.list AS histogram_content_fx_searchbar_selected_result_method,
    histogram_content_fx_session_restore_restore_window_ms.list AS histogram_content_fx_session_restore_restore_window_ms,
    histogram_content_fx_session_restore_startup_init_session_ms.list AS histogram_content_fx_session_restore_startup_init_session_ms,
    histogram_content_fx_session_restore_startup_onload_initial_window_ms.list AS histogram_content_fx_session_restore_startup_onload_initial_window_ms,
    histogram_content_fx_tab_close_time_anim_ms.list AS histogram_content_fx_tab_close_time_anim_ms,
    histogram_content_fx_tab_switch_update_ms.list AS histogram_content_fx_tab_switch_update_ms,
    histogram_content_fx_urlbar_selected_result_index.list AS histogram_content_fx_urlbar_selected_result_index,
    histogram_content_fx_urlbar_selected_result_index_by_type.list AS histogram_content_fx_urlbar_selected_result_index_by_type,
    histogram_content_fx_urlbar_selected_result_method.list AS histogram_content_fx_urlbar_selected_result_method,
    histogram_content_fx_urlbar_selected_result_type.list AS histogram_content_fx_urlbar_selected_result_type,
    histogram_content_gc_animation_ms.list AS histogram_content_gc_animation_ms,
    histogram_content_gc_max_pause_ms.list AS histogram_content_gc_max_pause_ms,
    histogram_content_gc_max_pause_ms_2.list AS histogram_content_gc_max_pause_ms_2,
    histogram_content_geolocation_request_granted.list AS histogram_content_geolocation_request_granted,
    histogram_content_ghost_windows.list AS histogram_content_ghost_windows,
    histogram_content_gpu_process_initialization_time_ms.list AS histogram_content_gpu_process_initialization_time_ms,
    histogram_content_gpu_process_launch_time_ms_2.list AS histogram_content_gpu_process_launch_time_ms_2,
    histogram_content_http_channel_disposition.list AS histogram_content_http_channel_disposition,
    histogram_content_http_pageload_is_ssl.list AS histogram_content_http_pageload_is_ssl,
    histogram_content_http_transaction_is_ssl.list AS histogram_content_http_transaction_is_ssl,
    histogram_content_input_event_response_coalesced_ms.list AS histogram_content_input_event_response_coalesced_ms,
    histogram_content_ipc_read_main_thread_latency_ms.list AS histogram_content_ipc_read_main_thread_latency_ms,
    histogram_content_memory_distribution_among_content.list AS histogram_content_memory_distribution_among_content,
    histogram_content_memory_heap_allocated.list AS histogram_content_memory_heap_allocated,
    histogram_content_memory_resident_fast.list AS histogram_content_memory_resident_fast,
    histogram_content_memory_total.list AS histogram_content_memory_total,
    histogram_content_memory_unique.list AS histogram_content_memory_unique,
    histogram_content_memory_unique_content_startup.list AS histogram_content_memory_unique_content_startup,
    histogram_content_memory_vsize.list AS histogram_content_memory_vsize,
    histogram_content_memory_vsize_max_contiguous.list AS histogram_content_memory_vsize_max_contiguous,
    histogram_content_network_cache_metadata_first_read_time_ms.list AS histogram_content_network_cache_metadata_first_read_time_ms,
    histogram_content_network_cache_v2_hit_time_ms.list AS histogram_content_network_cache_v2_hit_time_ms,
    histogram_content_network_cache_v2_miss_time_ms.list AS histogram_content_network_cache_v2_miss_time_ms,
    histogram_content_places_autocomplete_6_first_results_time_ms.list AS histogram_content_places_autocomplete_6_first_results_time_ms,
    histogram_content_plugin_shutdown_ms.list AS histogram_content_plugin_shutdown_ms,
    histogram_content_pwmgr_form_autofill_result.list AS histogram_content_pwmgr_form_autofill_result,
    histogram_content_pwmgr_login_page_safety.list AS histogram_content_pwmgr_login_page_safety,
    histogram_content_sandbox_rejected_syscalls.list AS histogram_content_sandbox_rejected_syscalls,
    histogram_content_search_reset_result.list AS histogram_content_search_reset_result,
    histogram_content_search_service_init_ms.list AS histogram_content_search_service_init_ms,
    histogram_content_ssl_handshake_result.list AS histogram_content_ssl_handshake_result,
    histogram_content_ssl_handshake_version.list AS histogram_content_ssl_handshake_version,
    histogram_content_ssl_tls12_intolerance_reason_pre.list AS histogram_content_ssl_tls12_intolerance_reason_pre,
    histogram_content_ssl_tls13_intolerance_reason_pre.list AS histogram_content_ssl_tls13_intolerance_reason_pre,
    histogram_content_time_to_dom_complete_ms.list AS histogram_content_time_to_dom_complete_ms,
    histogram_content_time_to_dom_content_loaded_end_ms.list AS histogram_content_time_to_dom_content_loaded_end_ms,
    histogram_content_time_to_dom_content_loaded_start_ms.list AS histogram_content_time_to_dom_content_loaded_start_ms,
    histogram_content_time_to_dom_interactive_ms.list AS histogram_content_time_to_dom_interactive_ms,
    histogram_content_time_to_dom_loading_ms.list AS histogram_content_time_to_dom_loading_ms,
    histogram_content_time_to_first_click_ms.list AS histogram_content_time_to_first_click_ms,
    histogram_content_time_to_first_interaction_ms.list AS histogram_content_time_to_first_interaction_ms,
    histogram_content_time_to_first_key_input_ms.list AS histogram_content_time_to_first_key_input_ms,
    histogram_content_time_to_first_mouse_move_ms.list AS histogram_content_time_to_first_mouse_move_ms,
    histogram_content_time_to_first_scroll_ms.list AS histogram_content_time_to_first_scroll_ms,
    histogram_content_time_to_load_event_end_ms.list AS histogram_content_time_to_load_event_end_ms,
    histogram_content_time_to_load_event_start_ms.list AS histogram_content_time_to_load_event_start_ms,
    histogram_content_time_to_non_blank_paint_ms.list AS histogram_content_time_to_non_blank_paint_ms,
    histogram_content_time_to_response_start_ms.list AS histogram_content_time_to_response_start_ms,
    histogram_content_tracking_protection_enabled.list AS histogram_content_tracking_protection_enabled,
    histogram_content_uptake_remote_content_result_1.list AS histogram_content_uptake_remote_content_result_1,
    histogram_content_webext_content_script_injection_ms.list AS histogram_content_webext_content_script_injection_ms,
    histogram_content_webext_storage_local_get_ms.list AS histogram_content_webext_storage_local_get_ms,
    histogram_content_webext_storage_local_set_ms.list AS histogram_content_webext_storage_local_set_ms,
    histogram_content_webvr_time_spent_viewing_in_2d.list AS histogram_content_webvr_time_spent_viewing_in_2d,
    histogram_content_webvr_users_view_in.list AS histogram_content_webvr_users_view_in,
    histogram_gpu_checkerboard_severity.list AS histogram_gpu_checkerboard_severity,
    histogram_gpu_composite_time.list AS histogram_gpu_composite_time,
    histogram_gpu_content_frame_time.list AS histogram_gpu_content_frame_time,
    histogram_gpu_gpu_process_initialization_time_ms.list AS histogram_gpu_gpu_process_initialization_time_ms,
    histogram_gpu_ipc_read_main_thread_latency_ms.list AS histogram_gpu_ipc_read_main_thread_latency_ms,
    histogram_gpu_uptake_remote_content_result_1.list AS histogram_gpu_uptake_remote_content_result_1,
    histogram_gpu_webvr_time_spent_viewing_in_oculus.list AS histogram_gpu_webvr_time_spent_viewing_in_oculus,
    histogram_gpu_webvr_time_spent_viewing_in_openvr.list AS histogram_gpu_webvr_time_spent_viewing_in_openvr,
    histogram_gpu_webvr_users_view_in.list AS histogram_gpu_webvr_users_view_in,
    histogram_parent_a11y_consumers.list AS histogram_parent_a11y_consumers,
    histogram_parent_a11y_instantiated_flag.list AS histogram_parent_a11y_instantiated_flag,
    histogram_parent_cert_validation_success_by_ca.list AS histogram_parent_cert_validation_success_by_ca,
    histogram_parent_checkerboard_severity.list AS histogram_parent_checkerboard_severity,
    histogram_parent_composite_time.list AS histogram_parent_composite_time,
    histogram_parent_content_frame_time.list AS histogram_parent_content_frame_time,
    histogram_parent_content_paint_time.list AS histogram_parent_content_paint_time,
    histogram_parent_cookie_behavior.list AS histogram_parent_cookie_behavior,
    histogram_parent_cycle_collector_max_pause.list AS histogram_parent_cycle_collector_max_pause,
    histogram_parent_devtools_about_devtools_opened_key.list AS histogram_parent_devtools_about_devtools_opened_key,
    histogram_parent_devtools_about_devtools_opened_reason.list AS histogram_parent_devtools_about_devtools_opened_reason,
    histogram_parent_devtools_accessibility_picker_time_active_seconds.list AS histogram_parent_devtools_accessibility_picker_time_active_seconds,
    histogram_parent_devtools_accessibility_service_time_active_seconds.list AS histogram_parent_devtools_accessibility_service_time_active_seconds,
    histogram_parent_devtools_accessibility_time_active_seconds.list AS histogram_parent_devtools_accessibility_time_active_seconds,
    histogram_parent_devtools_entry_point.list AS histogram_parent_devtools_entry_point,
    histogram_parent_devtools_fonteditor_font_type_displayed.list AS histogram_parent_devtools_fonteditor_font_type_displayed,
    histogram_parent_devtools_fonteditor_n_font_axes.list AS histogram_parent_devtools_fonteditor_n_font_axes,
    histogram_parent_devtools_fonteditor_n_fonts_rendered.list AS histogram_parent_devtools_fonteditor_n_fonts_rendered,
    histogram_parent_devtools_toolbox_time_active_seconds.list AS histogram_parent_devtools_toolbox_time_active_seconds,
    histogram_parent_dns_failed_lookup_time.list AS histogram_parent_dns_failed_lookup_time,
    histogram_parent_dns_lookup_time.list AS histogram_parent_dns_lookup_time,
    histogram_parent_fx_new_window_ms.list AS histogram_parent_fx_new_window_ms,
    histogram_parent_fx_page_load_ms_2.list AS histogram_parent_fx_page_load_ms_2,
    histogram_parent_fx_searchbar_selected_result_method.list AS histogram_parent_fx_searchbar_selected_result_method,
    histogram_parent_fx_session_restore_restore_window_ms.list AS histogram_parent_fx_session_restore_restore_window_ms,
    histogram_parent_fx_session_restore_startup_init_session_ms.list AS histogram_parent_fx_session_restore_startup_init_session_ms,
    histogram_parent_fx_session_restore_startup_onload_initial_window_ms.list AS histogram_parent_fx_session_restore_startup_onload_initial_window_ms,
    histogram_parent_fx_tab_close_time_anim_ms.list AS histogram_parent_fx_tab_close_time_anim_ms,
    histogram_parent_fx_tab_switch_total_e10s_ms.list AS histogram_parent_fx_tab_switch_total_e10s_ms,
    histogram_parent_fx_tab_switch_update_ms.list AS histogram_parent_fx_tab_switch_update_ms,
    histogram_parent_fx_urlbar_selected_result_index.list AS histogram_parent_fx_urlbar_selected_result_index,
    histogram_parent_fx_urlbar_selected_result_index_by_type.list AS histogram_parent_fx_urlbar_selected_result_index_by_type,
    histogram_parent_fx_urlbar_selected_result_method.list AS histogram_parent_fx_urlbar_selected_result_method,
    histogram_parent_fx_urlbar_selected_result_type.list AS histogram_parent_fx_urlbar_selected_result_type,
    histogram_parent_gc_animation_ms.list AS histogram_parent_gc_animation_ms,
    histogram_parent_gc_max_pause_ms.list AS histogram_parent_gc_max_pause_ms,
    histogram_parent_gc_max_pause_ms_2.list AS histogram_parent_gc_max_pause_ms_2,
    histogram_parent_geolocation_request_granted.list AS histogram_parent_geolocation_request_granted,
    histogram_parent_ghost_windows.list AS histogram_parent_ghost_windows,
    histogram_parent_gpu_process_initialization_time_ms.list AS histogram_parent_gpu_process_initialization_time_ms,
    histogram_parent_gpu_process_launch_time_ms_2.list AS histogram_parent_gpu_process_launch_time_ms_2,
    histogram_parent_http_channel_disposition.list AS histogram_parent_http_channel_disposition,
    histogram_parent_http_pageload_is_ssl.list AS histogram_parent_http_pageload_is_ssl,
    histogram_parent_http_transaction_is_ssl.list AS histogram_parent_http_transaction_is_ssl,
    histogram_parent_input_event_response_coalesced_ms.list AS histogram_parent_input_event_response_coalesced_ms,
    histogram_parent_ipc_read_main_thread_latency_ms.list AS histogram_parent_ipc_read_main_thread_latency_ms,
    histogram_parent_memory_distribution_among_content.list AS histogram_parent_memory_distribution_among_content,
    histogram_parent_memory_heap_allocated.list AS histogram_parent_memory_heap_allocated,
    histogram_parent_memory_resident_fast.list AS histogram_parent_memory_resident_fast,
    histogram_parent_memory_total.list AS histogram_parent_memory_total,
    histogram_parent_memory_unique.list AS histogram_parent_memory_unique,
    histogram_parent_memory_vsize.list AS histogram_parent_memory_vsize,
    histogram_parent_memory_vsize_max_contiguous.list AS histogram_parent_memory_vsize_max_contiguous,
    histogram_parent_network_cache_metadata_first_read_time_ms.list AS histogram_parent_network_cache_metadata_first_read_time_ms,
    histogram_parent_network_cache_v2_hit_time_ms.list AS histogram_parent_network_cache_v2_hit_time_ms,
    histogram_parent_network_cache_v2_miss_time_ms.list AS histogram_parent_network_cache_v2_miss_time_ms,
    histogram_parent_places_autocomplete_6_first_results_time_ms.list AS histogram_parent_places_autocomplete_6_first_results_time_ms,
    histogram_parent_plugin_shutdown_ms.list AS histogram_parent_plugin_shutdown_ms,
    histogram_parent_pwmgr_blocklist_num_sites.list AS histogram_parent_pwmgr_blocklist_num_sites,
    histogram_parent_pwmgr_form_autofill_result.list AS histogram_parent_pwmgr_form_autofill_result,
    histogram_parent_pwmgr_login_last_used_days.list AS histogram_parent_pwmgr_login_last_used_days,
    histogram_parent_pwmgr_login_page_safety.list AS histogram_parent_pwmgr_login_page_safety,
    histogram_parent_pwmgr_manage_opened.list AS histogram_parent_pwmgr_manage_opened,
    histogram_parent_pwmgr_manage_visibility_toggled.list AS histogram_parent_pwmgr_manage_visibility_toggled,
    histogram_parent_pwmgr_num_passwords_per_hostname.list AS histogram_parent_pwmgr_num_passwords_per_hostname,
    histogram_parent_pwmgr_num_saved_passwords.list AS histogram_parent_pwmgr_num_saved_passwords,
    histogram_parent_pwmgr_prompt_remember_action.list AS histogram_parent_pwmgr_prompt_remember_action,
    histogram_parent_pwmgr_prompt_update_action.list AS histogram_parent_pwmgr_prompt_update_action,
    histogram_parent_pwmgr_saving_enabled.list AS histogram_parent_pwmgr_saving_enabled,
    histogram_parent_sandbox_rejected_syscalls.list AS histogram_parent_sandbox_rejected_syscalls,
    histogram_parent_search_reset_result.list AS histogram_parent_search_reset_result,
    histogram_parent_search_service_init_ms.list AS histogram_parent_search_service_init_ms,
    histogram_parent_ssl_handshake_result.list AS histogram_parent_ssl_handshake_result,
    histogram_parent_ssl_handshake_version.list AS histogram_parent_ssl_handshake_version,
    histogram_parent_ssl_tls12_intolerance_reason_pre.list AS histogram_parent_ssl_tls12_intolerance_reason_pre,
    histogram_parent_ssl_tls13_intolerance_reason_pre.list AS histogram_parent_ssl_tls13_intolerance_reason_pre,
    histogram_parent_time_to_first_click_ms.list AS histogram_parent_time_to_first_click_ms,
    histogram_parent_time_to_first_interaction_ms.list AS histogram_parent_time_to_first_interaction_ms,
    histogram_parent_time_to_first_key_input_ms.list AS histogram_parent_time_to_first_key_input_ms,
    histogram_parent_time_to_first_mouse_move_ms.list AS histogram_parent_time_to_first_mouse_move_ms,
    histogram_parent_time_to_first_scroll_ms.list AS histogram_parent_time_to_first_scroll_ms,
    histogram_parent_time_to_non_blank_paint_ms.list AS histogram_parent_time_to_non_blank_paint_ms,
    histogram_parent_time_to_response_start_ms.list AS histogram_parent_time_to_response_start_ms,
    histogram_parent_touch_enabled_device.list AS histogram_parent_touch_enabled_device,
    histogram_parent_tracking_protection_enabled.list AS histogram_parent_tracking_protection_enabled,
    histogram_parent_update_bits_result_complete.list AS histogram_parent_update_bits_result_complete,
    histogram_parent_update_bits_result_partial.list AS histogram_parent_update_bits_result_partial,
    histogram_parent_update_can_use_bits_notify.list AS histogram_parent_update_can_use_bits_notify,
    histogram_parent_update_download_code_complete.list AS histogram_parent_update_download_code_complete,
    histogram_parent_update_download_code_partial.list AS histogram_parent_update_download_code_partial,
    histogram_parent_update_state_code_complete_stage.list AS histogram_parent_update_state_code_complete_stage,
    histogram_parent_update_state_code_complete_startup.list AS histogram_parent_update_state_code_complete_startup,
    histogram_parent_update_state_code_partial_stage.list AS histogram_parent_update_state_code_partial_stage,
    histogram_parent_update_state_code_partial_startup.list AS histogram_parent_update_state_code_partial_startup,
    histogram_parent_update_status_error_code_complete_stage.list AS histogram_parent_update_status_error_code_complete_stage,
    histogram_parent_update_status_error_code_complete_startup.list AS histogram_parent_update_status_error_code_complete_startup,
    histogram_parent_update_status_error_code_partial_stage.list AS histogram_parent_update_status_error_code_partial_stage,
    histogram_parent_update_status_error_code_partial_startup.list AS histogram_parent_update_status_error_code_partial_startup,
    histogram_parent_uptake_remote_content_result_1.list AS histogram_parent_uptake_remote_content_result_1,
    histogram_parent_webext_background_page_load_ms.list AS histogram_parent_webext_background_page_load_ms,
    histogram_parent_webext_browseraction_popup_open_ms.list AS histogram_parent_webext_browseraction_popup_open_ms,
    histogram_parent_webext_browseraction_popup_preload_result_count.list AS histogram_parent_webext_browseraction_popup_preload_result_count,
    histogram_parent_webext_content_script_injection_ms.list AS histogram_parent_webext_content_script_injection_ms,
    histogram_parent_webext_extension_startup_ms.list AS histogram_parent_webext_extension_startup_ms,
    histogram_parent_webext_pageaction_popup_open_ms.list AS histogram_parent_webext_pageaction_popup_open_ms,
    histogram_parent_webext_storage_local_get_ms.list AS histogram_parent_webext_storage_local_get_ms,
    histogram_parent_webext_storage_local_set_ms.list AS histogram_parent_webext_storage_local_set_ms,
    histogram_parent_webvr_time_spent_viewing_in_2d.list AS histogram_parent_webvr_time_spent_viewing_in_2d,
    histogram_parent_webvr_time_spent_viewing_in_oculus.list AS histogram_parent_webvr_time_spent_viewing_in_oculus,
    histogram_parent_webvr_time_spent_viewing_in_openvr.list AS histogram_parent_webvr_time_spent_viewing_in_openvr,
    histogram_parent_webvr_users_view_in.list AS histogram_parent_webvr_users_view_in
  )
FROM
  `moz-fx-data-shared-prod.telemetry_derived.main_summary_v4`
~~~~
##[main_1pct](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/main_1pct)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/main_1pct/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.main_1pct`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.main_1pct_v1`
~~~~
##[addons_v2](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/addons_v2)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/addons_v2/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.addons_v2`
AS
SELECT
  submission_date AS submission_date_s3,
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.addons_v2`
~~~~
##[experiments_aggregates_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiments_aggregates_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiments_aggregates_v1/view.sql)

~~~~sql
-- Query generated by: templates/unnest_parquet_view.sql.py experiments_aggregates_v1 telemetry_derived.experiments_aggregates_v1
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.experiments_aggregates_v1`
AS
SELECT
  * REPLACE (
    histogram.key_value AS histogram,
    ARRAY(SELECT * FROM UNNEST(statistics.list)) AS statistics
  )
FROM
  `moz-fx-data-shared-prod.telemetry_derived.experiments_aggregates_v1`
~~~~
##[core_clients_last_seen](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/core_clients_last_seen)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/core_clients_last_seen/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.core_clients_last_seen`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry.core_clients_last_seen_v1`
~~~~
##[telemetry_focus_event_parquet](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_focus_event_parquet)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_focus_event_parquet/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.telemetry_focus_event_parquet`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry.telemetry_focus_event_parquet_v1`
~~~~
##[windows_10_patch_adoption](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/windows_10_patch_adoption)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/windows_10_patch_adoption/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.windows_10_patch_adoption` AS
SELECT
  CAST(ubr AS int64) AS numeric_windows_ubr,
  build_number,
  ubr AS label,
  SUM(count) AS frequency
FROM
  `moz-fx-data-shared-prod.telemetry.windows_10_aggregate`
GROUP BY
  numeric_windows_ubr,
  build_number,
  label
ORDER BY
  numeric_windows_ubr ASC
~~~~
##[clients_scalar_aggregates_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/clients_scalar_aggregates_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/clients_scalar_aggregates_v1/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.clients_scalar_aggregates`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.clients_scalar_aggregates_v1`
~~~~
##[ssl_ratios_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/ssl_ratios_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/ssl_ratios_v1/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.ssl_ratios_v1`
AS
WITH windowed AS (
  SELECT
    *,
    SUM(ssl_loads) OVER w1 + SUM(non_ssl_loads) OVER w1 AS total_loads
  FROM
    `moz-fx-data-shared-prod.telemetry_derived.ssl_ratios_v1`
  WINDOW
    w1 AS (
      ORDER BY
        submission_date
      ROWS BETWEEN
        UNBOUNDED PRECEDING
        AND UNBOUNDED FOLLOWING
    )
)
SELECT
  submission_date,
  os,
  country,
  -- ratio of pings that have the probe
  reporting_ratio,
  -- normalized count of pageloads that went into this ratio
  (non_ssl_loads + ssl_loads) / total_loads AS normalized_pageloads,
  ssl_loads / (non_ssl_loads + ssl_loads) AS ratio
FROM
  windowed
WHERE
  non_ssl_loads + ssl_loads > 5000
~~~~
##[telemetry_new_profile_parquet_v2](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_new_profile_parquet_v2)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_new_profile_parquet_v2/view.sql)

~~~~sql
-- Query generated by: templates/unnest_parquet_view.sql.py telemetry_new_profile_parquet_v2 telemetry_derived.telemetry_new_profile_parquet_v2
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.telemetry_new_profile_parquet_v2` AS
SELECT
  submission_date AS submission,
  * REPLACE (
    (SELECT AS STRUCT environment.* REPLACE ((SELECT AS STRUCT environment.partner.* REPLACE (ARRAY(SELECT * FROM UNNEST(environment.partner.partner_names.list)) AS partner_names)) AS partner)) AS environment
  )
FROM
  `moz-fx-data-shared-prod.telemetry_derived.telemetry_new_profile_parquet_v2`
~~~~
##[socorro_crash](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/socorro_crash)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/socorro_crash/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.socorro_crash`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry.socorro_crash_v2`
~~~~
##[experiment_search_aggregates_recents](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiment_search_aggregates_recents)
##[clients_daily_histogram_aggregates_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/clients_daily_histogram_aggregates_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/clients_daily_histogram_aggregates_v1/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.clients_daily_histogram_aggregates`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.clients_daily_histogram_aggregates_v1`
~~~~
##[devtools_panel_usage](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/devtools_panel_usage)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/devtools_panel_usage/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.devtools_panel_usage`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.devtools_panel_usage_v1`
~~~~
##[firefox_nondesktop_day_2_7_activation](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/firefox_nondesktop_day_2_7_activation)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/firefox_nondesktop_day_2_7_activation/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.firefox_nondesktop_day_2_7_activation`
AS
SELECT
  DATE_SUB(submission_date, INTERVAL 6 DAY) AS cohort_date,
  * EXCEPT (submission_date)
FROM
  `moz-fx-data-shared-prod.telemetry_derived.firefox_nondesktop_day_2_7_activation_v1`
~~~~
##[desktop_retention_1_week](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/desktop_retention_1_week)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/desktop_retention_1_week/metadata.yaml)

**Friendly name**: Desktop 1-Week Retention

**Description**: Among profiles that were active at least once in the week starting on the specified day (days 0 through 6), whether each profile is active during the following week (days 7 through 13). This based on https://docs.telemetry.mozilla.org/cookbooks/retention.html#1-week-retention for the usage criterion "Any Firefox Activity" on Firefox (Desktop)


**Owners**: [dthorn@mozilla.com](mailto:dthorn@mozilla.com),[jklukas@mozilla.com](mailto:jklukas@mozilla.com)

### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/desktop_retention_1_week/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.desktop_retention_1_week`
AS
SELECT
  client_id,
  sample_id,
  DATE_SUB(submission_date, INTERVAL 13 DAY) AS `date`,
  -- active week 1
  `moz-fx-data-shared-prod`.udf.active_n_weeks_ago(days_seen_bits, 0) AS retained,
FROM
  `moz-fx-data-shared-prod.telemetry.clients_last_seen`
WHERE
  -- active week 0
  `moz-fx-data-shared-prod`.udf.active_n_weeks_ago(days_seen_bits, 1)
~~~~
##[fenix_events_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/fenix_events_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/fenix_events_v1/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
    `moz-fx-data-shared-prod.telemetry.fenix_events_v1` AS
SELECT
    submission_timestamp,
    client_info.client_id AS device_id,
    CONCAT(document_id, CAST(event.timestamp AS STRING)) AS insert_id,
    CONCAT(event.category, '.', event.name) AS event_type,
    TIMESTAMP_ADD(PARSE_TIMESTAMP('%Y-%m-%dT%H:%M%Ez', ping_info.start_time), INTERVAL event.timestamp SECOND) AS timestamp,
    client_info.app_display_version AS app_version,
    client_info.os AS platform,
    client_info.os AS os_name,
    client_info.os_version AS os_version,
    client_info.device_manufacturer AS device_manufacturer,
    client_info.device_model AS device_model,
    metadata.geo.country AS country,
    metadata.geo.subdivision1 AS region,
    metadata.geo.city AS city,
    ( -- direct insert of `udf.kv_array_to_json_string`, for use in a view
      SELECT CONCAT(
        '{',
        ARRAY_TO_STRING(
            ARRAY_AGG(CONCAT('"', CAST(key AS STRING), '":"', CAST(value AS STRING), '"')),
            ","),
        '}')
      FROM
        UNNEST(event.extra)
    ) AS event_properties,
    TO_JSON_STRING(
      STRUCT(client_info.architecture AS arch)
    ) AS user_properties
FROM
    `moz-fx-data-shared-prod.org_mozilla_fenix_stable.events_v1`
CROSS JOIN
    UNNEST(events) AS event
~~~~
##[telemetry_ip_privacy_parquet_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_ip_privacy_parquet_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_ip_privacy_parquet_v1/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.telemetry_ip_privacy_parquet_v1` AS
SELECT
  submission_date AS submission_date_s3,
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.telemetry_ip_privacy_parquet_v1`
~~~~
##[active_profiles](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/active_profiles)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/active_profiles/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.active_profiles`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.active_profiles_v1`
~~~~
##[telemetry_core_parquet](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_core_parquet)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_core_parquet/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.telemetry_core_parquet`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry.telemetry_core_parquet_v3`
~~~~
##[socorro_crash_v2](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/socorro_crash_v2)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/socorro_crash_v2/view.sql)

~~~~sql
-- Query generated by: templates/unnest_parquet_view.sql.py socorro_crash_v2 telemetry_derived.socorro_crash_v2
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.socorro_crash_v2`
AS
SELECT
  * REPLACE (
    ARRAY(SELECT * FROM UNNEST(additional_minidumps.list)) AS additional_minidumps,
    ARRAY(SELECT * FROM UNNEST(addons.list)) AS addons,
    (
      SELECT AS STRUCT
        json_dump.* REPLACE (
          (
            SELECT AS STRUCT
              json_dump.crashing_thread.* REPLACE (
                ARRAY(SELECT * FROM UNNEST(json_dump.crashing_thread.frames.list)) AS frames
              )
          ) AS crashing_thread,
          ARRAY(SELECT * FROM UNNEST(json_dump.modules.list)) AS modules,
          ARRAY(
            SELECT AS STRUCT
              _0.element.* REPLACE (ARRAY(SELECT * FROM UNNEST(_0.element.frames.list)) AS frames)
            FROM
              UNNEST(json_dump.threads.list) AS _0
          ) AS threads
        )
    ) AS json_dump,
    (
      SELECT AS STRUCT
        memory_report.* REPLACE (ARRAY(SELECT * FROM UNNEST(memory_report.reports.list)) AS reports)
    ) AS memory_report
  )
FROM
  `moz-fx-data-shared-prod.telemetry_derived.socorro_crash_v2`
~~~~
##[nondesktop_clients_last_seen_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/nondesktop_clients_last_seen_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/nondesktop_clients_last_seen_v1/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.nondesktop_clients_last_seen_v1`
AS
WITH glean_final AS (
  SELECT
    *
  FROM
    `moz-fx-data-shared-prod.telemetry.fenix_clients_last_seen`
  UNION ALL
  SELECT
    *,
    'Lockwise Baseline' AS app_name,
  FROM
    `moz-fx-data-shared-prod.mozilla_lockbox.baseline_clients_last_seen`
  UNION ALL
  SELECT
    *,
    'Lockwise Baseline' AS app_name,
  FROM
    `moz-fx-data-shared-prod.org_mozilla_ios_lockbox.baseline_clients_last_seen`
  UNION ALL
  SELECT
    *,
    'Reference Browser Baseline' AS app_name,
  FROM
    `moz-fx-data-shared-prod.org_mozilla_reference_browser.baseline_clients_last_seen`
  UNION ALL
  SELECT
    *,
    'Firefox TV Baseline' AS app_name,
  FROM
    `moz-fx-data-shared-prod.org_mozilla_tv_firefox.baseline_clients_last_seen`
  UNION ALL
  SELECT
    *,
    'VR Browser Baseline' AS app_name,
  FROM
    `moz-fx-data-shared-prod.org_mozilla_vrbrowser.baseline_clients_last_seen`
)
SELECT
  submission_date,
  client_id,
  days_seen_bits,
  days_since_seen,
  days_created_profile_bits,
  days_since_created_profile,
  app_name,
  os,
  osversion AS os_version,
  normalized_channel,
  campaign,
  country,
  locale,
  distribution_id,
  metadata_app_version AS app_version,
  mozfun.norm.product_info(app_name, os).*,
FROM
  `moz-fx-data-shared-prod.telemetry.core_clients_last_seen`
UNION ALL
SELECT
  submission_date,
  client_id,
  days_seen_bits,
  days_since_seen,
  days_created_profile_bits,
  days_since_created_profile,
  app_name,
  normalized_os AS os,
  normalized_os_version AS os_version,
  normalized_channel,
  NULL AS campaign,
  country,
  locale,
  NULL AS distribution_id,
  app_display_version AS app_version,
  mozfun.norm.product_info(app_name, normalized_os).*,
FROM
  glean_final
~~~~
##[addon_aggregates_v2](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/addon_aggregates_v2)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/addon_aggregates_v2/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.addon_aggregates_v2`
AS
SELECT
  submission_date AS submission_date_s3,
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.addon_aggregates_v2`
~~~~
##[clients_daily](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/clients_daily)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/clients_daily/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.clients_daily`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry.clients_daily_v6`
~~~~
##[clients_daily_v6](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/clients_daily_v6)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/clients_daily_v6/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.clients_daily_v6`
AS
SELECT
  submission_date AS submission_date_s3,
  * EXCEPT (
    active_experiment_id,
    active_experiment_branch,
    total_hours_sum,
    scalar_parent_dom_contentprocess_troubled_due_to_memory_sum,
    histogram_parent_devtools_developertoolbar_opened_count_sum
  ) REPLACE(
    IFNULL(country, '??') AS country,
    IFNULL(city, '??') AS city,
    IFNULL(geo_subdivision1, '??') AS geo_subdivision1,
    IFNULL(geo_subdivision2, '??') AS geo_subdivision2
  )
FROM
  `moz-fx-data-shared-prod.telemetry_derived.clients_daily_v6`
~~~~
##[clients_last_seen_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/clients_last_seen_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/clients_last_seen_v1/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.clients_last_seen_v1`
AS
WITH days_since AS (
  SELECT
    DATE_DIFF(submission_date, first_seen_date, DAY) AS days_since_first_seen,
    DATE_DIFF(submission_date, second_seen_date, DAY) AS days_since_second_seen,
    mozfun.bits28.days_since_seen(days_seen_bits) AS days_since_seen,
    mozfun.bits28.days_since_seen(days_visited_1_uri_bits) AS days_since_visited_1_uri,
    mozfun.bits28.days_since_seen(days_visited_5_uri_bits) AS days_since_visited_5_uri,
    mozfun.bits28.days_since_seen(days_visited_10_uri_bits) AS days_since_visited_10_uri,
    mozfun.bits28.days_since_seen(days_had_8_active_ticks_bits) AS days_since_had_8_active_ticks,
    mozfun.bits28.days_since_seen(days_opened_dev_tools_bits) AS days_since_opened_dev_tools,
    mozfun.bits28.days_since_seen(days_created_profile_bits) AS days_since_created_profile,
    mozfun.bits28.days_since_seen(days_interacted_bits) AS days_since_interacted,
    *
  FROM
    `moz-fx-data-shared-prod.telemetry_derived.clients_last_seen_v1`
)
SELECT
  -- Segment definitions; see https://docs.telemetry.mozilla.org/concepts/segments.html
  -- 0x0FFFFFFE is a bitmask that accepts the previous 27 days, excluding the current day (rightmost bit)
  -- 0x183060C183 == 0b000001100000110000011000001100000110000011 is a bit mask that accepts a pair of
  -- consecutive days each week for six weeks; the current day and previous day are accepted.
  BIT_COUNT(days_seen_bits & 0x0FFFFFFE) >= 14 AS is_regular_user_v3,
  days_seen_bits & 0x0FFFFFFE = 0 AS is_new_or_resurrected_v3,
  BIT_COUNT(days_seen_bits & 0x0FFFFFFE) >= 14
  AND (
    (
      BIT_COUNT(
        days_seen_bits & 0x0FFFFFFE & (
          0x183060C183 >> (8 - EXTRACT(DAYOFWEEK FROM submission_date))
        )
      ) <= 1
    )
    OR (
      BIT_COUNT(
        days_seen_bits & 0x0FFFFFFE & (
          0x183060C183 >> (8 - EXTRACT(DAYOFWEEK FROM submission_date) - 1)
        )
      ) <= 1
    )
    OR (
      BIT_COUNT(
        days_seen_bits & 0x0FFFFFFE & (
          0x183060C183 >> (8 - EXTRACT(DAYOFWEEK FROM submission_date) + 1)
        )
      ) <= 1
    )
  ) AS is_weekday_regular_v1,
  BIT_COUNT(days_seen_bits & 0x0FFFFFFE) >= 14
  AND NOT (
    (
      BIT_COUNT(
        days_seen_bits & 0x0FFFFFFE & (
          0x183060C183 >> (8 - EXTRACT(DAYOFWEEK FROM submission_date))
        )
      ) <= 1
    )
    OR (
      BIT_COUNT(
        days_seen_bits & 0x0FFFFFFE & (
          0x183060C183 >> (8 - EXTRACT(DAYOFWEEK FROM submission_date) - 1)
        )
      ) <= 1
    )
    OR (
      BIT_COUNT(
        days_seen_bits & 0x0FFFFFFE & (
          0x183060C183 >> (8 - EXTRACT(DAYOFWEEK FROM submission_date) + 1)
        )
      ) <= 1
    )
  ) AS is_allweek_regular_v1,
  BIT_COUNT(days_visited_1_uri_bits) >= 21 AS is_core_active_v1,
  CASE
  WHEN
    BIT_COUNT(days_visited_1_uri_bits)
    BETWEEN 1
    AND 6
  THEN
    'infrequent_user'
  WHEN
    BIT_COUNT(days_visited_1_uri_bits)
    BETWEEN 7
    AND 13
  THEN
    'casual_user'
  WHEN
    BIT_COUNT(days_visited_1_uri_bits)
    BETWEEN 14
    AND 20
  THEN
    'regular_user'
  WHEN
    BIT_COUNT(days_visited_1_uri_bits) >= 21
  THEN
    'core_user'
  ELSE
    'other'
  END
  AS activity_segments_v1,
  (
    days_since_first_seen = 6
    -- 0x7F = mozfun.bits28.from_string('0000000000000000000001111111')
    AND BIT_COUNT(days_seen_bits & 0x7F) >= 5
  ) AS new_profile_7_day_activated_v1,
  (
    days_since_first_seen = 13
    -- 0x3FFF = mozfun.bits28.from_string('0000000000000011111111111111')
    AND BIT_COUNT(days_seen_bits & 0x3FFF) >= 8
  ) AS new_profile_14_day_activated_v1,
  (
    days_since_first_seen = 20
    -- 0x1FFFFF = mozfun.bits28.from_string('0000000111111111111111111111')
    AND BIT_COUNT(days_seen_bits & 0x1FFFFF) >= 12
  ) AS new_profile_21_day_activated_v1,
  * EXCEPT (
    active_experiment_id,
    scalar_parent_dom_contentprocess_troubled_due_to_memory_sum,
    total_hours_sum,
    histogram_parent_devtools_developertoolbar_opened_count_sum,
    active_experiment_branch
  ) REPLACE(
    IFNULL(country, '??') AS country,
    IFNULL(city, '??') AS city,
    IFNULL(geo_subdivision1, '??') AS geo_subdivision1,
    IFNULL(geo_subdivision2, '??') AS geo_subdivision2,
    ARRAY(
      SELECT AS STRUCT
        *,
        mozfun.bits28.days_since_seen(bits) AS days_since_seen
      FROM
        UNNEST(days_seen_in_experiment)
    ) AS days_seen_in_experiment
  ),
  -- TODO: Announce and remove this temporary field.
  CAST(sample_id AS STRING) AS _sample_id_string
FROM
  days_since
~~~~
##[fennec_ios_events_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/fennec_ios_events_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/fennec_ios_events_v1/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.fennec_ios_events_v1`
AS
WITH base_events AS (
  SELECT
    *,
    event.f0_ AS timestamp,
    event.f0_ AS event_timestamp,
    event.f1_ AS event_category,
    event.f2_ AS event_method,
    event.f3_ AS event_object,
    event.f4_ AS event_value,
    event.f5_ AS event_map_values,
    metadata.uri.app_version,
    osversion AS os_version,
    metadata.geo.country,
    metadata.geo.city,
    metadata.uri.app_name
  FROM
    `moz-fx-data-shared-prod.telemetry.mobile_event`
  CROSS JOIN
    UNNEST(events) AS event
),
all_events AS (
  SELECT
    submission_timestamp,
    client_id AS device_id,
    (
      created + COALESCE(
        SAFE_CAST(`moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'session_id') AS INT64),
        0
      )
    ) AS session_id,
    CASE
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('foreground'))
      AND (event_object IN ('app'))
    THEN
      'Fennec-iOS - App is foregrounded (session start)'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('background'))
      AND (event_object IN ('app'))
    THEN
      'Fennec-iOS - App is backgrounded (session end)'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('view'))
      AND (event_object IN ('bookmarks-panel'))
      AND (event_value IN ('home-panel-tab-button'))
    THEN
      'Fennec-iOS - View Bookmarks list from Home Panel tab button'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('view'))
      AND (event_object IN ('bookmarks-panel'))
      AND (event_value IN ('app-menu'))
    THEN
      'Fennec-iOS - View Bookmarks list from App Menu'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('add'))
      AND (event_object IN ('bookmark'))
      AND (event_value IN ('page-action-menu'))
    THEN
      'Fennec-iOS - Add Bookmark from Page Action Menu'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('add'))
      AND (event_object IN ('bookmark'))
      AND (event_value IN ('share-menu'))
    THEN
      'Fennec-iOS - Add Bookmark from Share Menu'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('add'))
      AND (event_object IN ('bookmark'))
      AND (event_value IN ('activity-stream'))
    THEN
      'Fennec-iOS - Add Bookmark from Activity Stream context menu'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('delete'))
      AND (event_object IN ('bookmark'))
      AND (event_value IN ('page-action-menu'))
    THEN
      'Fennec-iOS - Delete Bookmark from Page Action Menu'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('delete'))
      AND (event_object IN ('bookmark'))
      AND (event_value IN ('activity-stream'))
    THEN
      'Fennec-iOS - Delete Bookmark from Activity Stream context menu'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('delete'))
      AND (event_object IN ('bookmark'))
      AND (event_value IN ('bookmarks-panel'))
    THEN
      'Fennec-iOS - Delete Bookmark from Home Panel via long-press'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('delete'))
      AND (event_object IN ('bookmark'))
      AND (event_value IN ('bookmarks-panel'))
    THEN
      'Fennec-iOS - Delete Bookmark from Home Panel via swipe'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('open'))
      AND (event_object IN ('bookmark'))
      AND (event_value IN ('awesomebar-results'))
    THEN
      'Fennec-iOS - Open Bookmark from Awesomebar search results'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('open'))
      AND (event_object IN ('bookmark'))
      AND (event_value IN ('bookmarks-panel'))
    THEN
      'Fennec-iOS - Open Bookmark from Home Panel'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('tap'))
      AND (event_object IN ('reader-mode-open-button'))
    THEN
      'Fennec-iOS - Open Reader Mode'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('tap'))
      AND (event_object IN ('reader-mode-close-button'))
    THEN
      'Fennec-iOS - Leave Reader Mode'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('add'))
      AND (event_object IN ('reading-list-item'))
      AND (event_value IN ('reader-mode-toolbar'))
    THEN
      'Fennec-iOS - Add item to Reading List from Toolbar'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('add'))
      AND (event_object IN ('reading-list-item'))
      AND (event_value IN ('share-extension'))
    THEN
      'Fennec-iOS - Add item to Reading List from Share Extension'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('add'))
      AND (event_object IN ('reading-list-item'))
      AND (event_value IN ('page-action-menu'))
    THEN
      'Fennec-iOS - Add item to Reading List from Page Action Menu'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('open'))
      AND (event_object IN ('reading-list-item'))
    THEN
      'Fennec-iOS - Open item from Reading List'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('delete'))
      AND (event_object IN ('reading-list-item'))
      AND (event_value IN ('reader-mode-toolbar'))
    THEN
      'Fennec-iOS - Delete item from Reading List from Toolbar'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('delete'))
      AND (event_object IN ('reading-list-item'))
      AND (event_value IN ('reading-list-panel'))
    THEN
      'Fennec-iOS - Delete item from Reading List from Home Panel'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('tap'))
      AND (event_object IN ('reading-list-item'))
      AND (event_value IN ('mark-as-read'))
    THEN
      'Fennec-iOS - Mark Item As Read'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('tap'))
      AND (event_object IN ('reading-list-item'))
      AND (event_value IN ('mark-as-unread'))
    THEN
      'Fennec-iOS - Mark Item As Unread'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('change'))
      AND (event_object IN ('setting'))
    THEN
      'Fennec-iOS - Setting changed'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('scan'))
      AND (event_object IN ('qr-code-url'))
    THEN
      'Fennec-iOS - URL-based QR code scanned'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('scan'))
      AND (event_object IN ('qr-code-text'))
    THEN
      'Fennec-iOS - Non-URL-based QR code scanned'
    WHEN
      (event_category IN ('app-extension-action'))
      AND (event_method IN ('send-to-device'))
      AND (event_object IN ('url'))
    THEN
      'Fennec-iOS - Send to device tapped'
    WHEN
      (event_category IN ('app-extension-action'))
      AND (event_method IN ('application-open-url'))
      AND (event_object IN ('url'))
    THEN
      'Fennec-iOS - Open in Firefox tapped (URL)'
    WHEN
      (event_category IN ('app-extension-action'))
      AND (event_method IN ('application-open-url'))
      AND (event_object IN ('searchText'))
    THEN
      'Fennec-iOS - Open in Firefox tapped (search text)'
    WHEN
      (event_category IN ('app-extension-action'))
      AND (event_method IN ('bookmark-this-page'))
      AND (event_object IN ('url'))
    THEN
      'Fennec-iOS - Bookmark this page tapped'
    WHEN
      (event_category IN ('app-extension-action'))
      AND (event_method IN ('add-to-reading-list'))
      AND (event_object IN ('url'))
    THEN
      'Fennec-iOS - Add to reading list tapped'
    WHEN
      (event_category IN ('app-extension-action'))
      AND (event_method IN ('load-in-background'))
      AND (event_object IN ('url'))
    THEN
      'Fennec-iOS - Load in Background tapped'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('tap'))
      AND (event_object IN ('website-data-button'))
    THEN
      'Fennec-iOS - Tap Website Data in Data Management Menu'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('tap'))
      AND (event_object IN ('search-website-data'))
    THEN
      'Fennec-iOS - Tap on the Search Bar in Website Data'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('tap'))
      AND (event_object IN ('clear-website-data-button'))
    THEN
      'Fennec-iOS - Tap on \'Clear All Website Data\' button in Website Data'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('tap'))
      AND (event_object IN ('show-top-sites-button'))
    THEN
      'Fennec-iOS - Tap Top Sites button in New Tab Settings'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('tap'))
      AND (event_object IN ('show-blank-page-button'))
    THEN
      'Fennec-iOS - Tap Blank Page button in New Tab Settings'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('tap'))
      AND (event_object IN ('show-bookmarks-button'))
    THEN
      'Fennec-iOS - Tap Bookmarks button in New Tab Settings'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('tap'))
      AND (event_object IN ('show-history-button'))
    THEN
      'Fennec-iOS - Tap History button in New Tab Settings'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('tap'))
      AND (event_object IN ('show-homepage-button'))
    THEN
      'Fennec-iOS - Tap Homepage button in New Tab Settings'
    WHEN
      (event_category IN ('prompt'))
      AND (event_method IN ('translate'))
      AND (event_object IN ('tab'))
    THEN
      'Fennec-iOS - Prompt to translate tab to user\'s native language'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('translate'))
      AND (event_object IN ('tab'))
    THEN
      'Fennec-iOS - Accept or decline offer to translate tab'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('press'))
      AND (event_object IN ('dismissed-onboarding'))
    THEN
      'Fennec-iOS - Dismiss onboarding screen'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('press'))
      AND (event_object IN ('dismissed-onboarding-email-login'))
    THEN
      'Fennec-iOS - Dismiss onboarding screen on email login card'
    WHEN
      (event_category IN ('action'))
      AND (event_method IN ('press'))
      AND (event_object IN ('dismissed-onboarding-sign-up'))
    THEN
      'Fennec-iOS - Dismiss onboarding screen on sign up card'
    WHEN
      NOT ( -- events above are legacy definitions, moved from the previous Spark job. Following statement captures all new, non-ignored events
        (event_category = 'action' AND event_method = 'add' AND event_object = 'tab')
        OR (event_category = 'action' AND event_method = 'delete' AND event_object = 'tab')
      )
    THEN
      CONCAT('Fennec-iOS - ', event_category, '.', event_method, '.', event_object)
    END
    AS event_name,
    event_timestamp AS timestamp,
    (event_timestamp + created) AS time,
    app_version,
    os AS os_name,
    os_version,
    country,
    city,
    (
      SELECT
        ARRAY_AGG(CONCAT('"', CAST(key AS STRING), '":"', CAST(value AS STRING), '"'))
      FROM
        UNNEST(event_map_values)
    ) AS event_props_1,
    event_map_values,
    event_object,
    event_value,
    event_method,
    event_category,
    created,
    settings
  FROM
    base_events
  WHERE
    app_name IN ('Fennec')
    AND os IN ('iOS')
  -- bug 1636231 - disable background events in ios amplitude
    AND event_method != 'background'
),
all_events_with_insert_ids AS (
  SELECT
    * EXCEPT (event_category, created),
    CONCAT(
      device_id,
      "-",
      CAST(created AS STRING),
      "-",
      SPLIT(event_name, " - ")[OFFSET(1)],
      "-",
      CAST(timestamp AS STRING),
      "-",
      event_category,
      "-",
      event_method,
      "-",
      event_object
    ) AS insert_id,
    event_name AS event_type
  FROM
    all_events
  WHERE
    event_name IS NOT NULL
),
extra_props AS (
  SELECT
    * EXCEPT (event_map_values, event_object, event_value, event_method, event_name),
    (
      SELECT
        ARRAY_AGG(CONCAT('"', CAST(key AS STRING), '":"', CAST(value AS STRING), '"'))
      FROM
        (
          SELECT
            'gesture' AS key,
            CASE
            WHEN
              event_name = 'Fennec-iOS - Delete Bookmark from Home Panel via long-press'
            THEN
              'long-press'
            WHEN
              event_name = 'Fennec-iOS - Delete Bookmark from Home Panel via swipe'
            THEN
              'swipe'
            END
            AS value
          UNION ALL
          SELECT
            'setting' AS key,
            CASE
            WHEN
              event_name = 'Fennec-iOS - Setting changed'
            THEN
              event_value
            END
            AS value
          UNION ALL
          SELECT
            'to' AS key,
            CASE
            WHEN
              event_name = 'Fennec-iOS - Setting changed'
            THEN
              `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'to')
            WHEN
              event_name = 'Fennec-iOS - Prompt to translate tab to user\'s native language'
            THEN
              `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'to')
            WHEN
              event_name = 'Fennec-iOS - Accept or decline offer to translate tab'
            THEN
              `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'to')
            END
            AS value
          UNION ALL
          SELECT
            'from' AS key,
            CASE
            WHEN
              event_name = 'Fennec-iOS - Prompt to translate tab to user\'s native language'
            THEN
              `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'from')
            WHEN
              event_name = 'Fennec-iOS - Accept or decline offer to translate tab'
            THEN
              `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'from')
            END
            AS value
          UNION ALL
          SELECT
            'action' AS key,
            CASE
            WHEN
              event_name = 'Fennec-iOS - Accept or decline offer to translate tab'
            THEN
              `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'action')
            END
            AS value
          UNION ALL
          SELECT
            'slide-num' AS key,
            CASE
            WHEN
              event_name = 'Fennec-iOS - Dismiss onboarding screen'
            THEN
              `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'slide-num')
            WHEN
              event_name = 'Fennec-iOS - Dismiss onboarding screen on email login card'
            THEN
              `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'slide-num')
            WHEN
              event_name = 'Fennec-iOS - Dismiss onboarding screen on sign up card'
            THEN
              `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'slide-num')
            END
            AS value
          UNION ALL
          SELECT
            'event_value' AS key,
            event_value AS value
        )
      WHERE
        VALUE IS NOT NULL
    ) AS event_props_2,
    ARRAY_CONCAT(
      ARRAY<STRING>[],
      (
        SELECT
          ARRAY_AGG(
            CASE
            WHEN
              key = 'defaultSearchEngine'
            THEN
              CONCAT('"', 'pref_default_search_engine', '":"', CAST(value AS STRING), '"')
            WHEN
              key = 'prefKeyAutomaticSliderValue'
            THEN
              CONCAT('"', 'pref_automatic_slider_value', '":"', CAST(value AS STRING), '"')
            WHEN
              key = 'prefKeyAutomaticSwitchOnOff'
            THEN
              CONCAT('"', 'pref_automatic_switch_on_off', '":"', CAST(value AS STRING), '"')
            WHEN
              key = 'prefKeyThemeName'
            THEN
              CONCAT('"', 'pref_theme_name', '":"', CAST(value AS STRING), '"')
            WHEN
              key = 'profile.ASBookmarkHighlightsVisible'
            THEN
              CONCAT(
                '"',
                'pref_activity_stream_bookmark_highlights_visible',
                '":',
                CAST(SAFE_CAST(value AS BOOLEAN) AS STRING)
              )
            WHEN
              key = 'profile.ASPocketStoriesVisible'
            THEN
              CONCAT(
                '"',
                'pref_activity_stream_pocket_stories_visible',
                '":',
                CAST(SAFE_CAST(value AS BOOLEAN) AS STRING)
              )
            WHEN
              key = 'profile.ASRecentHighlightsVisible'
            THEN
              CONCAT(
                '"',
                'pref_activity_stream_recent_highlights_visible',
                '":',
                CAST(SAFE_CAST(value AS BOOLEAN) AS STRING)
              )
            WHEN
              key = 'profile.blockPopups'
            THEN
              CONCAT('"', 'pref_block_popups', '":', CAST(SAFE_CAST(value AS BOOLEAN) AS STRING))
            WHEN
              key = 'profile.prefkey.trackingprotection.enabled'
            THEN
              CONCAT('"', 'pref_tracking_protection_enabled', '":"', CAST(value AS STRING), '"')
            WHEN
              key = 'profile.prefkey.trackingprotection.normalbrowsing'
            THEN
              CONCAT(
                '"',
                'pref_tracking_protection_normal_browsing',
                '":"',
                CAST(value AS STRING),
                '"'
              )
            WHEN
              key = 'profile.prefkey.trackingprotection.privatebrowsing'
            THEN
              CONCAT(
                '"',
                'pref_tracking_protection_private_browsing',
                '":"',
                CAST(value AS STRING),
                '"'
              )
            WHEN
              key = 'profile.prefkey.trackingprotection.strength'
            THEN
              CONCAT('"', 'pref_tracking_protection_strength', '":"', CAST(value AS STRING), '"')
            WHEN
              key = 'profile.saveLogins'
            THEN
              CONCAT('"', 'pref_save_logins', '":', CAST(SAFE_CAST(value AS BOOLEAN) AS STRING))
            WHEN
              key = 'profile.settings.closePrivateTabs'
            THEN
              CONCAT(
                '"',
                'pref_settings_close_private_tabs',
                '":',
                CAST(SAFE_CAST(value AS BOOLEAN) AS STRING)
              )
            WHEN
              key = 'profile.show-translation'
            THEN
              CONCAT('"', 'pref_show_translation', '":"', CAST(value AS STRING), '"')
            WHEN
              key = 'profile.showClipboardBar'
            THEN
              CONCAT(
                '"',
                'pref_show_clipboard_bar',
                '":',
                CAST(SAFE_CAST(value AS BOOLEAN) AS STRING)
              )
            WHEN
              key = 'windowHeight'
            THEN
              CONCAT('"', 'pref_window_height', '":"', CAST(value AS STRING), '"')
            WHEN
              key = 'windowWidth'
            THEN
              CONCAT('"', 'pref_window_width', '":"', CAST(value AS STRING), '"')
            END
            IGNORE NULLS
          )
        FROM
          UNNEST(SETTINGS)
      )
    ) AS user_props
  FROM
    all_events_with_insert_ids
)
SELECT
  * EXCEPT (event_props_1, event_props_2, user_props, settings),
  CONCAT(
    '{',
    ARRAY_TO_STRING(
      (
        SELECT
          ARRAY_AGG(DISTINCT e)
        FROM
          UNNEST(ARRAY_CONCAT(IFNULL(event_props_1, []), IFNULL(event_props_2, []))) AS e
      ),
      ","
    ),
    '}'
  ) AS event_properties,
  CONCAT('{', ARRAY_TO_STRING(user_props, ","), '}') AS user_properties
FROM
  extra_props
~~~~
##[experiment_error_aggregates_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiment_error_aggregates_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiment_error_aggregates_v1/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.experiment_error_aggregates_v1`
AS
SELECT
  submission_date AS submission_date_s3,
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.experiment_error_aggregates_v1`
~~~~
##[firefox_desktop_exact_mau28](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/firefox_desktop_exact_mau28)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/firefox_desktop_exact_mau28/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.firefox_desktop_exact_mau28`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry.firefox_desktop_exact_mau28_v1`
~~~~
##[eng_workflow_hgpush_parquet_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/eng_workflow_hgpush_parquet_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/eng_workflow_hgpush_parquet_v1/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.eng_workflow_hgpush_parquet_v1`
AS
SELECT
  submission_date AS submission_date_s3,
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.eng_workflow_hgpush_parquet_v1`
~~~~
##[firefox_desktop_exact_mau28_by_client_count_dimensions](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/firefox_desktop_exact_mau28_by_client_count_dimensions)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/firefox_desktop_exact_mau28_by_client_count_dimensions/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.firefox_desktop_exact_mau28_by_client_count_dimensions`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.firefox_desktop_exact_mau28_by_client_count_dimensions_v1`
~~~~
##[eng_workflow_build_parquet_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/eng_workflow_build_parquet_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/eng_workflow_build_parquet_v1/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.eng_workflow_build_parquet_v1`
AS
SELECT
  DATE(submission_timestamp) AS submission_date,
  DATE(submission_timestamp) AS submission_date_s3,
  STRUCT(
    document_id,
    UNIX_MICROS(submission_timestamp) * 1000 AS `timestamp`,
    metadata.header.date AS `date`
  ) AS metadata,
  argv,
  build_opts,
  client_id,
  command,
  duration_ms,
  success,
  STRUCT(
    system.os,
    system.cpu_brand,
    system.drive_is_ssd,
    CAST(system.logical_cores AS int64) AS logical_cores,
    CAST(system.memory_gb AS int64) AS memory_gb,
    CAST(system.physical_cores AS int64) AS physical_cores,
    system.virtual_machine
  ) AS system,
  FORMAT_TIMESTAMP('%FT%X', time) AS time,
  exception,
  ARRAY(
    SELECT AS STRUCT
      u.* REPLACE (CAST(count AS int64) AS count)
    FROM
      UNNEST(file_types_changed) AS u
  ) AS file_types_changed,
  build_attrs
FROM
  `moz-fx-data-shared-prod.eng_workflow.build`
~~~~
##[telemetry_core_parquet_v3](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_core_parquet_v3)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_core_parquet_v3/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.telemetry_core_parquet_v3` AS
SELECT
  DATE(submission_timestamp) AS submission_date_s3,
  DATE(submission_timestamp) AS submission_date,
  metadata.uri.app_name,
  os,
  STRUCT(
    document_id,
    UNIX_MICROS(submission_timestamp) * 1000 AS `timestamp`,
    metadata.header.date AS `date`,
    IFNULL(metadata.geo.country, '??') AS geo_country,
    IFNULL(metadata.geo.city, '??') AS geo_city,
    metadata.uri.app_build_id AS app_build_id,
    normalized_channel
  ) AS metadata,
  STRUCT(
    metadata.uri.app_name AS name
  ) AS application,
  v,
  client_id,
  seq,
  locale,
  osversion,
  device,
  arch,
  profile_date,
  default_search,
  distribution_id,
  created,
  tz,
  sessions,
  durations,
  searches,
  experiments,
  flash_usage,
  campaign,
  campaign AS campaign_id,
  default_browser,
  show_tracker_stats_share,
  accessibility_services,
  metadata.uri.app_version AS metadata_app_version,
  bug_1501329_affected
FROM
  `moz-fx-data-shared-prod.telemetry.core`
~~~~
##[firefox_desktop_exact_mau28_by_dimensions_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/firefox_desktop_exact_mau28_by_dimensions_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/firefox_desktop_exact_mau28_by_dimensions_v1/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.firefox_desktop_exact_mau28_by_dimensions_v1`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.firefox_desktop_exact_mau28_by_dimensions_v1`
~~~~
##[experiment_enrollment_overall](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiment_enrollment_overall)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiment_enrollment_overall/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.experiment_enrollment_overall`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.experiment_enrollment_overall_v1`
~~~~
##[experiment_enrollment_cumulative_population_estimate](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiment_enrollment_cumulative_population_estimate)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiment_enrollment_cumulative_population_estimate/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.experiment_enrollment_cumulative_population_estimate`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.experiment_enrollment_cumulative_population_estimate_v1`
~~~~
##[client_probe_counts_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/client_probe_counts_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/client_probe_counts_v1/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.client_probe_counts`
AS
WITH all_counts AS (
  SELECT
    *
  FROM
    `moz-fx-data-shared-prod.telemetry_derived.clients_scalar_probe_counts_v1`
  UNION ALL
  SELECT
    *
  FROM
    `moz-fx-data-shared-prod.telemetry_derived.clients_histogram_probe_counts_v1`
  UNION ALL
  SELECT
    *
  FROM
    `moz-fx-data-shared-prod.telemetry_derived.scalar_percentiles_v1`
  UNION ALL
  SELECT
    *
  FROM
    `moz-fx-data-shared-prod.telemetry_derived.histogram_percentiles_v1`
)
SELECT
  *
FROM
  all_counts
~~~~
##[telemetry_downgrade_parquet_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_downgrade_parquet_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_downgrade_parquet_v1/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.telemetry_downgrade_parquet_v1` AS
SELECT
  DATE(submission_timestamp) AS submission_date,
  `id`,
  creation_date,
  application,
  client_id,
  version,
  STRUCT(payload.last_version,
    payload.last_build_id,
    payload.has_sync,
    CAST(NULL AS boolean) AS has_binary,
    CAST(payload.button AS int64) AS button ) AS payload
FROM
  `moz-fx-data-shared-prod.telemetry.downgrade`
~~~~
##[experiment_unenrollment_overall](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiment_unenrollment_overall)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiment_unenrollment_overall/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.experiment_unenrollment_overall`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.experiment_unenrollment_overall_v1`
~~~~
##[eng_workflow_hgpush_parquet](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/eng_workflow_hgpush_parquet)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/eng_workflow_hgpush_parquet/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.eng_workflow_hgpush_parquet`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.eng_workflow_hgpush_parquet_v1`
~~~~
##[rocket_android_events_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/rocket_android_events_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/rocket_android_events_v1/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
    `moz-fx-data-shared-prod.telemetry.rocket_android_events_v1` AS
WITH base_events AS (

SELECT
  *,
  event.f0_ AS timestamp,
  event.f0_ AS event_timestamp,
  event.f1_ AS event_category,
  event.f2_ AS event_method,
  event.f3_ AS event_object,
  event.f4_ AS event_value,
  event.f5_ AS event_map_values,
  metadata.uri.app_version,
  osversion AS os_version,
  metadata.geo.country,
  metadata.geo.city,
  metadata.uri.app_name
FROM
  `moz-fx-data-shared-prod.telemetry.focus_event`
  CROSS JOIN UNNEST(events) AS event

), all_events AS (
SELECT
    submission_timestamp,
    client_id AS device_id,
    (created + COALESCE(SAFE_CAST(`moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'session_id') AS INT64), 0)) AS session_id,
    CASE
        WHEN (event_category IN ('action') ) AND (event_method IN ('launch') ) AND (event_object IN ('app') ) AND (event_value IN ('launcher') ) THEN 'Rocket -  App is launched by Launcher' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('launch') ) AND (event_object IN ('app') ) AND (event_value IN ('shortcut') ) THEN 'Rocket -  App is launched by Shortcut' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('launch') ) AND (event_object IN ('app') ) AND (event_value IN ('private_mode') ) THEN 'Rocket -  App is launched from Private Shortcut' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('private_shortcut') ) AND event_value IS NULL THEN 'Rocket -  Show private shortcut prompt' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('private_shortcut') ) AND (event_value IN ('positive', 'negative', 'dismiss') ) THEN 'Rocket -  Click private shortcut prompt' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('setting') ) AND (event_value IN ('pref_private_shortcut') ) THEN 'Rocket -  Users clicked on a Setting' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('private_mode') ) AND (event_value IN ('exit') ) THEN 'Rocket -  Exit private mode' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('pin_shortcut') ) AND (event_object IN ('private_shortcut') ) AND event_value IS NULL THEN 'Rocket -  Private shortcut created' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('kill') ) AND (event_object IN ('app') ) AND event_value IS NULL THEN 'Rocket -  Kill app' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('launch') ) AND (event_object IN ('app') ) AND (event_value IN ('external_app') ) THEN 'Rocket -  App is launched by external app' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('setting') ) AND (event_value IN ('learn_more') ) THEN 'Rocket -  Users clicked on the Learn More link in Settings' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('change') ) AND (event_object IN ('setting') ) AND (event_value IN ('pref_locale') ) THEN 'Rocket -  Users change Locale in Settings' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('foreground') ) AND (event_object IN ('app') ) AND event_value IS NULL THEN 'Rocket -  Session starts' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('background') ) AND (event_object IN ('app') ) AND event_value IS NULL THEN 'Rocket -  Session ends' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('long_press') ) AND (event_object IN ('browser') ) AND event_value IS NULL THEN 'Rocket -  Long Press ContextMenu' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('cancel') ) AND (event_object IN ('browser_contextmenu') ) AND event_value IS NULL THEN 'Rocket -  Cancel ContextMenu' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('share') ) AND (event_object IN ('browser_contextmenu') ) AND (event_value IN ('link') ) THEN 'Rocket -  Share link via ContextMenu' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('share') ) AND (event_object IN ('browser_contextmenu') ) AND (event_value IN ('image') ) THEN 'Rocket -  Share image via ContextMenu' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('save') ) AND (event_object IN ('browser_contextmenu') ) AND (event_value IN ('image') ) THEN 'Rocket -  Save image via ContextMenu' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('copy') ) AND (event_object IN ('browser_contextmenu') ) AND (event_value IN ('link') ) THEN 'Rocket -  Copy link via ContextMenu' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('copy') ) AND (event_object IN ('browser_contextmenu') ) AND (event_value IN ('image') ) THEN 'Rocket -  Copy image via ContextMenu' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('add') ) AND (event_object IN ('browser_contextmenu') ) AND (event_value IN ('link') ) THEN 'Rocket -  Add link via ContextMenu' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('permission') ) AND (event_object IN ('browser') ) AND (event_value IN ('geolocation') ) THEN 'Rocket -  Permission-Geolocation' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('permission') ) AND (event_object IN ('browser') ) AND (event_value IN ('file') ) THEN 'Rocket -  Permission-File' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('permission') ) AND (event_object IN ('browser') ) AND (event_value IN ('audio', 'video', 'eme', 'midi') ) THEN 'Rocket -  Permission-Media' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('fullscreen') ) AND (event_object IN ('browser') ) AND (event_value IN ('enter') ) THEN 'Rocket -  Enter full screen' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('fullscreen') ) AND (event_object IN ('browser') ) AND (event_value IN ('exit') ) THEN 'Rocket -  Exit full screen' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('menu') ) AND (event_value IN ('home') ) THEN 'Rocket -  Show Menu from Home' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('tab_tray') ) AND (event_value IN ('home') ) THEN 'Rocket -  Show TabTray from Home' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('tab_tray') ) AND (event_value IN ('toolbar') ) THEN 'Rocket -  Show TabTray from Toolbar' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('menu') ) AND (event_value IN ('toolbar') ) THEN 'Rocket -  Show Menu from Toolbar' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('menu') ) AND (event_value IN ('download') ) THEN 'Rocket -  Click Menu - Downloads' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('menu') ) AND (event_value IN ('history') ) THEN 'Rocket -  Click Menu - History' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('menu') ) AND (event_value IN ('capture') ) THEN 'Rocket -  Click Menu - MyShots' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('panel') ) AND (event_value IN ('bookmark') ) THEN 'Rocket -  Click Panel - Bookmarks' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('panel') ) AND (event_value IN ('download') ) THEN 'Rocket -  Click Panel - Downloads' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('panel') ) AND (event_value IN ('history') ) THEN 'Rocket -  Click Panel - History' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('panel') ) AND (event_value IN ('capture') ) THEN 'Rocket -  Click Panel - MyShots' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('change') ) AND (event_object IN ('menu') ) AND (event_value IN ('turbo') ) THEN 'Rocket -  Click Menu - TurboMode' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('change') ) AND (event_object IN ('menu') ) AND (event_value IN ('night_mode') ) THEN 'Rocket -  Click Menu - Night Mode' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('change') ) AND (event_object IN ('menu') ) AND (event_value IN ('block_image') ) THEN 'Rocket -  Click Menu - Block Images' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('menu') ) AND (event_value IN ('clear_cache') ) THEN 'Rocket -  Click Menu - Clear cache' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('menu') ) AND (event_value IN ('settings') ) THEN 'Rocket -  Click Menu - Settings' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('menu') ) AND (event_value IN ('exit') ) THEN 'Rocket -  Click Menu - Exit' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('menu') ) AND (event_value IN ('bookmark') ) THEN 'Rocket -  Click Menu - Bookmarks' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('menu') ) AND (event_value IN ('theme') ) THEN 'Rocket -  Click Menu - Theme' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('menu') ) AND (event_value IN ('add_topsite') ) THEN 'Rocket -  Click Menu - Add Topsite' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('change') ) AND (event_object IN ('menu') ) AND (event_value IN ('vertical') ) THEN 'Rocket -  Click Menu - Vertical Toggle' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('toolbar') ) AND (event_value IN ('forward') ) THEN 'Rocket -  Click Toolbar - Forward' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('toolbar') ) AND (event_value IN ('reload') ) THEN 'Rocket -  Click Toolbar - Reload' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('share') ) AND (event_object IN ('toolbar') ) AND (event_value IN ('link') ) THEN 'Rocket -  Click Toolbar - Share Link' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('share') ) AND (event_object IN ('toolbar') ) AND (event_value IN ('bookmark') ) THEN 'Rocket -  Click Toolbar - Add bookmark' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('pin_shortcut') ) AND (event_object IN ('toolbar') ) AND (event_value IN ('link') ) THEN 'Rocket -  Click Toolbar - Pin shortcut' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('pin_shortcut') ) AND (event_object IN ('menu') ) AND (event_value IN ('link') ) THEN 'Rocket -  Click Menu - Pin shortcut' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('toolbar') ) AND (event_value IN ('capture') ) THEN 'Rocket -  Click Toolbar - Take Screenshot' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('open') ) AND (event_object IN ('home') ) AND (event_value IN ('link') ) THEN 'Rocket -  Click Top Site' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('remove') ) AND (event_object IN ('home') ) AND (event_value IN ('link') ) THEN 'Rocket -  Remove Top Site' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('add') ) AND (event_object IN ('home') ) AND (event_value IN ('link') ) THEN 'Rocket -  Add Topsite' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('snackbar') ) AND (event_value IN ('add_topsite') ) THEN 'Rocket -  Click Add Topsite Snackbar' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('panel') ) AND (event_value IN ('add_topsite') ) THEN 'Rocket -  Select to Add Topsite' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('contextual_hint') ) AND (event_value IN ('theme') ) THEN 'Rocket -  Show Theme Contextual Hint' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('contextual_hint') ) AND (event_value IN ('theme') ) THEN 'Rocket -  Click Theme Contextual Hint' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('message') ) AND (event_value IN ('go_set_default') ) THEN 'Rocket -  Show Go-Set-Default Message' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('message') ) AND (event_value IN ('go_set_default') ) THEN 'Rocket -  Click Go-Set-Default Message' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('add') ) AND (event_object IN ('tab') ) AND (event_value IN ('home') ) THEN 'Rocket -  Search in Home and add a tab' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('open') ) AND (event_object IN ('search_bar') ) AND (event_value IN ('link') ) THEN 'Rocket -  Enter an url in SearchBar' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('select_query') ) AND (event_object IN ('search_bar') ) AND event_value IS NULL THEN 'Rocket -  Use SearchSuggestion SearchBar' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('type_query') ) AND (event_object IN ('search_bar') ) AND event_value IS NULL THEN 'Rocket -  Search with text in SearchBar' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('change') ) AND (event_object IN ('private_mode') ) AND (event_value IN ('enter', 'exit') ) THEN 'Rocket -  Toggle Private Mode' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('long_press') ) AND (event_object IN ('search_suggestion') ) AND event_value IS NULL THEN 'Rocket -  Long click on Search Suggestion' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('clear') ) AND (event_object IN ('search_bar') ) AND event_value IS NULL THEN 'Rocket -  Clear SearchBar' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('cancel') ) AND (event_object IN ('search_bar') ) AND event_value IS NULL THEN 'Rocket -  Dismiss SearchBar' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('search_bar') ) AND (event_value IN ('search_box') ) THEN 'Rocket -  Show SearchBar from Home' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('search_bar') ) AND (event_value IN ('mini_urlbar') ) THEN 'Rocket -  Show SearchBar by clicking MINI_URLBAR' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('search_bar') ) AND (event_value IN ('search_btn') ) THEN 'Rocket -  Show SearchBar by clicking SEARCH_BUTTON' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('add') ) AND (event_object IN ('tab') ) AND (event_value IN ('toolbar') ) THEN 'Rocket -  Add Tab from Toolbar' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('add') ) AND (event_object IN ('tab') ) AND (event_value IN ('tab_tray') ) THEN 'Rocket -  Add Tab from TabTray' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('private_mode') ) AND (event_value IN ('tab_tray') ) THEN 'Rocket -  Enter Private Mode from TabTray' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('change') ) AND (event_object IN ('tab') ) AND (event_value IN ('tab_tray') ) THEN 'Rocket -  Switch Tab From TabTray' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('remove') ) AND (event_object IN ('tab') ) AND (event_value IN ('tab_tray') ) THEN 'Rocket -  Remove Tab From TabTray' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('swipe') ) AND (event_object IN ('tab') ) AND (event_value IN ('tab_tray') ) THEN 'Rocket -  Swipe Tab From TabTray' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('close_all') ) AND (event_value IN ('tab_tray') ) THEN 'Rocket -  Close all From TabTray' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('remove') ) AND (event_object IN ('panel') ) AND (event_value IN ('file') ) THEN 'Rocket -  Remove Download File' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('delete') ) AND (event_object IN ('panel') ) AND (event_value IN ('file') ) THEN 'Rocket -  Delete Download File' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('open') ) AND (event_object IN ('panel') ) AND (event_value IN ('file') ) THEN 'Rocket -  Open Download File via snackbar' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('menu') ) AND (event_value IN ('download') ) THEN 'Rocket -  Show File ContextMenu' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('open') ) AND (event_object IN ('panel') ) AND (event_value IN ('link') ) THEN 'Rocket -  History Open Link' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('remove') ) AND (event_object IN ('panel') ) AND (event_value IN ('link') ) THEN 'Rocket -  History Remove Link' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('remove') ) AND (event_object IN ('panel') ) AND (event_value IN ('bookmark') ) THEN 'Rocket -  Bookmark Remove Item' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('edit') ) AND (event_object IN ('panel') ) AND (event_value IN ('bookmark') ) THEN 'Rocket -  Bookmark Edit Item' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('open') ) AND (event_object IN ('panel') ) AND (event_value IN ('bookmark') ) THEN 'Rocket -  Bookmark Open Item' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('menu') ) AND (event_value IN ('history') ) THEN 'Rocket -  Show History ContextMenu' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('menu') ) AND (event_value IN ('bookmark') ) THEN 'Rocket -  Show Bookmark ContextMenu' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('clear') ) AND (event_object IN ('panel') ) AND (event_value IN ('history') ) THEN 'Rocket -  Clear History' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('open') ) AND (event_object IN ('panel') ) AND (event_value IN ('capture') ) THEN 'Rocket -  Open Capture Item' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('open') ) AND (event_object IN ('capture') ) AND (event_value IN ('link') ) THEN 'Rocket -  Open Capture Link' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('edit') ) AND (event_object IN ('capture') ) AND (event_value IN ('image') ) THEN 'Rocket -  Edit Capture Image' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('share') ) AND (event_object IN ('capture') ) AND (event_value IN ('image') ) THEN 'Rocket -  Share Capture Image' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('capture') ) AND (event_value IN ('info') ) THEN 'Rocket -  Show Capture Info' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('delete') ) AND (event_object IN ('capture') ) AND (event_value IN ('image') ) THEN 'Rocket -  Delete Capture Image' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('feedback') ) AND (event_value IN ('dismiss', 'positive', 'negative') OR event_value IS NULL) THEN 'Rocket -  click Rate App' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('feedback') ) AND event_value IS NULL THEN 'Rocket -  Show Rate App' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('default_browser') ) AND event_value IS NULL THEN 'Rocket -  Default Browser Notification shown' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('get') ) AND (event_object IN ('firstrun_push') ) AND event_value IS NULL THEN 'Rocket -  Receive Firstrun Push config' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('firstrun_push') ) AND event_value IS NULL THEN 'Rocket -  Firstrun Push notification shown' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('default_browser') ) AND event_value IS NULL THEN 'Rocket -  Default Browser Notification Clicked' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('promote_share') ) AND (event_value IN ('dismiss', 'share') ) THEN 'Rocket -  Promote Share Dialog Clicked' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('promote_share') ) AND event_value IS NULL THEN 'Rocket -  Promote Share Dialog shown' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('change') ) AND (event_object IN ('themetoy') ) AND event_value IS NULL THEN 'Rocket -  Change Theme To' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('reset') ) AND (event_object IN ('themetoy') ) AND event_value IS NULL THEN 'Rocket -  Reset Theme To' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('clear') ) AND (event_object IN ('private_mode') ) AND event_value IS NULL THEN 'Rocket -  Erase Private Mode Notification' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('home') ) AND event_value IS NULL THEN 'Rocket -  Home Impression' 
        WHEN (event_category IN ('Downloads') ) AND (event_method IN ('long_press') ) AND (event_object IN ('toolbar') ) AND (event_value IN ('download') ) THEN 'Rocket -  Long Press Toolbar Download Indicator' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('find_in_page') ) AND (event_value IN ('next') ) THEN 'Rocket -  Click FindInPage Next' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('find_in_page') ) AND (event_value IN ('previous') ) THEN 'Rocket -  Click FindInPage Previous' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('menu') ) AND (event_value IN ('find_in_page') ) THEN 'Rocket -  Click Menu FindInPage' 
        WHEN (event_category IN ('search') ) AND (event_method IN ('click') ) AND (event_object IN ('quicksearch') ) AND event_value IS NULL THEN 'Rocket -  Click Quick Search' 
        WHEN (event_category IN ('enter landscape mode') ) AND (event_method IN ('change') ) AND (event_object IN ('landscape_mode') ) AND (event_value IN ('enter') ) THEN 'Rocket -  Enter Landscape Mode' 
        WHEN (event_category IN ('enter landscape mode') ) AND (event_method IN ('change') ) AND (event_object IN ('landscape_mode') ) AND (event_value IN ('exit') ) THEN 'Rocket -  Exit Landscape Mode' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('update_msg') ) AND event_value IS NULL THEN 'Rocket -  Show in-app update intro dialog' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('update') ) AND event_value IS NULL THEN 'Rocket -  Show google play\'s in-app update dialog' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('update_msg') ) AND (event_value IN ('positive', 'negative') ) THEN 'Rocket -  Click in-app update intro dialog' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('update') ) AND (event_value IN ('positive', 'negative') ) THEN 'Rocket -  Click google play\'s in-app update dialog' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('update') ) AND (event_value IN ('downloaded') ) THEN 'Rocket -  Show in-app update install prompt' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('update') ) AND (event_value IN ('apply') ) THEN 'Rocket -  Click in-app update install prompt' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('onboarding') ) AND (event_value IN ('firstrun') ) THEN 'Rocket -  Show Firstrun Onboarding' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('onboarding') ) AND (event_value IN ('firstrun') ) THEN 'Rocket -  Click Firstrun Onboarding' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('logoman') ) AND event_value IS NULL THEN 'Rocket -  Show Logoman' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('logoman') ) AND event_value IS NULL THEN 'Rocket -  Click Logoman' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('swipe') ) AND (event_object IN ('logoman') ) AND event_value IS NULL THEN 'Rocket -  Swipe Logoman' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('get') ) AND (event_object IN ('notification') ) AND event_value IS NULL THEN 'Rocket -  Get Notification' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('notification') ) AND event_value IS NULL THEN 'Rocket -  Show Notification' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('swipe') ) AND (event_object IN ('notification') ) AND (event_value IN ('dismiss') ) THEN 'Rocket -  Dismiss Notification' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('swipe') ) AND (event_object IN ('firstrun_push') ) AND (event_value IN ('dismiss') ) THEN 'Rocket -  Dismiss D1 Notification' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('open') ) AND (event_object IN ('notification') ) AND event_value IS NULL THEN 'Rocket -  Open Notification' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('open') ) AND (event_object IN ('firstrun_push') ) AND event_value IS NULL THEN 'Rocket -  Open D1 Notification' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('message') ) AND (event_value IN ('in_app_message') ) THEN 'Rocket -  Show In-App Message' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('message') ) AND (event_value IN ('in_app_message') ) THEN 'Rocket -  Click In-App Message' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('content_hub') ) AND event_value IS NULL THEN 'Rocket -  Click Content Hub' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('reload') ) AND (event_object IN ('content_home') ) AND event_value IS NULL THEN 'Rocket -  Reload Content Home' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('search_bar') ) AND (event_value IN ('content_home') ) THEN 'Rocket -  Show Content Home Search Bar' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('select_query') ) AND (event_object IN ('search_bar') ) AND (event_value IN ('content_home') ) THEN 'Rocket -  Select Query Content Home' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('open') ) AND (event_object IN ('category') ) AND event_value IS NULL THEN 'Rocket -  Open Category' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('open') ) AND (event_object IN ('detail_page') ) AND (event_value IN ('more') ) THEN 'Rocket -  Open Detail Page More' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('start') ) AND (event_object IN ('content_tab') ) AND event_value IS NULL THEN 'Rocket -  Start Content Tab' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('end') ) AND (event_object IN ('content_tab') ) AND event_value IS NULL THEN 'Rocket -  End Content Tab' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('impression') ) AND (event_object IN ('category') ) AND event_value IS NULL THEN 'Rocket -  Category Impression' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('start') ) AND (event_object IN ('process') ) AND (event_value IN ('vertical') ) THEN 'Rocket -  Start Vertical Process' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('end') ) AND (event_object IN ('process') ) AND (event_value IN ('vertical') ) THEN 'Rocket -  End Vertical Process' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('onboarding') ) AND (event_value IN ('vertical') ) THEN 'Rocket -  Show Vertical Onboarding' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('start') ) AND (event_object IN ('process') ) AND (event_value IN ('tab_swipe') ) THEN 'Rocket -  Start Tab Swipe Process' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('end') ) AND (event_object IN ('process') ) AND (event_value IN ('tab_swipe') ) THEN 'Rocket -  End Tab Swipe Process' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('start') ) AND (event_object IN ('tab_swipe') ) AND event_value IS NULL THEN 'Rocket -  Start Tab Swipe' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('end') ) AND (event_object IN ('tab_swipe') ) AND event_value IS NULL THEN 'Rocket -  End Tab Swipe' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('toolbar') ) AND (event_value IN ('share') ) THEN 'Rocket -  Click Toolbar - Share' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('toolbar') ) AND (event_value IN ('OPEN_IN_BROWSER') ) THEN 'Rocket -  Click Toolbar - Open in browser' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('toolbar') ) AND (event_value IN ('reload') ) THEN 'Rocket -  Click Toolbar - Reload' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('toolbar') ) AND (event_value IN ('back') ) THEN 'Rocket -  Click Toolbar - Back' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('toolbar') ) AND (event_value IN ('tab_swipe') ) THEN 'Rocket -  Click Toolbar - Tab Swipe' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('drawer') ) AND (event_value IN ('tab_swipe') ) THEN 'Rocket -  Show Tab Swipe Drawer' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('drawer') ) AND (event_value IN ('tab_swipe') ) THEN 'Rocket -  Click Tab Swipe Drawer' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('add') ) AND (event_object IN ('tab') ) AND (event_value IN ('tab_swipe') ) THEN 'Rocket -  Add Tab Swipe Tab' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('change') ) AND (event_object IN ('setting') ) AND (event_value IN ('tab_swipe') ) THEN 'Rocket -  Change Tab Swipe Settings' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('search_bar') ) AND (event_value IN ('tab_swipe') ) THEN 'Rocket -  Show SearchBar from Tab Swipe' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show_keyboard') ) AND (event_object IN ('search_bar') ) AND (event_value IN ('tab_swipe') ) THEN 'Rocket -  Show Keyboard from Tab Swipe SearchBar' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('start_typing') ) AND (event_object IN ('search_bar') ) AND (event_value IN ('tab_swipe') ) THEN 'Rocket -  Start Typing from Tab Swipe SearchBar' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('type_query') ) AND (event_object IN ('search_bar') ) AND (event_value IN ('tab_swipe') ) THEN 'Rocket -  Search with text in SearchBar' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('select_query') ) AND (event_object IN ('search_bar') ) AND (event_value IN ('tab_swipe') ) THEN 'Rocket -  Use SearchSuggestion in Tab Swipe SearchBar' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('change') ) AND (event_object IN ('setting') ) AND (event_value IN ('detail_page') ) THEN 'Rocket -  Change Travel Settings' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('change') ) AND (event_object IN ('onboarding') ) AND (event_value IN ('personalization') ) THEN 'Rocket -  Change Personalization in Onboarding' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('change') ) AND (event_object IN ('onboarding') ) AND (event_value IN ('language') ) THEN 'Rocket -  Change Language in Onboarding' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('setting') ) AND (event_value IN ('lifestyle') ) THEN 'Rocket -  Click News Settings' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('change') ) AND (event_object IN ('setting') ) AND (event_value IN ('category') ) THEN 'Rocket -  Change Category in Settings' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('change') ) AND (event_object IN ('setting') ) AND (event_value IN ('lifestyle') ) THEN 'Rocket -  Change News Settings' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('pin') ) AND (event_object IN ('home') ) AND (event_value IN ('link') ) THEN 'Rocket -  Pin Topsite' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('challenge_page') ) AND (event_value IN ('join') ) THEN 'Rocket -  Click Challenge Page Join' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('contextual_hint') ) AND (event_value IN ('task') ) THEN 'Rocket -  Show Task Contextual Hint' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('end') ) AND (event_object IN ('task') ) AND event_value IS NULL THEN 'Rocket -  End Task' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('message') ) AND (event_value IN ('challenge_complete') ) THEN 'Rocket -  Show Challenge Complete Message' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('message') ) AND (event_value IN ('challenge_complete') ) THEN 'Rocket -  Click Challenge Complete Message' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('sign_in') ) AND (event_object IN ('account') ) AND event_value IS NULL THEN 'Rocket -  Account Sign In' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('redeem_page') ) AND event_value IS NULL THEN 'Rocket -  Show Redeem Page' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('copy') ) AND (event_object IN ('redeem_page') ) AND (event_value IN ('code') ) THEN 'Rocket -  Copy Code on Redeem Page' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('redeem_page') ) AND (event_value IN ('use') ) THEN 'Rocket -  Click Redeem on Redeem Page' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('profile') ) AND (event_value IN ('reward') ) THEN 'Rocket -  Click Reward Profile' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('content_home') ) AND (event_value IN ('item') ) THEN 'Rocket -  Click Content Home Item' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('challenge_page') ) AND (event_value IN ('login') ) THEN 'Rocket -  Click Chellenge Page Login' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('long_press') ) AND (event_object IN ('content_home') ) AND (event_value IN ('item') ) THEN 'Rocket -  Long Press Content Home Item' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('content_home') ) AND (event_value IN ('contextmenu') ) THEN 'Rocket -  Click Content Home Contextmenu' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('launch') ) AND (event_object IN ('app') ) AND (event_value IN ('game_shortcut') ) THEN 'Rocket -  App is launched by Game Shortcut' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('message') ) AND (event_value IN ('update') ) THEN 'Rocket -  Show Update Message' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('message') ) AND (event_value IN ('update') ) THEN 'Rocket -  Click Update Message' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('contextual_hint') ) AND (event_value IN ('game_shortcut') ) THEN 'Rocket -  Show Game Shortcut Contextual Hint' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('message') ) AND (event_value IN ('travel_search_result') ) THEN 'Rocket -  Show Travel Search Result Message' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('message') ) AND (event_value IN ('travel_search_result') ) THEN 'Rocket -  Click Travel Search Result Message' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('message') ) AND (event_value IN ('setdefault_travel_search') ) THEN 'Rocket -  Show Set-default Travel Search Message' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('message') ) AND (event_value IN ('setdefault_travel_search') ) THEN 'Rocket -  Click Set-default Travel Search Message' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('toast') ) AND (event_value IN ('exit_warning') ) THEN 'Rocket -  Show Exit Warning Toast' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('message') ) AND (event_value IN ('set_default_by_settings') ) THEN 'Rocket -  Show Set-Default by Settings Message' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('message') ) AND (event_value IN ('set_default_by_link') ) THEN 'Rocket -  Show Set-Default by Link Message' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('message') ) AND (event_value IN ('set_default_by_settings') ) THEN 'Rocket -  Click Set-Default by Settings Message' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('message') ) AND (event_value IN ('set_default_by_link') ) THEN 'Rocket -  Click Set-Default by Link Message' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('toast') ) AND (event_value IN ('set_default_success') ) THEN 'Rocket -  Show Set-Default Success Toast' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('snackbar') ) AND (event_value IN ('set_default_try_again') ) THEN 'Rocket -  Show Set-Default Try-again Snackbar' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('snackbar') ) AND (event_value IN ('set_default_try_again') ) THEN 'Rocket -  Click Set-Default Try-again Snackbar' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('start') ) AND (event_object IN ('download') ) AND (event_value IN ('file') ) THEN 'Rocket -  Start Download File' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('end') ) AND (event_object IN ('download') ) AND (event_value IN ('file') ) THEN 'Rocket -  End Download File' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('change') ) AND (event_object IN ('firstrun') ) AND (event_value IN ('turbo') ) THEN 'Rocket -  Turn on Turbo Mode in First Run' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('firstrun') ) AND (event_value IN ('finish') ) THEN 'Rocket -  Finish First Run' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('onboarding') ) AND (event_value IN ('whatsnew') ) THEN 'Rocket -  Show Whatsnew Onboarding' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('onboarding') ) AND (event_value IN ('whatsnew') ) THEN 'Rocket -  Click Whatsnew Onboarding' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('contextual_hint') ) AND (event_value IN ('firstrun') ) THEN 'Rocket -  Show Firstrun Contextual Hint' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('show') ) AND (event_object IN ('contextual_hint') ) AND (event_value IN ('whatsnew') ) THEN 'Rocket -  Show Whatsnew Contextual Hint' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('contextual_hint') ) AND (event_value IN ('firstrun') ) THEN 'Rocket -  Click Firstrun Contextual Hint' 
        WHEN (event_category IN ('action') ) AND (event_method IN ('click') ) AND (event_object IN ('contextual_hint') ) AND (event_value IN ('whatsnew') ) THEN 'Rocket -  Click Whatsnew Contextual Hint' 

    END AS event_name,
    event_timestamp AS timestamp,
    (event_timestamp + created) AS time,
    app_version,
    os AS os_name,
    os_version,
    country,
    city,
    (SELECT
      ARRAY_AGG(CONCAT('"',
        CAST(key AS STRING), '":"',
        CAST(value AS STRING), '"'))
     FROM
       UNNEST(event_map_values)) AS event_props_1,
    event_map_values,
    event_object,
    event_value,
    event_method,
    event_category,
    created,
    settings
FROM
    base_events
WHERE app_name IN ('Zerda', 'OTHER') AND os IN ('Android')
), all_events_with_insert_ids AS (
SELECT
  * EXCEPT (event_category, created),
  CONCAT(device_id, "-", CAST(created AS STRING), "-", SPLIT(event_name, " - ")[OFFSET(1)], "-", CAST(timestamp AS STRING), "-", event_category, "-", event_method, "-", event_object) AS insert_id,
  event_name AS event_type
FROM
  all_events
WHERE
  event_name IS NOT NULL
), extra_props AS (
SELECT
  * EXCEPT (event_map_values, event_object, event_value, event_method, event_name),
  (SELECT ARRAY_AGG(CONCAT('"', CAST(key AS STRING), '":"', CAST(value AS STRING), '"')) FROM (
      SELECT 'to' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'to') AS value
      UNION ALL SELECT 'on' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'on') AS value
      UNION ALL SELECT 'from' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'from') AS value
      UNION ALL SELECT 'mode' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'mode') AS value
      UNION ALL SELECT 'type' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'type') AS value
      UNION ALL SELECT 'source' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'source') AS value
      UNION ALL SELECT 'default' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'default') AS value
      UNION ALL SELECT 'position' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'position') AS value
      UNION ALL SELECT 'version' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'version') AS value
      UNION ALL SELECT 'category' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'category') AS value
      UNION ALL SELECT 'category_versio' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'category_versio') AS value
      UNION ALL SELECT 'snackbar' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'snackbar') AS value
      UNION ALL SELECT 'success' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'success') AS value
      UNION ALL SELECT 'delay' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'delay') AS value
      UNION ALL SELECT 'message' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'message') AS value
      UNION ALL SELECT 'engine' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'engine') AS value
      UNION ALL SELECT 'duration' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'duration') AS value
      UNION ALL SELECT 'from_build' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'from_build') AS value
      UNION ALL SELECT 'to_build' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'to_build') AS value
      UNION ALL SELECT 'action' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'action') AS value
      UNION ALL SELECT 'finish' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'finish') AS value
      UNION ALL SELECT 'page' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'page') AS value
      UNION ALL SELECT 'message_id' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'message_id') AS value
      UNION ALL SELECT 'link' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'link') AS value
      UNION ALL SELECT 'background' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'background') AS value
      UNION ALL SELECT 'primary' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'primary') AS value
      UNION ALL SELECT 'vertical' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'vertical') AS value
      UNION ALL SELECT 'component_id' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'component_id') AS value
      UNION ALL SELECT 'feed' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'feed') AS value
      UNION ALL SELECT 'subcategory_id' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'subcategory_id') AS value
      UNION ALL SELECT 'version_id' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'version_id') AS value
      UNION ALL SELECT 'app_link' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'app_link') AS value
      UNION ALL SELECT 'session_time' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'session_time') AS value
      UNION ALL SELECT 'show_keyboard' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'show_keyboard') AS value
      UNION ALL SELECT 'url_counts' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'url_counts') AS value
      UNION ALL SELECT 'impression' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'impression') AS value
      UNION ALL SELECT 'loadtime' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'loadtime') AS value
      UNION ALL SELECT 'audience_name' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'audience_name') AS value
      UNION ALL SELECT 'finished' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'finished') AS value
      UNION ALL SELECT 'task' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'task') AS value
      UNION ALL SELECT 'item_name' AS key, `moz-fx-data-shared-prod.udf.get_key`(event_map_values, 'item_name') AS value
  ) WHERE VALUE IS NOT NULL) AS event_props_2,
  ARRAY_CONCAT(ARRAY<STRING>[],
    (SELECT ARRAY_AGG(
    CASE
        WHEN key='pref_search_engine' THEN CONCAT('"', 'pref_search_engine', '":"', CAST(value AS STRING), '"')
        WHEN key='pref_privacy_turbo_mode' THEN CONCAT('"', 'pref_privacy_turbo_mode', '":', CAST(SAFE_CAST(value AS BOOLEAN) AS STRING))
        WHEN key='pref_performance_block_images' THEN CONCAT('"', 'pref_performance_block_images', '":', CAST(SAFE_CAST(value AS BOOLEAN) AS STRING))
        WHEN key='pref_default_browser' THEN CONCAT('"', 'pref_default_browser', '":', CAST(SAFE_CAST(value AS BOOLEAN) AS STRING))
        WHEN key='pref_save_downloads_to' THEN CONCAT('"', 'pref_save_downloads_to', '":"', CAST(value AS STRING), '"')
        WHEN key='pref_webview_version' THEN CONCAT('"', 'pref_webview_version', '":"', CAST(value AS STRING), '"')
        WHEN key='install_referrer' THEN CONCAT('"', 'install_referrer', '":"', CAST(value AS STRING), '"')
        WHEN key='experiment_name' THEN CONCAT('"', 'experiment_name', '":"', CAST(value AS STRING), '"')
        WHEN key='experiment_bucket' THEN CONCAT('"', 'experiment_bucket', '":"', CAST(value AS STRING), '"')
        WHEN key='pref_locale' THEN CONCAT('"', 'pref_locale', '":"', CAST(value AS STRING), '"')
        WHEN key='pref_key_s_tracker_token' THEN CONCAT('"', 'pref_key_s_tracker_token', '":"', CAST(value AS STRING), '"')
    END
    IGNORE NULLS)
  FROM
    UNNEST(SETTINGS)
  )) AS user_props
FROM
  all_events_with_insert_ids
)

SELECT
  * EXCEPT (event_props_1, event_props_2, user_props, settings),
  CONCAT('{', ARRAY_TO_STRING((
   SELECT ARRAY_AGG(DISTINCT e) FROM UNNEST(ARRAY_CONCAT(IFNULL(event_props_1, []), IFNULL(event_props_2, []))) AS e
  ), ","), '}') AS event_properties,
  CONCAT('{', ARRAY_TO_STRING(user_props, ","), '}') AS user_properties
FROM extra_props
~~~~
##[windows_10_aggregate](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/windows_10_aggregate)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/windows_10_aggregate/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.windows_10_aggregate` AS
WITH
  aggregated AS (
  SELECT
    os AS name,
    os_version AS version,
    windows_build_number AS build_number,
    CAST(windows_ubr AS STRING) AS ubr,
    CASE
    WHEN windows_build_number <= 10240 THEN '1507'
    WHEN windows_build_number <= 10586 THEN '1511'
    WHEN windows_build_number <= 14393 THEN '1607'
    WHEN windows_build_number <= 15063 THEN '1703'
    WHEN windows_build_number <= 16299 THEN '1709'
    WHEN windows_build_number <= 17134 THEN '1803'
    WHEN windows_build_number <= 17763 THEN '1809'
    WHEN windows_build_number <= 18362 THEN '1903'
    WHEN windows_build_number <= 18363 THEN '1909'
    WHEN windows_build_number <= 19041 THEN '2004'
    WHEN windows_build_number <= 19042 THEN '20H2'
    WHEN windows_build_number > 19042 THEN 'Insider'
    ELSE NULL
    END AS build_group,
    SPLIT(app_version, ".")[OFFSET(0)] AS ff_build_version,
    normalized_channel,
    COUNT(*) AS `count`
  FROM
    `moz-fx-data-shared-prod.telemetry.clients_daily`
  WHERE
    submission_date > DATE_SUB(CURRENT_DATE, INTERVAL 28 DAY)
    AND os = 'Windows_NT'
    AND STARTS_WITH(os_version, '10')
    AND SAFE_CAST(SPLIT(app_version, ".")[OFFSET(0)] AS INT64) >= 47
    AND sample_id = 42
  GROUP BY
    name,
    version,
    build_number,
    ubr,
    build_group,
    ff_build_version,
    normalized_channel),
  total AS (
  SELECT
    SUM(count) total_obs
  FROM
    aggregated)
SELECT
  *
FROM
  aggregated
CROSS JOIN
  total
~~~~
##[telemetry_anonymous_parquet_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_anonymous_parquet_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_anonymous_parquet_v1/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.telemetry_anonymous_parquet_v1` AS
SELECT
  DATE(submission_timestamp) AS submission_date_s3,
  STRUCT( document_id,
    UNIX_MICROS(submission_timestamp) * 1000 AS `timestamp`,
    metadata.header.date AS `date`,
    IFNULL(metadata.geo.country,
      '??') AS geo_country,
    IFNULL(metadata.geo.city,
      '??') AS geo_city,
    metadata.uri.app_build_id,
    metadata.uri.app_name,
    metadata.uri.app_update_channel,
    normalized_channel ) AS metadata,
  application,
  creation_date,
  id,
  payload,
  type,
  version
FROM
  `moz-fx-data-shared-prod.telemetry.anonymous`
~~~~
##[sync](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/sync)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/sync/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.sync`
AS SELECT
  * REPLACE(
    `moz-fx-data-shared-prod.udf.normalize_metadata`(metadata) AS metadata)
FROM
  `moz-fx-data-shared-prod.telemetry_stable.sync_v4`
~~~~
##[experiment_cumulative_search_count](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiment_cumulative_search_count)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiment_cumulative_search_count/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.experiment_cumulative_search_count`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.experiment_cumulative_search_count_v1`
~~~~
##[events](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/events)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/events/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.events`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry.events_v1`
~~~~
##[experiment_cumulative_ad_clicks](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiment_cumulative_ad_clicks)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiment_cumulative_ad_clicks/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.experiment_cumulative_ad_clicks`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.experiment_cumulative_ad_clicks_v1`
~~~~
##[crash_summary_v2](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/crash_summary_v2)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/crash_summary_v2/view.sql)

~~~~sql
-- Query generated by: templates/unnest_parquet_view.sql.py crash_summary_v2 telemetry_derived.crash_summary_v2
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.crash_summary_v2`
AS
SELECT
  * REPLACE (
    experiments.key_value AS experiments,
    (SELECT AS STRUCT payload.* REPLACE (payload.metadata.key_value AS metadata)) AS payload
  )
FROM
  `moz-fx-data-shared-prod.telemetry_derived.crash_summary_v2`
~~~~
##[telemetry_heartbeat_parquet_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_heartbeat_parquet_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_heartbeat_parquet_v1/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.telemetry_heartbeat_parquet_v1` AS
SELECT
  DATE(submission_timestamp) AS submission_date_s3,
  DATE(submission_timestamp) AS submission_date,
  type,
  id,
  creation_date,
  version,
  client_id,
  application,
  (SELECT AS STRUCT payload.* replace (CAST(version AS int64) AS version)) AS payload,
  STRUCT( UNIX_MICROS(submission_timestamp) * 1000 AS `timestamp`,
    metadata.header.date AS `date`,
    IFNULL(metadata.geo.country,
      '??') AS geo_country,
    IFNULL(metadata.geo.city,
      '??') AS geo_city,
    document_id,
    metadata.uri.app_build_id,
    metadata.uri.app_name ) AS metadata,
  engagement_type
FROM
  `moz-fx-data-shared-prod.telemetry.heartbeat`
~~~~
##[smoot_usage_day_13](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/smoot_usage_day_13)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/smoot_usage_day_13/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.smoot_usage_day_13`
AS WITH
  unioned AS (
  SELECT * FROM `moz-fx-data-shared-prod.telemetry_derived.smoot_usage_desktop_v2`
  UNION ALL
  SELECT * FROM `moz-fx-data-shared-prod.telemetry_derived.smoot_usage_nondesktop_v2`
  UNION ALL
  SELECT * FROM `moz-fx-data-shared-prod.telemetry_derived.smoot_usage_fxa_v2` )
  --
SELECT
  DATE_SUB(submission_date, INTERVAL 13 DAY) AS `date`,
  usage,
  metrics.day_13.*,
  * EXCEPT (submission_date, usage, metrics)
FROM
  unioned
~~~~
##[lockwise_mobile_events_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/lockwise_mobile_events_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/lockwise_mobile_events_v1/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
`moz-fx-data-shared-prod.telemetry.lockwise_mobile_events_v1` AS
  --
WITH
  android AS (
    SELECT
        os,
        client_id,
        submission_date_s3,
        timestamp_seconds(cast(substr(cast(metadata.timestamp AS string), 1, 10) AS int64)) AS submission_timestamp,
        device,
        metadata.app_build_id,
        e.*
    FROM `moz-fx-data-shared-prod.telemetry.telemetry_mobile_event_parquet_v2`, UNNEST(events) AS e
    WHERE metadata.app_name = 'Lockbox'
    AND os = 'Android'
    -- Filter out test data before the Android launch date.
    AND submission_date_s3 >= '2019-03-25'
  ),
  --
  ios AS (
    SELECT
        os,
        client_id,
        submission_date_s3,
        timestamp_seconds(cast(substr(cast(metadata.timestamp AS string), 1, 10) AS int64)) AS submission_timestamp,
        device,
        metadata.app_build_id,
        e.*
    FROM
    `moz-fx-data-shared-prod.telemetry.telemetry_focus_event_parquet_v1`, UNNEST(events) AS e
    WHERE metadata.app_name = 'Lockbox'
    AND os = 'iOS'
    -- Filter out test data before the iOS launch date.
    AND submission_date_s3 >= '2018-07-09'
  )
  --
SELECT * FROM android
UNION ALL
SELECT * FROM ios
~~~~
##[telemetry_shield_study_parquet_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_shield_study_parquet_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_shield_study_parquet_v1/view.sql)

~~~~sql
-- Query generated by: templates/unnest_parquet_view.sql.py telemetry_shield_study_parquet_v1 telemetry_derived.telemetry_shield_study_parquet_v1
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.telemetry_shield_study_parquet_v1` AS
SELECT
  submission_date AS submission,
  * REPLACE (
    (SELECT AS STRUCT application.* REPLACE ((SELECT AS STRUCT application.addons.* REPLACE (application.addons.active_addons.key_value AS active_addons, application.addons.active_gmplugins.key_value AS active_gmplugins)) AS addons)) AS application,
    (SELECT AS STRUCT payload.* REPLACE ((SELECT AS STRUCT payload.data.* REPLACE (payload.data.attributes.key_value AS attributes)) AS data)) AS payload
  )
FROM
  `moz-fx-data-shared-prod.telemetry_derived.telemetry_shield_study_parquet_v1`
~~~~
##[firefox_nondesktop_exact_mau28_by_product_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/firefox_nondesktop_exact_mau28_by_product_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/firefox_nondesktop_exact_mau28_by_product_v1/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.firefox_nondesktop_exact_mau28_by_product_v1`
AS
SELECT
  submission_date,
  product,
  SUM(mau) AS mau,
  SUM(wau) AS wau,
  SUM(dau) AS dau,
  SUM(IF(country IN ('US', 'FR', 'DE', 'GB', 'CA'), mau, 0)) AS tier1_mau,
  SUM(IF(country IN ('US', 'FR', 'DE', 'GB', 'CA'), wau, 0)) AS tier1_wau,
  SUM(IF(country IN ('US', 'FR', 'DE', 'GB', 'CA'), dau, 0)) AS tier1_dau
FROM
  `moz-fx-data-shared-prod.telemetry.firefox_nondesktop_exact_mau28_by_dimensions_v1`
GROUP BY
  submission_date,
  product
~~~~
##[telemetry_anonymous_parquet](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_anonymous_parquet)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_anonymous_parquet/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.telemetry_anonymous_parquet`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.telemetry_anonymous_parquet_v1`
~~~~
##[events_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/events_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/events_v1/view.sql)

~~~~sql
-- Creates a union view to provide continuity between legacy parquet events view and new
-- all-gcp events tables
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.events_v1`
AS
WITH parquet_events AS (
  SELECT
    * EXCEPT (
      -- These are old fields that were removed in the parquet job but resurfaced in the BQ import
      e10s_enabled,
      e10s_cohort,
      subsession_start_date,
      subsession_length,
      sync_configured,
      sync_count_desktop,
      sync_count_mobile,
      active_experiment_id,
      active_experiment_branch
    ) REPLACE(
      event_map_values.key_value AS event_map_values,
      -- experiments struct in new events includes enrollment_id and type subfields
      (
        SELECT
          ARRAY_AGG(
            STRUCT(
              e.key AS key,
              STRUCT(
                e.value AS branch,
                CAST(NULL AS string) AS enrollment_id,
                CAST(NULL AS string) AS `type`
              ) AS value
            )
          )
        FROM
          UNNEST(experiments.key_value) e
      ) AS experiments,
      -- Bug 1525620: fix inconsistencies in timestamp resolution for main vs event events
      CASE
      WHEN
        doc_type = 'main'
      THEN
        SAFE.TIMESTAMP_MICROS(CAST(`timestamp` / 1000 AS INT64))
      ELSE
        SAFE.TIMESTAMP_SECONDS(`timestamp`)
      END
      AS `timestamp`,
      SAFE.TIMESTAMP_MILLIS(session_start_time) AS session_start_time
    ),
    CAST(NULL AS STRING) AS build_id
  FROM
    `moz-fx-data-shared-prod.telemetry_derived.events_v1`
  WHERE
    submission_date < '2019-10-31'
),
main_events AS (
  SELECT
    submission_date,
    'main' AS doc_type,
    document_id,
    client_id,
    normalized_channel,
    country,
    locale,
    app_name,
    app_version,
    os,
    os_version,
    `timestamp`,
    sample_id,
    event_timestamp,
    event_category,
    event_method,
    event_object,
    event_string_value,
    event_map_values,
    experiments,
    event_process,
    subsession_id,
    session_start_time,
    session_id,
    build_id
  FROM
    `moz-fx-data-shared-prod`.telemetry_derived.main_events_v1
  WHERE
    submission_date >= '2019-10-31'
),
event_events AS (
  SELECT
    submission_date,
    'event' AS doc_type,
    document_id,
    client_id,
    normalized_channel,
    country,
    locale,
    app_name,
    app_version,
    os,
    os_version,
    `timestamp`,
    sample_id,
    event_timestamp,
    event_category,
    event_method,
    event_object,
    event_string_value,
    event_map_values,
    experiments,
    event_process,
    subsession_id,
    session_start_time,
    session_id,
    build_id
  FROM
    `moz-fx-data-shared-prod`.telemetry_derived.event_events_v1
  WHERE
    submission_date >= '2019-10-31'
)
SELECT
  *
FROM
  parquet_events
UNION ALL
SELECT
  *
FROM
  main_events
UNION ALL
SELECT
  *
FROM
  event_events
~~~~
##[ssl_ratios](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/ssl_ratios)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/ssl_ratios/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.ssl_ratios`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry.ssl_ratios_v1`
~~~~
##[accessibility_clients](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/accessibility_clients)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/accessibility_clients/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.accessibility_clients`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.accessibility_clients_v1`
~~~~
##[experiment_enrollment_aggregates_hourly](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiment_enrollment_aggregates_hourly)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiment_enrollment_aggregates_hourly/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.experiment_enrollment_aggregates_hourly`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.experiment_enrollment_aggregates_hourly_v1`
~~~~
##[firefox_accounts_exact_mau28_by_dimensions](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/firefox_accounts_exact_mau28_by_dimensions)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/firefox_accounts_exact_mau28_by_dimensions/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.firefox_accounts_exact_mau28_by_dimensions`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry.firefox_accounts_exact_mau28_by_dimensions_v1`
~~~~
##[firefox_nondesktop_exact_mau28_by_product](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/firefox_nondesktop_exact_mau28_by_product)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/firefox_nondesktop_exact_mau28_by_product/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.firefox_nondesktop_exact_mau28_by_product`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry.firefox_nondesktop_exact_mau28_by_product_v1`
~~~~
##[first_shutdown_summary](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/first_shutdown_summary)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/first_shutdown_summary/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.first_shutdown_summary`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.first_shutdown_summary_v4`
~~~~
##[main_nightly](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/main_nightly)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/main_nightly/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.main_nightly`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry_derived.main_nightly_v1`
~~~~
##[firefox_accounts_exact_mau28_by_dimensions_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/firefox_accounts_exact_mau28_by_dimensions_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/firefox_accounts_exact_mau28_by_dimensions_v1/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.firefox_accounts_exact_mau28_by_dimensions_v1`
AS
SELECT
  raw.* EXCEPT (mau_tier1_inclusive),
  -- We rename this column here to match the new standard of prefixing _mau
  -- with the usage criterion; we can refactor to have the correct name in
  -- the raw table the next time we need to make a change and backfill.
  mau_tier1_inclusive AS seen_in_tier1_country_mau,
  COALESCE(cn.code, raw.country) AS country_code
FROM
  `moz-fx-data-shared-prod.firefox_accounts_derived.exact_mau28_v1` AS raw
LEFT JOIN
  `moz-fx-data-shared-prod.static.country_names_v1` cn
ON
  (raw.country = cn.name)
~~~~
##[telemetry_new_profile_parquet](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_new_profile_parquet)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_new_profile_parquet/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.telemetry_new_profile_parquet`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry.telemetry_new_profile_parquet_v2`
~~~~
##[firefox_desktop_exact_mau28_by_dimensions](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/firefox_desktop_exact_mau28_by_dimensions)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/firefox_desktop_exact_mau28_by_dimensions/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.firefox_desktop_exact_mau28_by_dimensions`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry.firefox_desktop_exact_mau28_by_dimensions_v1`
~~~~
##[origin_content_blocking](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/origin_content_blocking)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/origin_content_blocking/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.origin_content_blocking`
AS
WITH most_recent AS (
  SELECT
    * EXCEPT(_n)
  FROM
    (
      SELECT
        *,
        ROW_NUMBER() OVER (
          PARTITION BY
            submission_date,
            batch_id,
            origin
          ORDER BY
            TIMESTAMP DESC
        ) AS _n
      FROM
        `moz-fx-data-shared-prod.telemetry_derived.origin_content_blocking`
    )
  WHERE
    _n = 1
)
SELECT
  submission_date,
  batch_id,
  origin,
  aggregate
FROM
  most_recent
~~~~
##[first_shutdown_summary_v4](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/first_shutdown_summary_v4)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/first_shutdown_summary_v4/view.sql)

~~~~sql
-- Query generated by: templates/unnest_parquet_view.sql.py first_shutdown_summary_v4 telemetry_derived.first_shutdown_summary_v4
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.first_shutdown_summary_v4`
AS
SELECT
  submission_date AS submission_date_s3,
  * REPLACE (
    ARRAY(SELECT * FROM UNNEST(active_addons.list)) AS active_addons,
    ARRAY(SELECT * FROM UNNEST(antispyware.list)) AS antispyware,
    ARRAY(SELECT * FROM UNNEST(antivirus.list)) AS antivirus,
    boolean_addon_scalars.key_value AS boolean_addon_scalars,
    ARRAY(SELECT * FROM UNNEST(disabled_addons_ids.list)) AS disabled_addons_ids,
    ARRAY(
      SELECT
        *
      FROM
        UNNEST(environment_settings_intl_accept_languages.list)
    ) AS environment_settings_intl_accept_languages,
    ARRAY(
      SELECT
        *
      FROM
        UNNEST(environment_settings_intl_app_locales.list)
    ) AS environment_settings_intl_app_locales,
    ARRAY(
      SELECT
        *
      FROM
        UNNEST(environment_settings_intl_available_locales.list)
    ) AS environment_settings_intl_available_locales,
    ARRAY(
      SELECT
        *
      FROM
        UNNEST(environment_settings_intl_regional_prefs_locales.list)
    ) AS environment_settings_intl_regional_prefs_locales,
    ARRAY(
      SELECT
        *
      FROM
        UNNEST(environment_settings_intl_requested_locales.list)
    ) AS environment_settings_intl_requested_locales,
    ARRAY(
      SELECT
        *
      FROM
        UNNEST(environment_settings_intl_system_locales.list)
    ) AS environment_settings_intl_system_locales,
    ARRAY(
      SELECT AS STRUCT
        _0.element.* REPLACE (_0.element.map_values.key_value AS map_values)
      FROM
        UNNEST(events.list) AS _0
    ) AS events,
    experiments.key_value AS experiments,
    ARRAY(SELECT * FROM UNNEST(firewall.list)) AS firewall,
    histogram_content_a11y_consumers.key_value AS histogram_content_a11y_consumers,
    histogram_content_a11y_instantiated_flag.key_value AS histogram_content_a11y_instantiated_flag,
    histogram_content_cert_validation_success_by_ca.key_value AS histogram_content_cert_validation_success_by_ca,
    histogram_content_checkerboard_severity.key_value AS histogram_content_checkerboard_severity,
    histogram_content_composite_time.key_value AS histogram_content_composite_time,
    histogram_content_content_paint_time.key_value AS histogram_content_content_paint_time,
    histogram_content_cycle_collector_max_pause.key_value AS histogram_content_cycle_collector_max_pause,
    histogram_content_devtools_accessibility_picker_time_active_seconds.key_value AS histogram_content_devtools_accessibility_picker_time_active_seconds,
    histogram_content_devtools_accessibility_service_time_active_seconds.key_value AS histogram_content_devtools_accessibility_service_time_active_seconds,
    histogram_content_devtools_accessibility_time_active_seconds.key_value AS histogram_content_devtools_accessibility_time_active_seconds,
    histogram_content_devtools_toolbox_time_active_seconds.key_value AS histogram_content_devtools_toolbox_time_active_seconds,
    histogram_content_fx_new_window_ms.key_value AS histogram_content_fx_new_window_ms,
    histogram_content_fx_page_load_ms_2.key_value AS histogram_content_fx_page_load_ms_2,
    histogram_content_fx_searchbar_selected_result_method.key_value AS histogram_content_fx_searchbar_selected_result_method,
    histogram_content_fx_session_restore_restore_window_ms.key_value AS histogram_content_fx_session_restore_restore_window_ms,
    histogram_content_fx_session_restore_startup_init_session_ms.key_value AS histogram_content_fx_session_restore_startup_init_session_ms,
    histogram_content_fx_session_restore_startup_onload_initial_window_ms.key_value AS histogram_content_fx_session_restore_startup_onload_initial_window_ms,
    histogram_content_fx_tab_close_time_anim_ms.key_value AS histogram_content_fx_tab_close_time_anim_ms,
    histogram_content_fx_tab_switch_update_ms.key_value AS histogram_content_fx_tab_switch_update_ms,
    histogram_content_fx_urlbar_selected_result_index.key_value AS histogram_content_fx_urlbar_selected_result_index,
    ARRAY(
      SELECT AS STRUCT
        * REPLACE (_0.value.key_value AS value)
      FROM
        UNNEST(histogram_content_fx_urlbar_selected_result_index_by_type.key_value) AS _0
    ) AS histogram_content_fx_urlbar_selected_result_index_by_type,
    histogram_content_fx_urlbar_selected_result_method.key_value AS histogram_content_fx_urlbar_selected_result_method,
    histogram_content_fx_urlbar_selected_result_type.key_value AS histogram_content_fx_urlbar_selected_result_type,
    histogram_content_gc_animation_ms.key_value AS histogram_content_gc_animation_ms,
    histogram_content_gc_max_pause_ms.key_value AS histogram_content_gc_max_pause_ms,
    histogram_content_gc_max_pause_ms_2.key_value AS histogram_content_gc_max_pause_ms_2,
    histogram_content_geolocation_request_granted.key_value AS histogram_content_geolocation_request_granted,
    histogram_content_ghost_windows.key_value AS histogram_content_ghost_windows,
    histogram_content_gpu_process_initialization_time_ms.key_value AS histogram_content_gpu_process_initialization_time_ms,
    histogram_content_gpu_process_launch_time_ms_2.key_value AS histogram_content_gpu_process_launch_time_ms_2,
    histogram_content_http_channel_disposition.key_value AS histogram_content_http_channel_disposition,
    histogram_content_http_pageload_is_ssl.key_value AS histogram_content_http_pageload_is_ssl,
    histogram_content_http_transaction_is_ssl.key_value AS histogram_content_http_transaction_is_ssl,
    histogram_content_input_event_response_coalesced_ms.key_value AS histogram_content_input_event_response_coalesced_ms,
    ARRAY(
      SELECT AS STRUCT
        * REPLACE (_0.value.key_value AS value)
      FROM
        UNNEST(histogram_content_ipc_read_main_thread_latency_ms.key_value) AS _0
    ) AS histogram_content_ipc_read_main_thread_latency_ms,
    ARRAY(
      SELECT AS STRUCT
        * REPLACE (_0.value.key_value AS value)
      FROM
        UNNEST(histogram_content_memory_distribution_among_content.key_value) AS _0
    ) AS histogram_content_memory_distribution_among_content,
    histogram_content_memory_heap_allocated.key_value AS histogram_content_memory_heap_allocated,
    histogram_content_memory_resident_fast.key_value AS histogram_content_memory_resident_fast,
    histogram_content_memory_total.key_value AS histogram_content_memory_total,
    histogram_content_memory_unique.key_value AS histogram_content_memory_unique,
    histogram_content_memory_unique_content_startup.key_value AS histogram_content_memory_unique_content_startup,
    histogram_content_memory_vsize.key_value AS histogram_content_memory_vsize,
    histogram_content_memory_vsize_max_contiguous.key_value AS histogram_content_memory_vsize_max_contiguous,
    histogram_content_network_cache_metadata_first_read_time_ms.key_value AS histogram_content_network_cache_metadata_first_read_time_ms,
    histogram_content_network_cache_v2_hit_time_ms.key_value AS histogram_content_network_cache_v2_hit_time_ms,
    histogram_content_network_cache_v2_miss_time_ms.key_value AS histogram_content_network_cache_v2_miss_time_ms,
    histogram_content_places_autocomplete_6_first_results_time_ms.key_value AS histogram_content_places_autocomplete_6_first_results_time_ms,
    histogram_content_plugin_shutdown_ms.key_value AS histogram_content_plugin_shutdown_ms,
    histogram_content_pwmgr_form_autofill_result.key_value AS histogram_content_pwmgr_form_autofill_result,
    histogram_content_pwmgr_login_page_safety.key_value AS histogram_content_pwmgr_login_page_safety,
    histogram_content_sandbox_rejected_syscalls.key_value AS histogram_content_sandbox_rejected_syscalls,
    histogram_content_search_reset_result.key_value AS histogram_content_search_reset_result,
    histogram_content_search_service_init_ms.key_value AS histogram_content_search_service_init_ms,
    histogram_content_ssl_handshake_result.key_value AS histogram_content_ssl_handshake_result,
    histogram_content_ssl_handshake_version.key_value AS histogram_content_ssl_handshake_version,
    histogram_content_ssl_tls12_intolerance_reason_pre.key_value AS histogram_content_ssl_tls12_intolerance_reason_pre,
    histogram_content_ssl_tls13_intolerance_reason_pre.key_value AS histogram_content_ssl_tls13_intolerance_reason_pre,
    histogram_content_time_to_dom_complete_ms.key_value AS histogram_content_time_to_dom_complete_ms,
    histogram_content_time_to_dom_content_loaded_end_ms.key_value AS histogram_content_time_to_dom_content_loaded_end_ms,
    histogram_content_time_to_dom_content_loaded_start_ms.key_value AS histogram_content_time_to_dom_content_loaded_start_ms,
    histogram_content_time_to_dom_interactive_ms.key_value AS histogram_content_time_to_dom_interactive_ms,
    histogram_content_time_to_dom_loading_ms.key_value AS histogram_content_time_to_dom_loading_ms,
    histogram_content_time_to_first_click_ms.key_value AS histogram_content_time_to_first_click_ms,
    histogram_content_time_to_first_interaction_ms.key_value AS histogram_content_time_to_first_interaction_ms,
    histogram_content_time_to_first_key_input_ms.key_value AS histogram_content_time_to_first_key_input_ms,
    histogram_content_time_to_first_mouse_move_ms.key_value AS histogram_content_time_to_first_mouse_move_ms,
    histogram_content_time_to_first_scroll_ms.key_value AS histogram_content_time_to_first_scroll_ms,
    histogram_content_time_to_load_event_end_ms.key_value AS histogram_content_time_to_load_event_end_ms,
    histogram_content_time_to_load_event_start_ms.key_value AS histogram_content_time_to_load_event_start_ms,
    histogram_content_time_to_non_blank_paint_ms.key_value AS histogram_content_time_to_non_blank_paint_ms,
    histogram_content_time_to_response_start_ms.key_value AS histogram_content_time_to_response_start_ms,
    histogram_content_touch_enabled_device.key_value AS histogram_content_touch_enabled_device,
    histogram_content_tracking_protection_enabled.key_value AS histogram_content_tracking_protection_enabled,
    ARRAY(
      SELECT AS STRUCT
        * REPLACE (_0.value.key_value AS value)
      FROM
        UNNEST(histogram_content_uptake_remote_content_result_1.key_value) AS _0
    ) AS histogram_content_uptake_remote_content_result_1,
    histogram_content_webext_content_script_injection_ms.key_value AS histogram_content_webext_content_script_injection_ms,
    histogram_content_webext_storage_local_get_ms.key_value AS histogram_content_webext_storage_local_get_ms,
    histogram_content_webext_storage_local_set_ms.key_value AS histogram_content_webext_storage_local_set_ms,
    histogram_content_webvr_time_spent_viewing_in_2d.key_value AS histogram_content_webvr_time_spent_viewing_in_2d,
    histogram_content_webvr_users_view_in.key_value AS histogram_content_webvr_users_view_in,
    histogram_gpu_a11y_consumers.key_value AS histogram_gpu_a11y_consumers,
    histogram_gpu_a11y_instantiated_flag.key_value AS histogram_gpu_a11y_instantiated_flag,
    histogram_gpu_cert_validation_success_by_ca.key_value AS histogram_gpu_cert_validation_success_by_ca,
    histogram_gpu_checkerboard_severity.key_value AS histogram_gpu_checkerboard_severity,
    histogram_gpu_composite_time.key_value AS histogram_gpu_composite_time,
    histogram_gpu_content_frame_time.key_value AS histogram_gpu_content_frame_time,
    histogram_gpu_cycle_collector_max_pause.key_value AS histogram_gpu_cycle_collector_max_pause,
    histogram_gpu_fx_urlbar_selected_result_index.key_value AS histogram_gpu_fx_urlbar_selected_result_index,
    histogram_gpu_fx_urlbar_selected_result_type.key_value AS histogram_gpu_fx_urlbar_selected_result_type,
    histogram_gpu_gc_max_pause_ms.key_value AS histogram_gpu_gc_max_pause_ms,
    histogram_gpu_ghost_windows.key_value AS histogram_gpu_ghost_windows,
    histogram_gpu_gpu_process_initialization_time_ms.key_value AS histogram_gpu_gpu_process_initialization_time_ms,
    histogram_gpu_http_channel_disposition.key_value AS histogram_gpu_http_channel_disposition,
    histogram_gpu_http_pageload_is_ssl.key_value AS histogram_gpu_http_pageload_is_ssl,
    ARRAY(
      SELECT AS STRUCT
        * REPLACE (_0.value.key_value AS value)
      FROM
        UNNEST(histogram_gpu_ipc_read_main_thread_latency_ms.key_value) AS _0
    ) AS histogram_gpu_ipc_read_main_thread_latency_ms,
    histogram_gpu_search_reset_result.key_value AS histogram_gpu_search_reset_result,
    histogram_gpu_ssl_handshake_result.key_value AS histogram_gpu_ssl_handshake_result,
    histogram_gpu_ssl_handshake_version.key_value AS histogram_gpu_ssl_handshake_version,
    histogram_gpu_ssl_tls12_intolerance_reason_pre.key_value AS histogram_gpu_ssl_tls12_intolerance_reason_pre,
    histogram_gpu_ssl_tls13_intolerance_reason_pre.key_value AS histogram_gpu_ssl_tls13_intolerance_reason_pre,
    histogram_gpu_time_to_first_click_ms.key_value AS histogram_gpu_time_to_first_click_ms,
    histogram_gpu_time_to_first_interaction_ms.key_value AS histogram_gpu_time_to_first_interaction_ms,
    histogram_gpu_time_to_first_key_input_ms.key_value AS histogram_gpu_time_to_first_key_input_ms,
    histogram_gpu_time_to_first_mouse_move_ms.key_value AS histogram_gpu_time_to_first_mouse_move_ms,
    histogram_gpu_time_to_first_scroll_ms.key_value AS histogram_gpu_time_to_first_scroll_ms,
    histogram_gpu_time_to_non_blank_paint_ms.key_value AS histogram_gpu_time_to_non_blank_paint_ms,
    histogram_gpu_touch_enabled_device.key_value AS histogram_gpu_touch_enabled_device,
    histogram_gpu_tracking_protection_enabled.key_value AS histogram_gpu_tracking_protection_enabled,
    ARRAY(
      SELECT AS STRUCT
        * REPLACE (_0.value.key_value AS value)
      FROM
        UNNEST(histogram_gpu_uptake_remote_content_result_1.key_value) AS _0
    ) AS histogram_gpu_uptake_remote_content_result_1,
    histogram_gpu_webvr_time_spent_viewing_in_oculus.key_value AS histogram_gpu_webvr_time_spent_viewing_in_oculus,
    histogram_gpu_webvr_time_spent_viewing_in_openvr.key_value AS histogram_gpu_webvr_time_spent_viewing_in_openvr,
    histogram_gpu_webvr_users_view_in.key_value AS histogram_gpu_webvr_users_view_in,
    histogram_parent_a11y_consumers.key_value AS histogram_parent_a11y_consumers,
    histogram_parent_a11y_instantiated_flag.key_value AS histogram_parent_a11y_instantiated_flag,
    histogram_parent_cert_validation_success_by_ca.key_value AS histogram_parent_cert_validation_success_by_ca,
    histogram_parent_checkerboard_severity.key_value AS histogram_parent_checkerboard_severity,
    histogram_parent_composite_time.key_value AS histogram_parent_composite_time,
    histogram_parent_content_frame_time.key_value AS histogram_parent_content_frame_time,
    histogram_parent_content_paint_time.key_value AS histogram_parent_content_paint_time,
    histogram_parent_cookie_behavior.key_value AS histogram_parent_cookie_behavior,
    histogram_parent_cycle_collector_max_pause.key_value AS histogram_parent_cycle_collector_max_pause,
    histogram_parent_devtools_about_devtools_opened_key.key_value AS histogram_parent_devtools_about_devtools_opened_key,
    histogram_parent_devtools_about_devtools_opened_reason.key_value AS histogram_parent_devtools_about_devtools_opened_reason,
    histogram_parent_devtools_accessibility_picker_time_active_seconds.key_value AS histogram_parent_devtools_accessibility_picker_time_active_seconds,
    histogram_parent_devtools_accessibility_service_time_active_seconds.key_value AS histogram_parent_devtools_accessibility_service_time_active_seconds,
    histogram_parent_devtools_accessibility_time_active_seconds.key_value AS histogram_parent_devtools_accessibility_time_active_seconds,
    histogram_parent_devtools_entry_point.key_value AS histogram_parent_devtools_entry_point,
    histogram_parent_devtools_fonteditor_font_type_displayed.key_value AS histogram_parent_devtools_fonteditor_font_type_displayed,
    histogram_parent_devtools_fonteditor_n_font_axes.key_value AS histogram_parent_devtools_fonteditor_n_font_axes,
    histogram_parent_devtools_fonteditor_n_fonts_rendered.key_value AS histogram_parent_devtools_fonteditor_n_fonts_rendered,
    histogram_parent_devtools_toolbox_time_active_seconds.key_value AS histogram_parent_devtools_toolbox_time_active_seconds,
    histogram_parent_dns_failed_lookup_time.key_value AS histogram_parent_dns_failed_lookup_time,
    histogram_parent_dns_lookup_time.key_value AS histogram_parent_dns_lookup_time,
    histogram_parent_fx_new_window_ms.key_value AS histogram_parent_fx_new_window_ms,
    histogram_parent_fx_page_load_ms_2.key_value AS histogram_parent_fx_page_load_ms_2,
    histogram_parent_fx_searchbar_selected_result_method.key_value AS histogram_parent_fx_searchbar_selected_result_method,
    histogram_parent_fx_session_restore_restore_window_ms.key_value AS histogram_parent_fx_session_restore_restore_window_ms,
    histogram_parent_fx_session_restore_startup_init_session_ms.key_value AS histogram_parent_fx_session_restore_startup_init_session_ms,
    histogram_parent_fx_session_restore_startup_onload_initial_window_ms.key_value AS histogram_parent_fx_session_restore_startup_onload_initial_window_ms,
    histogram_parent_fx_tab_close_time_anim_ms.key_value AS histogram_parent_fx_tab_close_time_anim_ms,
    histogram_parent_fx_tab_switch_total_e10s_ms.key_value AS histogram_parent_fx_tab_switch_total_e10s_ms,
    histogram_parent_fx_tab_switch_update_ms.key_value AS histogram_parent_fx_tab_switch_update_ms,
    histogram_parent_fx_urlbar_selected_result_index.key_value AS histogram_parent_fx_urlbar_selected_result_index,
    ARRAY(
      SELECT AS STRUCT
        * REPLACE (_0.value.key_value AS value)
      FROM
        UNNEST(histogram_parent_fx_urlbar_selected_result_index_by_type.key_value) AS _0
    ) AS histogram_parent_fx_urlbar_selected_result_index_by_type,
    histogram_parent_fx_urlbar_selected_result_method.key_value AS histogram_parent_fx_urlbar_selected_result_method,
    histogram_parent_fx_urlbar_selected_result_type.key_value AS histogram_parent_fx_urlbar_selected_result_type,
    histogram_parent_gc_animation_ms.key_value AS histogram_parent_gc_animation_ms,
    histogram_parent_gc_max_pause_ms.key_value AS histogram_parent_gc_max_pause_ms,
    histogram_parent_gc_max_pause_ms_2.key_value AS histogram_parent_gc_max_pause_ms_2,
    histogram_parent_geolocation_request_granted.key_value AS histogram_parent_geolocation_request_granted,
    histogram_parent_ghost_windows.key_value AS histogram_parent_ghost_windows,
    histogram_parent_gpu_process_initialization_time_ms.key_value AS histogram_parent_gpu_process_initialization_time_ms,
    histogram_parent_gpu_process_launch_time_ms_2.key_value AS histogram_parent_gpu_process_launch_time_ms_2,
    histogram_parent_http_channel_disposition.key_value AS histogram_parent_http_channel_disposition,
    histogram_parent_http_pageload_is_ssl.key_value AS histogram_parent_http_pageload_is_ssl,
    histogram_parent_http_transaction_is_ssl.key_value AS histogram_parent_http_transaction_is_ssl,
    histogram_parent_input_event_response_coalesced_ms.key_value AS histogram_parent_input_event_response_coalesced_ms,
    ARRAY(
      SELECT AS STRUCT
        * REPLACE (_0.value.key_value AS value)
      FROM
        UNNEST(histogram_parent_ipc_read_main_thread_latency_ms.key_value) AS _0
    ) AS histogram_parent_ipc_read_main_thread_latency_ms,
    ARRAY(
      SELECT AS STRUCT
        * REPLACE (_0.value.key_value AS value)
      FROM
        UNNEST(histogram_parent_memory_distribution_among_content.key_value) AS _0
    ) AS histogram_parent_memory_distribution_among_content,
    histogram_parent_memory_heap_allocated.key_value AS histogram_parent_memory_heap_allocated,
    histogram_parent_memory_resident_fast.key_value AS histogram_parent_memory_resident_fast,
    histogram_parent_memory_total.key_value AS histogram_parent_memory_total,
    histogram_parent_memory_unique.key_value AS histogram_parent_memory_unique,
    histogram_parent_memory_vsize.key_value AS histogram_parent_memory_vsize,
    histogram_parent_memory_vsize_max_contiguous.key_value AS histogram_parent_memory_vsize_max_contiguous,
    histogram_parent_network_cache_metadata_first_read_time_ms.key_value AS histogram_parent_network_cache_metadata_first_read_time_ms,
    histogram_parent_network_cache_v2_hit_time_ms.key_value AS histogram_parent_network_cache_v2_hit_time_ms,
    histogram_parent_network_cache_v2_miss_time_ms.key_value AS histogram_parent_network_cache_v2_miss_time_ms,
    histogram_parent_places_autocomplete_6_first_results_time_ms.key_value AS histogram_parent_places_autocomplete_6_first_results_time_ms,
    histogram_parent_plugin_shutdown_ms.key_value AS histogram_parent_plugin_shutdown_ms,
    histogram_parent_pwmgr_blocklist_num_sites.key_value AS histogram_parent_pwmgr_blocklist_num_sites,
    histogram_parent_pwmgr_form_autofill_result.key_value AS histogram_parent_pwmgr_form_autofill_result,
    histogram_parent_pwmgr_login_last_used_days.key_value AS histogram_parent_pwmgr_login_last_used_days,
    histogram_parent_pwmgr_login_page_safety.key_value AS histogram_parent_pwmgr_login_page_safety,
    histogram_parent_pwmgr_manage_opened.key_value AS histogram_parent_pwmgr_manage_opened,
    histogram_parent_pwmgr_manage_visibility_toggled.key_value AS histogram_parent_pwmgr_manage_visibility_toggled,
    histogram_parent_pwmgr_num_passwords_per_hostname.key_value AS histogram_parent_pwmgr_num_passwords_per_hostname,
    histogram_parent_pwmgr_num_saved_passwords.key_value AS histogram_parent_pwmgr_num_saved_passwords,
    histogram_parent_pwmgr_prompt_remember_action.key_value AS histogram_parent_pwmgr_prompt_remember_action,
    histogram_parent_pwmgr_prompt_update_action.key_value AS histogram_parent_pwmgr_prompt_update_action,
    histogram_parent_pwmgr_saving_enabled.key_value AS histogram_parent_pwmgr_saving_enabled,
    histogram_parent_sandbox_rejected_syscalls.key_value AS histogram_parent_sandbox_rejected_syscalls,
    histogram_parent_search_reset_result.key_value AS histogram_parent_search_reset_result,
    histogram_parent_search_service_init_ms.key_value AS histogram_parent_search_service_init_ms,
    histogram_parent_ssl_handshake_result.key_value AS histogram_parent_ssl_handshake_result,
    histogram_parent_ssl_handshake_version.key_value AS histogram_parent_ssl_handshake_version,
    histogram_parent_ssl_tls12_intolerance_reason_pre.key_value AS histogram_parent_ssl_tls12_intolerance_reason_pre,
    histogram_parent_ssl_tls13_intolerance_reason_pre.key_value AS histogram_parent_ssl_tls13_intolerance_reason_pre,
    histogram_parent_time_to_first_click_ms.key_value AS histogram_parent_time_to_first_click_ms,
    histogram_parent_time_to_first_interaction_ms.key_value AS histogram_parent_time_to_first_interaction_ms,
    histogram_parent_time_to_first_key_input_ms.key_value AS histogram_parent_time_to_first_key_input_ms,
    histogram_parent_time_to_first_mouse_move_ms.key_value AS histogram_parent_time_to_first_mouse_move_ms,
    histogram_parent_time_to_first_scroll_ms.key_value AS histogram_parent_time_to_first_scroll_ms,
    histogram_parent_time_to_non_blank_paint_ms.key_value AS histogram_parent_time_to_non_blank_paint_ms,
    histogram_parent_time_to_response_start_ms.key_value AS histogram_parent_time_to_response_start_ms,
    histogram_parent_touch_enabled_device.key_value AS histogram_parent_touch_enabled_device,
    histogram_parent_tracking_protection_enabled.key_value AS histogram_parent_tracking_protection_enabled,
    histogram_parent_update_bits_result_complete.key_value AS histogram_parent_update_bits_result_complete,
    histogram_parent_update_bits_result_partial.key_value AS histogram_parent_update_bits_result_partial,
    histogram_parent_update_can_use_bits_notify.key_value AS histogram_parent_update_can_use_bits_notify,
    histogram_parent_update_download_code_complete.key_value AS histogram_parent_update_download_code_complete,
    histogram_parent_update_download_code_partial.key_value AS histogram_parent_update_download_code_partial,
    histogram_parent_update_state_code_complete_stage.key_value AS histogram_parent_update_state_code_complete_stage,
    histogram_parent_update_state_code_complete_startup.key_value AS histogram_parent_update_state_code_complete_startup,
    histogram_parent_update_state_code_partial_stage.key_value AS histogram_parent_update_state_code_partial_stage,
    histogram_parent_update_state_code_partial_startup.key_value AS histogram_parent_update_state_code_partial_startup,
    histogram_parent_update_status_error_code_complete_stage.key_value AS histogram_parent_update_status_error_code_complete_stage,
    histogram_parent_update_status_error_code_complete_startup.key_value AS histogram_parent_update_status_error_code_complete_startup,
    histogram_parent_update_status_error_code_partial_stage.key_value AS histogram_parent_update_status_error_code_partial_stage,
    histogram_parent_update_status_error_code_partial_startup.key_value AS histogram_parent_update_status_error_code_partial_startup,
    ARRAY(
      SELECT AS STRUCT
        * REPLACE (_0.value.key_value AS value)
      FROM
        UNNEST(histogram_parent_uptake_remote_content_result_1.key_value) AS _0
    ) AS histogram_parent_uptake_remote_content_result_1,
    histogram_parent_webext_background_page_load_ms.key_value AS histogram_parent_webext_background_page_load_ms,
    histogram_parent_webext_browseraction_popup_open_ms.key_value AS histogram_parent_webext_browseraction_popup_open_ms,
    histogram_parent_webext_browseraction_popup_preload_result_count.key_value AS histogram_parent_webext_browseraction_popup_preload_result_count,
    histogram_parent_webext_content_script_injection_ms.key_value AS histogram_parent_webext_content_script_injection_ms,
    histogram_parent_webext_extension_startup_ms.key_value AS histogram_parent_webext_extension_startup_ms,
    histogram_parent_webext_pageaction_popup_open_ms.key_value AS histogram_parent_webext_pageaction_popup_open_ms,
    histogram_parent_webext_storage_local_get_ms.key_value AS histogram_parent_webext_storage_local_get_ms,
    histogram_parent_webext_storage_local_set_ms.key_value AS histogram_parent_webext_storage_local_set_ms,
    histogram_parent_webvr_time_spent_viewing_in_2d.key_value AS histogram_parent_webvr_time_spent_viewing_in_2d,
    histogram_parent_webvr_time_spent_viewing_in_oculus.key_value AS histogram_parent_webvr_time_spent_viewing_in_oculus,
    histogram_parent_webvr_time_spent_viewing_in_openvr.key_value AS histogram_parent_webvr_time_spent_viewing_in_openvr,
    histogram_parent_webvr_users_view_in.key_value AS histogram_parent_webvr_users_view_in,
    ARRAY(
      SELECT AS STRUCT
        * REPLACE (_0.value.key_value AS value)
      FROM
        UNNEST(keyed_boolean_addon_scalars.key_value) AS _0
    ) AS keyed_boolean_addon_scalars,
    ARRAY(
      SELECT AS STRUCT
        * REPLACE (_0.value.key_value AS value)
      FROM
        UNNEST(keyed_string_addon_scalars.key_value) AS _0
    ) AS keyed_string_addon_scalars,
    ARRAY(
      SELECT AS STRUCT
        * REPLACE (_0.value.key_value AS value)
      FROM
        UNNEST(keyed_uint_addon_scalars.key_value) AS _0
    ) AS keyed_uint_addon_scalars,
    popup_notification_stats.key_value AS popup_notification_stats,
    scalar_content_dom_event_confluence_load_count.key_value AS scalar_content_dom_event_confluence_load_count,
    scalar_content_dom_event_office_online_load_count.key_value AS scalar_content_dom_event_office_online_load_count,
    scalar_content_gfx_small_paint_phase_weight.key_value AS scalar_content_gfx_small_paint_phase_weight,
    scalar_content_images_webp_content_frequency.key_value AS scalar_content_images_webp_content_frequency,
    scalar_content_pictureinpicture_opened_method.key_value AS scalar_content_pictureinpicture_opened_method,
    scalar_content_telemetry_accumulate_unknown_histogram_keys.key_value AS scalar_content_telemetry_accumulate_unknown_histogram_keys,
    scalar_content_telemetry_event_counts.key_value AS scalar_content_telemetry_event_counts,
    scalar_content_webrtc_sdp_parser_diff.key_value AS scalar_content_webrtc_sdp_parser_diff,
    scalar_content_webrtc_video_recv_codec_used.key_value AS scalar_content_webrtc_video_recv_codec_used,
    scalar_content_webrtc_video_send_codec_used.key_value AS scalar_content_webrtc_video_send_codec_used,
    scalar_gpu_telemetry_accumulate_unknown_histogram_keys.key_value AS scalar_gpu_telemetry_accumulate_unknown_histogram_keys,
    scalar_gpu_telemetry_event_counts.key_value AS scalar_gpu_telemetry_event_counts,
    scalar_parent_a11y_theme.key_value AS scalar_parent_a11y_theme,
    scalar_parent_browser_engagement_navigation_about_home.key_value AS scalar_parent_browser_engagement_navigation_about_home,
    scalar_parent_browser_engagement_navigation_about_newtab.key_value AS scalar_parent_browser_engagement_navigation_about_newtab,
    scalar_parent_browser_engagement_navigation_contextmenu.key_value AS scalar_parent_browser_engagement_navigation_contextmenu,
    scalar_parent_browser_engagement_navigation_searchbar.key_value AS scalar_parent_browser_engagement_navigation_searchbar,
    scalar_parent_browser_engagement_navigation_urlbar.key_value AS scalar_parent_browser_engagement_navigation_urlbar,
    scalar_parent_browser_engagement_navigation_webextension.key_value AS scalar_parent_browser_engagement_navigation_webextension,
    scalar_parent_browser_errors_collected_count_by_filename.key_value AS scalar_parent_browser_errors_collected_count_by_filename,
    scalar_parent_browser_search_ad_clicks.key_value AS scalar_parent_browser_search_ad_clicks,
    scalar_parent_browser_search_with_ads.key_value AS scalar_parent_browser_search_with_ads,
    scalar_parent_devtools_accessibility_accessible_context_menu_item_activated.key_value AS scalar_parent_devtools_accessibility_accessible_context_menu_item_activated,
    scalar_parent_devtools_accessibility_audit_activated.key_value AS scalar_parent_devtools_accessibility_audit_activated,
    scalar_parent_devtools_accessibility_select_accessible_for_node.key_value AS scalar_parent_devtools_accessibility_select_accessible_for_node,
    scalar_parent_devtools_current_theme.key_value AS scalar_parent_devtools_current_theme,
    scalar_parent_devtools_inspector_three_pane_enabled.key_value AS scalar_parent_devtools_inspector_three_pane_enabled,
    scalar_parent_devtools_responsive_open_trigger.key_value AS scalar_parent_devtools_responsive_open_trigger,
    scalar_parent_devtools_tool_registered.key_value AS scalar_parent_devtools_tool_registered,
    scalar_parent_devtools_toolbox_tabs_reordered.key_value AS scalar_parent_devtools_toolbox_tabs_reordered,
    scalar_parent_devtools_tooltip_shown.key_value AS scalar_parent_devtools_tooltip_shown,
    scalar_parent_extensions_updates_rdf.key_value AS scalar_parent_extensions_updates_rdf,
    scalar_parent_gfx_advanced_layers_failure_id.key_value AS scalar_parent_gfx_advanced_layers_failure_id,
    scalar_parent_images_webp_content_frequency.key_value AS scalar_parent_images_webp_content_frequency,
    scalar_parent_networking_data_transferred.key_value AS scalar_parent_networking_data_transferred,
    scalar_parent_networking_data_transferred_kb.key_value AS scalar_parent_networking_data_transferred_kb,
    scalar_parent_networking_data_transferred_v3_kb.key_value AS scalar_parent_networking_data_transferred_v3_kb,
    scalar_parent_normandy_recipe_freshness.key_value AS scalar_parent_normandy_recipe_freshness,
    scalar_parent_pictureinpicture_closed_method.key_value AS scalar_parent_pictureinpicture_closed_method,
    scalar_parent_preferences_browser_home_page_change.key_value AS scalar_parent_preferences_browser_home_page_change,
    scalar_parent_preferences_browser_home_page_count.key_value AS scalar_parent_preferences_browser_home_page_count,
    scalar_parent_preferences_search_query.key_value AS scalar_parent_preferences_search_query,
    scalar_parent_preferences_use_bookmark.key_value AS scalar_parent_preferences_use_bookmark,
    scalar_parent_preferences_use_current_page.key_value AS scalar_parent_preferences_use_current_page,
    scalar_parent_qm_origin_directory_unexpected_filename.key_value AS scalar_parent_qm_origin_directory_unexpected_filename,
    scalar_parent_resistfingerprinting_content_window_size.key_value AS scalar_parent_resistfingerprinting_content_window_size,
    scalar_parent_sandbox_no_job.key_value AS scalar_parent_sandbox_no_job,
    scalar_parent_security_client_cert.key_value AS scalar_parent_security_client_cert,
    scalar_parent_security_pkcs11_modules_loaded.key_value AS scalar_parent_security_pkcs11_modules_loaded,
    scalar_parent_security_webauthn_used.key_value AS scalar_parent_security_webauthn_used,
    scalar_parent_services_sync_sync_login_state_transitions.key_value AS scalar_parent_services_sync_sync_login_state_transitions,
    scalar_parent_storage_sync_api_usage_items_stored.key_value AS scalar_parent_storage_sync_api_usage_items_stored,
    scalar_parent_storage_sync_api_usage_storage_consumed.key_value AS scalar_parent_storage_sync_api_usage_storage_consumed,
    scalar_parent_telemetry_accumulate_clamped_values.key_value AS scalar_parent_telemetry_accumulate_clamped_values,
    scalar_parent_telemetry_accumulate_unknown_histogram_keys.key_value AS scalar_parent_telemetry_accumulate_unknown_histogram_keys,
    scalar_parent_telemetry_event_counts.key_value AS scalar_parent_telemetry_event_counts,
    scalar_parent_telemetry_keyed_scalars_exceed_limit.key_value AS scalar_parent_telemetry_keyed_scalars_exceed_limit,
    scalar_parent_update_binarytransparencyresult.key_value AS scalar_parent_update_binarytransparencyresult,
    scalar_parent_update_bitshresult.key_value AS scalar_parent_update_bitshresult,
    scalar_parent_widget_ime_name_on_linux.key_value AS scalar_parent_widget_ime_name_on_linux,
    scalar_parent_widget_ime_name_on_mac.key_value AS scalar_parent_widget_ime_name_on_mac,
    scalar_parent_widget_ime_name_on_windows.key_value AS scalar_parent_widget_ime_name_on_windows,
    ARRAY(SELECT * FROM UNNEST(search_counts.list)) AS search_counts,
    ssl_handshake_result.key_value AS ssl_handshake_result,
    string_addon_scalars.key_value AS string_addon_scalars,
    uint_addon_scalars.key_value AS uint_addon_scalars
  )
FROM
  `moz-fx-data-shared-prod.telemetry_derived.first_shutdown_summary_v4`
~~~~
##[telemetry_mobile_event_parquet](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_mobile_event_parquet)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/telemetry_mobile_event_parquet/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.telemetry_mobile_event_parquet`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry.telemetry_mobile_event_parquet_v2`
~~~~
##[simpleprophet_forecasts](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/simpleprophet_forecasts)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/simpleprophet_forecasts/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.simpleprophet_forecasts`
AS
SELECT * FROM
  `moz-fx-data-shared-prod.telemetry_derived.simpleprophet_forecasts_desktop_v1`
UNION ALL
SELECT * FROM
  `moz-fx-data-shared-prod.telemetry_derived.simpleprophet_forecasts_mobile_v1`
UNION ALL
SELECT * FROM
  `moz-fx-data-shared-prod.telemetry_derived.simpleprophet_forecasts_fxa_v1`
~~~~
##[eng_workflow_build_parquet](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/eng_workflow_build_parquet)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/eng_workflow_build_parquet/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.eng_workflow_build_parquet`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry.eng_workflow_build_parquet_v1`
~~~~
##[experiments_aggregates](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiments_aggregates)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/telemetry/experiments_aggregates/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.telemetry.experiments_aggregates`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.telemetry.experiments_aggregates_v1`
~~~~
