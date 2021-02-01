---
title: org_mozilla_firefox
---

##[event_types_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/org_mozilla_firefox/event_types_v1)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/org_mozilla_firefox/event_types_v1/metadata.yaml)

**Friendly name**: Firefox Android Release Event Types

**Description**: Recreate a view on the most recent data from event_types_v1

**Owners**: [frank@mozilla.com](mailto:frank@mozilla.com)

**Schedule**: daily

**DAG name**: [bqetl_fenix_event_rollup](https://github.com/mozilla/bigquery-etl/blob/master/dags/bqetl_fenix_event_rollup.py)

##[migrated_clients](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/org_mozilla_firefox/migrated_clients)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/org_mozilla_firefox/migrated_clients/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.org_mozilla_firefox.migrated_clients`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.org_mozilla_firefox_derived.migrated_clients_v1`
~~~~
##[migration](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/org_mozilla_firefox/migration)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/org_mozilla_firefox/migration/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.org_mozilla_firefox.migration`
AS
--Fennec Nightly
SELECT
  DATE(submission_timestamp) AS submission_date,
  * REPLACE ('nightly' AS normalized_channel)
FROM
  `moz-fx-data-shared-prod.org_mozilla_fennec_aurora_stable.migration_v1`
UNION ALL
--Fennec Beta
SELECT
  DATE(submission_timestamp) AS submission_date,
  * REPLACE ('beta' AS normalized_channel)
FROM
  `moz-fx-data-shared-prod.org_mozilla_firefox_beta_stable.migration_v1`
UNION ALL
--Fennec Release
SELECT
  DATE(submission_timestamp) AS submission_date,
  * REPLACE ('release' AS normalized_channel)
FROM
  `moz-fx-data-shared-prod.org_mozilla_firefox_stable.migration_v1`
~~~~
##[events_daily](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/org_mozilla_firefox/events_daily)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/org_mozilla_firefox/events_daily/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.org_mozilla_firefox.events_daily`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.org_mozilla_firefox_derived.events_daily_v1`
~~~~
