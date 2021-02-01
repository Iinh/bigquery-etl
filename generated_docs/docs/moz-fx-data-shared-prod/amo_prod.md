---
title: amo_prod
---

##[amo_stats_dau](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/amo_prod/amo_stats_dau)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/amo_prod/amo_stats_dau/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.amo_prod.amo_stats_dau`
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
  `moz-fx-data-shared-prod.amo_prod.amo_stats_dau_v2`
~~~~
##[fenix_addons_by_client_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/amo_prod/fenix_addons_by_client_v1)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/amo_prod/fenix_addons_by_client_v1/metadata.yaml)

**Friendly name**: Fenix addons by client

**Description**: Clients_daily-like table on top of the various Firefox for Android channels that records only the dimensions and addon info necessary to power the daily amo_stats_dau_v2 query.

**Owners**: [jklukas@mozilla.com](mailto:jklukas@mozilla.com)

**Schedule**: daily

**DAG name**: [bqetl_amo_stats](https://github.com/mozilla/bigquery-etl/blob/master/dags/bqetl_amo_stats.py)

##[amo_stats_dau_v2](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/amo_prod/amo_stats_dau_v2)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/amo_prod/amo_stats_dau_v2/metadata.yaml)

**Friendly name**: AMO Stats DAU

**Description**: Daily user statistics to power addons.mozilla.org stats pages. See bug 1572873.
Each row in this table represents a particular addon on a particular day and provides all the information needed to populate the various "Daily Users" plots for the AMO stats dashboard.

**Owners**: [jklukas@mozilla.com](mailto:jklukas@mozilla.com)

**Schedule**: daily

**DAG name**: [bqetl_amo_stats](https://github.com/mozilla/bigquery-etl/blob/master/dags/bqetl_amo_stats.py)

##[desktop_addons_by_client_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/amo_prod/desktop_addons_by_client_v1)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/amo_prod/desktop_addons_by_client_v1/metadata.yaml)

**Friendly name**: Desktop addons by client

**Description**: Clients_daily-like table that records only the dimensions and addon info necessary to power daily the amo_stats_dau_v2 query.

**Owners**: [jklukas@mozilla.com](mailto:jklukas@mozilla.com)

**Schedule**: daily

**DAG name**: [bqetl_amo_stats](https://github.com/mozilla/bigquery-etl/blob/master/dags/bqetl_amo_stats.py)

##[amo_stats_installs_v3](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/amo_prod/amo_stats_installs_v3)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/amo_prod/amo_stats_installs_v3/metadata.yaml)

**Friendly name**: AMO Stats DAU

**Description**: Daily install statistics to power addons.mozilla.org stats pages. See bug 1654330. Note that this table uses a hashed_addon_id defined as `TO_HEX(SHA256(addon_id))` because the underlying event pings have limitations on length of properties attached to events and addon_id values are sometimes too long. The AMO stats application looks up records in this table based on the hashed_addon_id.


**Owners**: [jklukas@mozilla.com](mailto:jklukas@mozilla.com)

**Schedule**: daily

**DAG name**: [bqetl_amo_stats](https://github.com/mozilla/bigquery-etl/blob/master/dags/bqetl_amo_stats.py)

##[amo_stats_installs](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/amo_prod/amo_stats_installs)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/amo_prod/amo_stats_installs/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.amo_prod.amo_stats_installs`
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
  `moz-fx-data-shared-prod.amo_prod.amo_stats_installs_v3`
~~~~
