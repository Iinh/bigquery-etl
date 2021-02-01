---
title: firefox_accounts
---

##[fxa_log_performance_events](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/firefox_accounts/fxa_log_performance_events)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/firefox_accounts/fxa_log_performance_events/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.firefox_accounts.fxa_log_performance_events`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.firefox_accounts_derived.fxa_log_content_events_v1`
WHERE
  STARTS_WITH(event, 'flow.performance')
~~~~
##[fxa_amplitude_email_clicks](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/firefox_accounts/fxa_amplitude_email_clicks)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/firefox_accounts/fxa_amplitude_email_clicks/view.sql)

~~~~sql
/*

See https://bugzilla.mozilla.org/show_bug.cgi?id=1633918

Due to permissions issues, this view is published via the fxa_export_to_amplitude DAG
rather than the schema deployment pipeline.

*/
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.firefox_accounts.fxa_amplitude_email_clicks`
AS
WITH hmac_key AS (
  SELECT
    AEAD.DECRYPT_BYTES(
      (SELECT keyset FROM `moz-fx-dataops-secrets.airflow_query_keys.fxa_prod`),
      ciphertext,
      CAST(key_id AS BYTES)
    ) AS value
  FROM
    `moz-fx-data-shared-prod.firefox_accounts_derived.encrypted_keys_v1`
  WHERE
    key_id = 'fxa_hmac_prod'
),
-- sendjobs.EmailName is parsed via regex;
-- see format definition in https://docs.google.com/spreadsheets/d/1mHpXSoDcfYK8XSX4bf-CHSfdn8XY5svDAw8ik5FhPrs/edit#gid=1626564614
-- and original regex in https://github.com/mozilla/fxa-amplitude-send/blob/89bfaef20a1d978fce2dccddc0155699a17ac172/marketing.js#L109
email_name_regex AS (
  SELECT AS VALUE
    r"^\w*(MoCo|MoFo|PKT)_([A-Z]+)_([A-Za-z-]+)_(20[0-9][0-9])(?:_([A-Za-z-]+))?_(?:HTML|TEXT)_([^_]+)(?:_(ALL|[A-Z]{2}))?_([A-Za-z-]+)_EML(?:_(.*))?"
),
-- The sendjobs table is tiny (< 1 GB) and a given sendjob can appear in
-- multiple snapshots, so we deduplicate over all history, taking the newest.
sendjobs_numbered AS (
  SELECT
    *,
    SPLIT(
      REGEXP_REPLACE(EmailName, (SELECT * FROM email_name_regex), r"\1;\2;\3;\4;\5;\6;\7;\8;\9"),
      ';'
    ) AS parsed,
    ROW_NUMBER() OVER (PARTITION BY SendID ORDER BY snapshot_date DESC) AS _n
  FROM
    `mozilla-cdp-prod.sfmc.sendjobs`
  WHERE
    REGEXP_CONTAINS(EmailName, (SELECT * FROM email_name_regex))
),
sendjobs AS (
  SELECT
    * EXCEPT (_n, parsed),
    parsed[ORDINAL(1)] AS email_sender,
    parsed[ORDINAL(2)] AS email_region,
    parsed[ORDINAL(3)] AS email_audience,
    parsed[ORDINAL(4)] AS email_year,
    parsed[ORDINAL(5)] AS email_category,
    parsed[ORDINAL(6)] AS email_id,
    parsed[ORDINAL(7)] AS email_country,
    parsed[ORDINAL(8)] AS email_language,
    parsed[ORDINAL(9)] AS email_push_number,
  FROM
    sendjobs_numbered
  WHERE
    _n = 1
),
-- Likewise, the customer_record table is fairly small (~10 GB), so it is feasible
-- to deduplicate over all history on the fly.
customers_numbered AS (
  SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY email ORDER BY fxa_ts DESC) AS _n
  FROM
    `mozilla-cdp-prod.fxa.customer_record`
),
customers_deduped AS (
  SELECT
    * EXCEPT (_n),
    IF(
      NET.PUBLIC_SUFFIX(email) IS NULL,
      NULL,
      -- We construct an "email_provider" field that is a simple name like "gmail", "outlook", etc.
      -- We use some BQ NET functions and string munging to get the hostname and
      -- remove common suffixes ".com", ".net", ".co.uk", etc.
      RTRIM(
        SUBSTR(NET.HOST(email), 1, LENGTH(NET.HOST(email)) - LENGTH(NET.PUBLIC_SUFFIX(email))),
        '.'
      )
    ) AS email_provider
  FROM
    customers_numbered
  WHERE
    _n = 1
),
-- We filter out email providers with fewer than 10k customers in this dataset,
-- roughly similar to how we filter out cities with fewer than 10k residents for
-- GeoIP lookups in the data pipeline.
email_providers_over_10k AS (
  SELECT
    email_provider
  FROM
    customers_deduped
  GROUP BY
    1
  HAVING
    count(*) > 10000
),
customers AS (
  SELECT
    * EXCEPT (email_provider),
    TO_HEX(
      `moz-fx-data-shared-prod`.udf.hmac_sha256((SELECT * FROM hmac_key), CAST(fxa_id AS BYTES))
    ) AS user_id,
    email_providers_over_10k.email_provider,
  FROM
    customers_deduped
  LEFT JOIN
    email_providers_over_10k
  USING
    (email_provider)
)
SELECT
  TIMESTAMP(clicks.snapshot_date) AS submission_timestamp,
  UNIX_MILLIS(clicks.EventDate) AS `time`,
  customers.user_id,
  ARRAY_TO_STRING([customers.user_id, clicks.SendId, string(clicks.EventDate)], '-') AS insert_id,
  'mktg - email_click' AS event_type,
  FORMAT(
    -- We use CONCAT here to avoid '{' directly followed by '%' which will be
    -- interpreted as opening a Jinja statement when run via Airflow's BigQueryOperator.
    CONCAT('{', '%t', '}'),
    ARRAY_TO_STRING(
      ARRAY(
        SELECT
          FORMAT('"%t":"%t"', key, value)
        FROM
          UNNEST(
            [
              STRUCT('email_provider' AS key, customers.email_provider AS value),
              STRUCT(
                'utm_source' AS key,
                REGEXP_EXTRACT(clicks.URL, r"[?&]utm_source=([^&]+)") AS value
              ),
              STRUCT(
                'utm_medium' AS key,
                REGEXP_EXTRACT(clicks.URL, r"[?&]utm_medium=([^&]+)") AS value
              ),
              STRUCT(
                'utm_campaign' AS key,
                REGEXP_EXTRACT(clicks.URL, r"[?&]utm_campaign=([^&]+)") AS value
              ),
              STRUCT(
                'utm_content' AS key,
                REGEXP_EXTRACT(clicks.URL, r"[?&]utm_content=([^&]+)") AS value
              ),
              STRUCT(
                'utm_term' AS key,
                REGEXP_EXTRACT(clicks.URL, r"[?&]utm_term=([^&]+)") AS value
              )
            ]
          )
        WHERE
          value IS NOT NULL
      ),
      ','
    )
  ) AS user_properties,
  FORMAT(
    CONCAT('{', '%t', '}'),
    ARRAY_TO_STRING(
      ARRAY(
        SELECT
          FORMAT('"%t":"%t"', key, value)
        FROM
          UNNEST(
            [
              STRUCT('service' AS key, customers.service AS value),
              STRUCT('email_alias' AS key, clicks.alias AS value),
              STRUCT('email_type' AS key, clicks.EventType AS value),
              STRUCT('email_sender' AS key, email_sender AS value),
              STRUCT('email_region' AS key, email_region AS value),
              STRUCT('email_audience' AS key, email_audience AS value),
              STRUCT('email_year' AS key, email_year AS value),
              STRUCT('email_category' AS key, email_category AS value),
              STRUCT('email_id' AS key, email_id AS value),
              STRUCT('email_country' AS key, email_country AS value),
              STRUCT('email_language' AS key, email_language AS value),
              STRUCT('email_push_number' AS key, email_push_number AS value)
            ]
          )
        WHERE
          value IS NOT NULL
          AND value != ''
      ),
      ','
    )
  ) AS event_properties,
FROM
  `mozilla-cdp-prod.sfmc.clicks` AS clicks
LEFT JOIN
  customers
ON
  (clicks.EmailAddress = customers.email)
LEFT JOIN
  sendjobs
USING
  (SendID)
WHERE
  user_id IS NOT NULL
~~~~
##[fxa_log_content_events](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/firefox_accounts/fxa_log_content_events)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/firefox_accounts/fxa_log_content_events/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.firefox_accounts.fxa_log_content_events`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.firefox_accounts_derived.fxa_log_content_events_v1`
WHERE
  NOT STARTS_WITH(event, 'flow.performance')
~~~~
##[sync_send_tab_export](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/firefox_accounts/sync_send_tab_export)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/firefox_accounts/sync_send_tab_export/view.sql)

~~~~sql
-- Sampled view on send tab metrics intended for sending to Amplitude;
-- see https://bugzilla.mozilla.org/show_bug.cgi?id=1628740
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.firefox_accounts.sync_send_tab_export`
AS
WITH events AS (
  SELECT
    *,
    `moz-fx-data-shared-prod`.udf.deanonymize_event(event).*
  FROM
    `moz-fx-data-shared-prod.telemetry.sync`
  CROSS JOIN
    UNNEST(payload.events) AS event
),
cleaned AS (
  SELECT
    *,
    payload.device_id,
    `moz-fx-data-shared-prod`.udf.get_key(event_map_values, 'serverTime') AS server_time,
    `moz-fx-data-shared-prod`.udf.normalize_os(payload.os.name) AS os_name,
    CASE
      event_object
    WHEN
      'processcommand'
    THEN
      'sync - tab_received'
    WHEN
      'sendcommand'
    THEN
      'sync - tab_sent'
    END
    AS event_type,
    `moz-fx-data-shared-prod`.udf.get_key(event_map_values, 'flowID') AS flow_id,
  FROM
    events
  WHERE
    event_method = 'displayURI'
)
SELECT
  cleaned.submission_timestamp,
  ids.user_id,
  device_id,
  ARRAY_TO_STRING(
    [device_id, event_category, event_method, event_object, server_time, flow_id],
    '-'
  ) AS insert_id,
  -- Amplitude expects a `time` field in milliseconds since UNIX epoch.
  COALESCE(
    -- server_time is in seconds, but with one digit after the decimal place, so we
    -- have to cast to float, multiply to get milliseconds, then cast to int.
    SAFE_CAST(SAFE_CAST(server_time AS FLOAT64) * 1000 AS INT64),
    -- server_time is sometimes null, so we fall back to submission_timestamp
    UNIX_MILLIS(cleaned.submission_timestamp)
  ) AS time,
  event_type,
  metadata.geo.country,
  metadata.geo.city,
  os_name,
  payload.os.version AS os_version,
  payload.os.locale AS `language`,
  FORMAT(
    '{%t}',
    ARRAY_TO_STRING(
      ARRAY(
        SELECT
          FORMAT('"%t":"%t"', key, value)
        FROM
          UNNEST(
            [
              STRUCT('fxa_uid' AS key, ids.user_id AS value),
              STRUCT('ua_browser', metadata.user_agent.browser),
              STRUCT('ua_version', metadata.user_agent.version)
            ]
          )
        WHERE
          value IS NOT NULL
      ),
      ','
    )
  ) AS user_properties,
  FORMAT(
    '{%t}',
    ARRAY_TO_STRING(
      ARRAY(
        SELECT
          FORMAT('"%t":"%t"', key, value)
        FROM
          UNNEST([STRUCT('flow_id' AS key, flow_id AS value)])
        WHERE
          value IS NOT NULL
      ),
      ','
    )
  ) AS event_properties,
FROM
  cleaned
-- We need this join because sync pings contain a truncated ID that is just the
-- first 32 characters of the 64-character hash sent to Amplitude by other producers;
-- we join based on the prefix to recover the full 64-character hash.
LEFT JOIN
  `moz-fx-data-shared-prod.firefox_accounts_derived.fxa_amplitude_user_ids_v1` AS ids
ON
  cleaned.payload.uid = SUBSTR(ids.user_id, 1, 32)
WHERE
  -- To save on Amplitude budget, we take a 10% sample based on user ID.
  MOD(ABS(FARM_FINGERPRINT(payload.uid)), 100) < 10
~~~~
##[fxa_content_auth_events](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/firefox_accounts/fxa_content_auth_events)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/firefox_accounts/fxa_content_auth_events/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.firefox_accounts.fxa_content_auth_events`
AS
  --
WITH content AS (
  SELECT
    jsonPayload.logger,
    jsonPayload.fields.event_type,
    jsonPayload.fields.app_version,
    jsonPayload.fields.os_name,
    jsonPayload.fields.os_version,
    jsonPayload.fields.country,
    jsonPayload.fields.language,
    jsonPayload.fields.user_id,
    jsonPayload.fields.user_properties,
    jsonPayload.fields.event_properties,
    `timestamp`,
    receiveTimestamp
  FROM
    `moz-fx-data-shared-prod.firefox_accounts_derived.fxa_content_events_v1`
),
  --
auth AS (
  SELECT
    jsonPayload.logger,
    jsonPayload.fields.event_type,
    jsonPayload.fields.app_version,
    jsonPayload.fields.os_name,
    jsonPayload.fields.os_version,
    jsonPayload.fields.country,
    jsonPayload.fields.language,
    jsonPayload.fields.user_id,
    jsonPayload.fields.user_properties,
    jsonPayload.fields.event_properties,
    `timestamp`,
    receiveTimestamp
  FROM
    `moz-fx-data-shared-prod.firefox_accounts_derived.fxa_auth_events_v1`
),
  --
unioned AS (
  SELECT
    *
  FROM
    auth
  UNION ALL
  SELECT
    *
  FROM
    content
)
  --
SELECT
  * EXCEPT (user_properties, event_properties),
  REPLACE(JSON_EXTRACT(user_properties, '$.utm_term'), "\"", "") AS utm_term,
  REPLACE(JSON_EXTRACT(user_properties, '$.utm_source'), "\"", "") AS utm_source,
  REPLACE(JSON_EXTRACT(user_properties, '$.utm_medium'), "\"", "") AS utm_medium,
  REPLACE(JSON_EXTRACT(user_properties, '$.utm_campaign'), "\"", "") AS utm_campaign,
  REPLACE(JSON_EXTRACT(user_properties, '$.ua_version'), "\"", "") AS ua_version,
  REPLACE(JSON_EXTRACT(user_properties, '$.ua_browser'), "\"", "") AS ua_browser,
  REPLACE(JSON_EXTRACT(user_properties, '$.entrypoint'), "\"", "") AS entrypoint,
  REPLACE(JSON_EXTRACT(user_properties, '$.flow_id'), "\"", "") AS flow_id,
  REPLACE(JSON_EXTRACT(event_properties, '$.service'), "\"", "") AS service,
  REPLACE(JSON_EXTRACT(event_properties, '$.email_type'), "\"", "") AS email_type,
  REPLACE(JSON_EXTRACT(event_properties, '$.email_provider'), "\"", "") AS email_provider,
  REPLACE(JSON_EXTRACT(event_properties, '$.oauth_client_id'), "\"", "") AS oauth_client_id,
  REPLACE(JSON_EXTRACT(event_properties, '$.connect_device_flow'), "\"", "") AS connect_device_flow,
  REPLACE(JSON_EXTRACT(event_properties, '$.connect_device_os'), "\"", "") AS connect_device_os,
  REPLACE(JSON_EXTRACT(user_properties, '$.sync_device_count'), "\"", "") AS sync_device_count,
  REPLACE(
    JSON_EXTRACT(user_properties, '$.sync_active_devices_day'),
    "\"",
    ""
  ) AS sync_active_devices_day,
  REPLACE(
    JSON_EXTRACT(user_properties, '$.sync_active_devices_week'),
    "\"",
    ""
  ) AS sync_active_devices_week,
  REPLACE(
    JSON_EXTRACT(user_properties, '$.sync_active_devices_month'),
    "\"",
    ""
  ) AS sync_active_devices_month,
  REPLACE(JSON_EXTRACT(event_properties, '$.email_sender'), "\"", "") AS email_sender,
  REPLACE(JSON_EXTRACT(event_properties, '$.email_service'), "\"", "") AS email_service,
  REPLACE(JSON_EXTRACT(event_properties, '$.email_template'), "\"", "") AS email_template,
  REPLACE(JSON_EXTRACT(event_properties, '$.email_version'), "\"", "") AS email_version
FROM
  unioned
~~~~
##[fxa_users_services_daily](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/firefox_accounts/fxa_users_services_daily)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/firefox_accounts/fxa_users_services_daily/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.firefox_accounts.fxa_users_services_daily`
AS
SELECT
  * REPLACE (cn.code AS country),
  fxa.country AS country_name
FROM
  `moz-fx-data-shared-prod.firefox_accounts_derived.fxa_users_services_daily_v1` AS fxa
LEFT JOIN
  `moz-fx-data-shared-prod.static.country_names_v1` AS cn
ON
  cn.name = fxa.country
~~~~
##[fxa_users_last_seen](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/firefox_accounts/fxa_users_last_seen)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/firefox_accounts/fxa_users_last_seen/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.firefox_accounts.fxa_users_last_seen`
AS
SELECT
  mozfun.bits28.days_since_seen(days_seen_bits) AS days_since_seen,
  mozfun.bits28.days_since_seen(
    days_seen_in_tier1_country_bits
  ) AS days_since_seen_in_tier1_country,
  mozfun.bits28.days_since_seen(days_registered_bits) AS days_since_registered,
  mozfun.bits28.days_since_seen(days_seen_no_monitor_bits) AS days_since_seen_no_monitor,
  *
FROM
  `moz-fx-data-shared-prod.firefox_accounts_derived.fxa_users_last_seen_v1`
~~~~
##[fxa_all_events](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/firefox_accounts/fxa_all_events)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/firefox_accounts/fxa_all_events/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.firefox_accounts.fxa_all_events`
AS
WITH fxa_auth_events AS (
  SELECT
    timestamp AS submission_timestamp,
    jsonPayload.fields.user_id,
    jsonPayload.fields.country,
    jsonPayload.fields.language,
    jsonPayload.fields.app_version,
    jsonPayload.fields.os_name,
    jsonPayload.fields.os_version,
    jsonPayload.fields.event_type,
    JSON_EXTRACT_SCALAR(jsonPayload.fields.event_properties, '$.service') AS service
  FROM
    `moz-fx-data-shared-prod.firefox_accounts_derived.fxa_auth_events_v1`
),
  -- This table doesn't include any user events that are considered "active",
  -- but should always be included for a complete raw event log.
fxa_auth_bounce_events AS (
  SELECT
    timestamp AS submission_timestamp,
    jsonPayload.fields.user_id,
    CAST(
      NULL AS STRING
    ) AS country,  -- No country field in auth_bounces
    jsonPayload.fields.language,
    jsonPayload.fields.app_version,
    CAST(NULL AS STRING),
    CAST(NULL AS STRING),
    jsonPayload.fields.event_type,
    JSON_EXTRACT_SCALAR(jsonPayload.fields.event_properties, '$.service') AS service
  FROM
    `moz-fx-data-shared-prod.firefox_accounts_derived.fxa_auth_bounce_events_v1`
),
fxa_content_events AS (
  SELECT
    timestamp AS submission_timestamp,
    jsonPayload.fields.user_id,
    jsonPayload.fields.country,
    jsonPayload.fields.language,
    jsonPayload.fields.app_version,
    jsonPayload.fields.os_name,
    jsonPayload.fields.os_version,
    jsonPayload.fields.event_type,
    JSON_EXTRACT_SCALAR(jsonPayload.fields.event_properties, '$.service') AS service
  FROM
    `moz-fx-data-shared-prod.firefox_accounts_derived.fxa_content_events_v1`
),
fxa_oauth_events AS (
  SELECT
    timestamp AS submission_timestamp,
    jsonPayload.fields.user_id,
    CAST(NULL AS STRING) AS country,
    CAST(NULL AS STRING) AS language,
    jsonPayload.fields.app_version,
    CAST(NULL AS STRING) AS os_name,
    CAST(NULL AS STRING) AS os_version,
    jsonPayload.fields.event_type,
    JSON_EXTRACT_SCALAR(jsonPayload.fields.event_properties, '$.service') AS service
  FROM
    `moz-fx-data-shared-prod.firefox_accounts_derived.fxa_oauth_events_v1`
)
SELECT
  *
FROM
  fxa_auth_events
UNION ALL
SELECT
  *
FROM
  fxa_auth_bounce_events
UNION ALL
SELECT
  *
FROM
  fxa_content_events
UNION ALL
SELECT
  *
FROM
  fxa_oauth_events
~~~~
##[fxa_log_device_command_events](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/firefox_accounts/fxa_log_device_command_events)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/firefox_accounts/fxa_log_device_command_events/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.firefox_accounts.fxa_log_device_command_events`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.firefox_accounts_derived.fxa_log_device_command_events_v1`
~~~~
##[fxa_amplitude_export](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/firefox_accounts/fxa_amplitude_export)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/firefox_accounts/fxa_amplitude_export/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.firefox_accounts.fxa_amplitude_export`
AS
WITH active_users AS (
  SELECT
    TIMESTAMP(submission_date_pacific, "America/Los_Angeles") AS submission_timestamp,
    `moz-fx-data-shared-prod`.udf.active_values_from_days_seen_map(
      os_used_month,
      0,
      1
    ) AS os_used_day,
    `moz-fx-data-shared-prod`.udf.active_values_from_days_seen_map(
      os_used_month,
      -6,
      7
    ) AS os_used_week,
    `moz-fx-data-shared-prod`.udf.active_values_from_days_seen_map(
      os_used_month,
      -27,
      28
    ) AS os_used_month,
    * EXCEPT (days_seen_bits, os_used_month, submission_date_pacific) REPLACE(
      TIMESTAMP(submission_date_pacific, "America/Los_Angeles") AS timestamp
    )
  FROM
    `moz-fx-data-shared-prod`.firefox_accounts_derived.fxa_amplitude_export_v1
  WHERE
    `moz-fx-data-shared-prod`.udf.pos_of_trailing_set_bit(days_seen_bits) = 0
),
active_events AS (
  SELECT
    submission_timestamp,
    user_id,
    insert_id,
    'fxa_activity - active' AS event_type,
    timestamp,
    TO_JSON_STRING(
      STRUCT(services AS service, oauth_client_ids, rollup_events)
    ) AS event_properties,
    region,
    country,
    `LANGUAGE`,
    app_version AS version,
    TO_JSON_STRING(os_used_day) AS os,
    '' AS user_properties
  FROM
    active_users
),
user_properties AS (
  SELECT
    submission_timestamp,
    user_id,
    '' AS insert_id,
    '$identify' AS event_type,
    timestamp,
    '' AS event_properties,
    -- Some Amplitude properties are top level
    region,
    country,
    `LANGUAGE`,
    app_version AS version,
    TO_JSON_STRING(os_used_day) AS os,
    -- We don't want to include user_properties if they are null, so we need
    -- to list them out explicitly and filter with WHERE
    CONCAT(
      "{",
      ARRAY_TO_STRING(
        ARRAY(
          SELECT
            CONCAT(TO_JSON_STRING(key), ":", value)
          FROM
            (
              SELECT AS STRUCT
                "os_used_day" AS key,
                TO_JSON_STRING(os_used_day) AS value,
              UNION ALL
              SELECT AS STRUCT
                "os_used_week" AS key,
                TO_JSON_STRING(os_used_week) AS value,
              UNION ALL
              SELECT AS STRUCT
                "os_used_month" AS key,
                TO_JSON_STRING(os_used_month) AS value,
              UNION ALL
              SELECT AS STRUCT
                "sync_device_count" AS key,
                TO_JSON_STRING(sync_device_count) AS value,
              UNION ALL
              SELECT AS STRUCT
                "sync_active_devices_day" AS key,
                TO_JSON_STRING(sync_active_devices_day) AS value,
              UNION ALL
              SELECT AS STRUCT
                "sync_active_devices_week" AS key,
                TO_JSON_STRING(sync_active_devices_week) AS value,
              UNION ALL
              SELECT AS STRUCT
                "sync_active_devices_month" AS key,
                TO_JSON_STRING(sync_active_devices_month) AS value,
              UNION ALL
              SELECT AS STRUCT
                "ua_version" AS key,
                TO_JSON_STRING(ua_version) AS value,
              UNION ALL
              SELECT AS STRUCT
                "ua_browser" AS key,
                TO_JSON_STRING(ua_browser) AS value,
              UNION ALL
              SELECT AS STRUCT
                "$postInsert",
                TO_JSON_STRING(STRUCT(fxa_services_used)) AS value
            )
          WHERE
            value != "null"
            AND value != "[]"
        ),
        ","
      ),
      "}"
    ) AS user_properties
  FROM
    active_users
),
all_events AS (
  SELECT
    *
  FROM
    active_events
  UNION ALL
  SELECT
    *
  FROM
    user_properties
)
SELECT
  *
FROM
  all_events
~~~~
##[fxa_log_auth_events](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/firefox_accounts/fxa_log_auth_events)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/firefox_accounts/fxa_log_auth_events/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.firefox_accounts.fxa_log_auth_events`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.firefox_accounts_derived.fxa_log_auth_events_v1`
~~~~
##[fxa_content_auth_oauth_events](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/firefox_accounts/fxa_content_auth_oauth_events)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/firefox_accounts/fxa_content_auth_oauth_events/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.firefox_accounts.fxa_content_auth_oauth_events`
AS
  --
WITH content AS (
  SELECT
    jsonPayload.logger,
    jsonPayload.fields.event_type,
    jsonPayload.fields.app_version,
    jsonPayload.fields.os_name,
    jsonPayload.fields.os_version,
    jsonPayload.fields.country,
    jsonPayload.fields.language,
    jsonPayload.fields.user_id,
    jsonPayload.fields.user_properties,
    jsonPayload.fields.event_properties,
    `timestamp`,
    receiveTimestamp
  FROM
    `moz-fx-data-shared-prod.firefox_accounts_derived.fxa_content_events_v1`
),
    --
auth AS (
  SELECT
    jsonPayload.logger,
    jsonPayload.fields.event_type,
    jsonPayload.fields.app_version,
    jsonPayload.fields.os_name,
    jsonPayload.fields.os_version,
    jsonPayload.fields.country,
    jsonPayload.fields.language,
    jsonPayload.fields.user_id,
    jsonPayload.fields.user_properties,
    jsonPayload.fields.event_properties,
    `timestamp`,
    receiveTimestamp
  FROM
    `moz-fx-data-shared-prod.firefox_accounts_derived.fxa_auth_events_v1`
),
    --
oauth AS (
  SELECT
    jsonPayload.logger,
    jsonPayload.fields.event_type,
    jsonPayload.fields.app_version,
    CAST(NULL AS STRING) AS os_name,
    CAST(NULL AS STRING) AS os_version,
    CAST(NULL AS STRING) AS country,
    CAST(NULL AS STRING) AS language,
    jsonPayload.fields.user_id,
    jsonPayload.fields.user_properties,
    jsonPayload.fields.event_properties,
    `timestamp`,
    receiveTimestamp
  FROM
    `moz-fx-data-shared-prod.firefox_accounts_derived.fxa_oauth_events_v1`
),
    --
unioned AS (
  SELECT
    *
  FROM
    auth
  UNION ALL
  SELECT
    *
  FROM
    content
  UNION ALL
  SELECT
    *
  FROM
    oauth
)
    --
SELECT
  * EXCEPT (user_properties, event_properties),
  REPLACE(JSON_EXTRACT(user_properties, '$.utm_term'), "\"", "") AS utm_term,
  REPLACE(JSON_EXTRACT(user_properties, '$.utm_source'), "\"", "") AS utm_source,
  REPLACE(JSON_EXTRACT(user_properties, '$.utm_medium'), "\"", "") AS utm_medium,
  REPLACE(JSON_EXTRACT(user_properties, '$.utm_campaign'), "\"", "") AS utm_campaign,
  REPLACE(JSON_EXTRACT(user_properties, '$.ua_version'), "\"", "") AS ua_version,
  REPLACE(JSON_EXTRACT(user_properties, '$.ua_browser'), "\"", "") AS ua_browser,
  REPLACE(JSON_EXTRACT(user_properties, '$.entrypoint'), "\"", "") AS entrypoint,
  REPLACE(JSON_EXTRACT(user_properties, '$.flow_id'), "\"", "") AS flow_id,
  REPLACE(JSON_EXTRACT(event_properties, '$.service'), "\"", "") AS service,
  REPLACE(JSON_EXTRACT(event_properties, '$.email_type'), "\"", "") AS email_type,
  REPLACE(JSON_EXTRACT(event_properties, '$.email_provider'), "\"", "") AS email_provider,
  REPLACE(JSON_EXTRACT(event_properties, '$.oauth_client_id'), "\"", "") AS oauth_client_id,
  REPLACE(JSON_EXTRACT(event_properties, '$.connect_device_flow'), "\"", "") AS connect_device_flow,
  REPLACE(JSON_EXTRACT(event_properties, '$.connect_device_os'), "\"", "") AS connect_device_os,
  REPLACE(JSON_EXTRACT(user_properties, '$.sync_device_count'), "\"", "") AS sync_device_count,
  REPLACE(
    JSON_EXTRACT(user_properties, '$.sync_active_devices_day'),
    "\"",
    ""
  ) AS sync_active_devices_day,
  REPLACE(
    JSON_EXTRACT(user_properties, '$.sync_active_devices_week'),
    "\"",
    ""
  ) AS sync_active_devices_week,
  REPLACE(
    JSON_EXTRACT(user_properties, '$.sync_active_devices_month'),
    "\"",
    ""
  ) AS sync_active_devices_month,
  REPLACE(JSON_EXTRACT(event_properties, '$.email_sender'), "\"", "") AS email_sender,
  REPLACE(JSON_EXTRACT(event_properties, '$.email_service'), "\"", "") AS email_service,
  REPLACE(JSON_EXTRACT(event_properties, '$.email_template'), "\"", "") AS email_template,
  REPLACE(JSON_EXTRACT(event_properties, '$.email_version'), "\"", "") AS email_version
FROM
  unioned
~~~~
