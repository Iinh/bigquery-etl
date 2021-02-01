---
title: amo_dev
---

##[amo_stats_dau](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/amo_dev/amo_stats_dau)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/amo_dev/amo_stats_dau/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.amo_dev.amo_stats_dau`
AS
SELECT
  submission_date,
  addon_id,
  dau,
  ARRAY(
    SELECT AS STRUCT
      IFNULL(key, 'Unknown') AS key,
      value
    FROM
      UNNEST(dau_by_addon_version)
  ) AS dau_by_addon_version,
  ARRAY(
    SELECT AS STRUCT
      IFNULL(key, 'Unknown') AS key,
      value
    FROM
      UNNEST(dau_by_app_os)
  ) AS dau_by_app_os,
  ARRAY(
    SELECT AS STRUCT
      IFNULL(key, 'Unknown') AS key,
      value
    FROM
      UNNEST(dau_by_app_version)
  ) AS dau_by_app_version,
  ARRAY(
    SELECT AS STRUCT
      IFNULL(key, 'Unknown') AS key,
      value
    FROM
      UNNEST(dau_by_fenix_build)
  ) AS dau_by_fenix_build,
  ARRAY(
    SELECT AS STRUCT
      IFNULL(key, 'Unknown') AS key,
      value
    FROM
      UNNEST(dau_by_country)
  ) AS dau_by_country,
  ARRAY(
    SELECT AS STRUCT
      IFNULL(key, 'Unknown') AS key,
      value
    FROM
      UNNEST(dau_by_locale)
  ) AS dau_by_locale,
FROM
  `moz-fx-data-shared-prod.amo_dev.amo_stats_dau_v2`
~~~~
##[amo_stats_dau_v2](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/amo_dev/amo_stats_dau_v2)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/amo_dev/amo_stats_dau_v2/metadata.yaml)

**Friendly name**: AMO Stats DAU dev/stage

**Description**: Reduced stats table for dev and stage versions of the AMO service.

**Owners**: [jklukas@mozilla.com](mailto:jklukas@mozilla.com)

**Schedule**: daily

**DAG name**: [bqetl_amo_stats](https://github.com/mozilla/bigquery-etl/blob/master/dags/bqetl_amo_stats.py)

##[amo_stats_installs_v3](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/amo_dev/amo_stats_installs_v3)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/amo_dev/amo_stats_installs_v3/metadata.yaml)

**Friendly name**: AMO Installs dev/stage

**Description**: Reduced daily installs table for dev and stage versions of the AMO service.


**Owners**: [jklukas@mozilla.com](mailto:jklukas@mozilla.com)

**Schedule**: daily

**DAG name**: [bqetl_amo_stats](https://github.com/mozilla/bigquery-etl/blob/master/dags/bqetl_amo_stats.py)

##[amo_stats_installs](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/amo_dev/amo_stats_installs)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/amo_dev/amo_stats_installs/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.amo_dev.amo_stats_installs`
AS
SELECT
  submission_date,
  hashed_addon_id,
  total_downloads,
  ARRAY(
    SELECT AS STRUCT
      IFNULL(key, 'Unknown') AS key,
      value
    FROM
      UNNEST(downloads_per_campaign)
  ) AS downloads_per_campaign,
  ARRAY(
    SELECT AS STRUCT
      IFNULL(key, 'Unknown') AS key,
      value
    FROM
      UNNEST(downloads_per_content)
  ) AS downloads_per_content,
  ARRAY(
    SELECT AS STRUCT
      IFNULL(key, 'Unknown') AS key,
      value
    FROM
      UNNEST(downloads_per_source)
  ) AS downloads_per_source,
  ARRAY(
    SELECT AS STRUCT
      IFNULL(key, 'Unknown') AS key,
      value
    FROM
      UNNEST(downloads_per_medium)
  ) AS downloads_per_medium,
FROM
  `moz-fx-data-shared-prod.amo_dev.amo_stats_installs_v3`
~~~~
