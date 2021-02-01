---
title: messaging_system
---

##[onboarding_exact_mau28_by_dimensions](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/messaging_system/onboarding_exact_mau28_by_dimensions)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/messaging_system/onboarding_exact_mau28_by_dimensions/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.messaging_system.onboarding_exact_mau28_by_dimensions`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.messaging_system_derived.onboarding_exact_mau28_by_dimensions_v1`
~~~~
##[onboarding_retention_events_amplitude](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/messaging_system/onboarding_retention_events_amplitude)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/messaging_system/onboarding_retention_events_amplitude/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.messaging_system.onboarding_retention_events_amplitude`
AS
SELECT
  TIMESTAMP(submission_date) AS submission_timestamp,
  client_id AS device_id,
  CONCAT(client_id, submission_date) AS insert_id,
  "RETENTION" AS event_type,
  TIMESTAMP(submission_date) AS timestamp,
  app_version,
  REGEXP_EXTRACT(os, '^\\w+') AS platform,
  os AS os_name,
  os_version,
  cd.country AS country,
  geo_subdivision1 AS region,
  city,
  -- No `event_properties` for this event
  TO_JSON_STRING(
    STRUCT(
      cd.locale AS locale,
      channel AS release_channel,
      ARRAY(SELECT CONCAT(key, " - ", value) FROM UNNEST(experiments)) AS experiments
    )
  ) AS user_properties
FROM
  `moz-fx-data-shared-prod.messaging_system.onboarding_users_last_seen`
JOIN
  `moz-fx-data-shared-prod.telemetry.clients_daily` cd
USING
  (client_id, submission_date)
~~~~
##[snippets_users_daily](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/messaging_system/snippets_users_daily)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/messaging_system/snippets_users_daily/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.messaging_system.snippets_users_daily`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.messaging_system_derived.snippets_users_daily_v1`
~~~~
##[onboarding_events_amplitude](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/messaging_system/onboarding_events_amplitude)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/messaging_system/onboarding_events_amplitude/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.messaging_system.onboarding_events_amplitude`
AS
SELECT
  submission_timestamp,
  client_id AS device_id,
  document_id AS insert_id,
  event AS event_type,
  submission_timestamp AS timestamp,
  version AS app_version,
  REGEXP_EXTRACT(metadata.user_agent.os, '^\\w+') AS platform,
  metadata.user_agent.os AS os_name,
  normalized_os_version AS os_version,
  metadata.geo.country AS country,
  metadata.geo.subdivision1 AS region,
  metadata.geo.city AS city,
  (
    `moz-fx-data-shared-prod.udf.kv_array_append_to_json_string`(
      event_context,
      [STRUCT("message_id" AS key, message_id AS value)]
    )
  ) AS event_properties,
  TO_JSON_STRING(
    STRUCT(
      locale,
      release_channel,
      ARRAY(SELECT CONCAT(key, " - ", value.branch) FROM UNNEST(experiments)) AS experiments,
      attribution.source AS attribution_source,
      attribution.ua AS attribution_ua
    )
  ) AS user_properties
FROM
  `moz-fx-data-shared-prod.messaging_system_stable.onboarding_v1`
WHERE
  -- Fetch events on about:welcome only to minimize the event volume
  event_context LIKE "%about:welcome%"
~~~~
##[cfr_users_last_seen](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/messaging_system/cfr_users_last_seen)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/messaging_system/cfr_users_last_seen/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.messaging_system.cfr_users_last_seen`
AS
SELECT
  `moz-fx-data-shared-prod.udf.pos_of_trailing_set_bit`(days_seen_bits) AS days_since_seen,
  `moz-fx-data-shared-prod.udf.pos_of_trailing_set_bit`(
    days_seen_whats_new_bits
  ) AS days_since_seen_whats_new,
  *
FROM
  `moz-fx-data-shared-prod.messaging_system_derived.cfr_users_last_seen_v1`
~~~~
##[cfr_users_daily](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/messaging_system/cfr_users_daily)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/messaging_system/cfr_users_daily/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.messaging_system.cfr_users_daily`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.messaging_system_derived.cfr_users_daily_v1`
~~~~
##[onboarding_users_last_seen](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/messaging_system/onboarding_users_last_seen)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/messaging_system/onboarding_users_last_seen/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.messaging_system.onboarding_users_last_seen`
AS
SELECT
  `moz-fx-data-shared-prod.udf.pos_of_trailing_set_bit`(days_seen_bits) AS days_since_seen,
  *
FROM
  `moz-fx-data-shared-prod.messaging_system_derived.onboarding_users_last_seen_v1`
~~~~
##[snippets_users_last_seen](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/messaging_system/snippets_users_last_seen)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/messaging_system/snippets_users_last_seen/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.messaging_system.snippets_users_last_seen`
AS
SELECT
  `moz-fx-data-shared-prod.udf.pos_of_trailing_set_bit`(days_seen_bits) AS days_since_seen,
  *
FROM
  `moz-fx-data-shared-prod.messaging_system_derived.snippets_users_last_seen_v1`
~~~~
##[snippets_exact_mau28_by_dimensions](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/messaging_system/snippets_exact_mau28_by_dimensions)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/messaging_system/snippets_exact_mau28_by_dimensions/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.messaging_system.snippets_exact_mau28_by_dimensions`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.messaging_system_derived.snippets_exact_mau28_by_dimensions_v1`
~~~~
##[cfr_exact_mau28_by_dimensions](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/messaging_system/cfr_exact_mau28_by_dimensions)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/messaging_system/cfr_exact_mau28_by_dimensions/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.messaging_system.cfr_exact_mau28_by_dimensions`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.messaging_system_derived.cfr_exact_mau28_by_dimensions_v1`
~~~~
##[onboarding_users_daily](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/messaging_system/onboarding_users_daily)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/messaging_system/onboarding_users_daily/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.messaging_system.onboarding_users_daily`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.messaging_system_derived.onboarding_users_daily_v1`
~~~~
