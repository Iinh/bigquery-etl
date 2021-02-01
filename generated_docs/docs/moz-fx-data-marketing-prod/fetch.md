---
title: fetch
---

##[latest_metric](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-marketing-prod/fetch/latest_metric)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-marketing-prod/fetch/latest_metric/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-marketing-prod.fetch.latest_metric`
AS
SELECT
  int64_field_0 AS fetch_id,
  * EXCEPT (int64_field_0),
FROM
  `moz-fx-data-marketing-prod.fetch.metric_*`
WHERE
  _TABLE_SUFFIX = (SELECT MAX(_TABLE_SUFFIX) FROM `moz-fx-data-marketing-prod.fetch.metric_*`)
~~~~
##[latest_spending](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-marketing-prod/fetch/latest_spending)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-marketing-prod/fetch/latest_spending/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-marketing-prod.fetch.latest_spending`
AS
SELECT
  *,
FROM
  `moz-fx-data-marketing-prod.fetch.latest_trafficking`
LEFT JOIN
  `moz-fx-data-marketing-prod.fetch.latest_metric`
USING
  (fetch_id, AdName)
~~~~
##[fetch_deduped](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-marketing-prod/fetch/fetch_deduped)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-marketing-prod/fetch/fetch_deduped/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-marketing-prod.fetch.fetch_deduped`
AS
WITH metrics_ingestion_date_per_ad AS (
  SELECT
    _table_suffix AS ingestionDate,
    MAX(_table_suffix) OVER (PARTITION BY date, Adname) AS IngestionDateMax,
    *,
  FROM
    `moz-fx-data-marketing-prod.fetch.metric_*`
),
latest_ingested_metrics AS (
  SELECT
    *,
  FROM
    metrics_ingestion_date_per_ad
  WHERE
    ingestionDate = IngestionDateMax
)
SELECT
  Created,
  AdName AS AdNameTrafficking,
  TrackingLink,
  Product,
  Campaign,
  Vendor,
  Country,
  OperatingSystem,
  Device,
  Channel,
  CreativeType,
  Targeting,
  Creative,
  CreativeSize,
  CreativeConcept,
  CreativeLanguage,
  TrafficType,
  Tracking,
  Goal,
  MediaType,
  Placement,
  SocialString,
  metric.*,
FROM
  `moz-fx-data-marketing-prod.fetch.latest_trafficking` AS trafficking
LEFT JOIN
  -- Join metric / spend data to campaign information data
  latest_ingested_metrics AS metric
USING
  (AdName)
~~~~
##[spend_alignment_by_month_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-marketing-prod/fetch/spend_alignment_by_month_v1)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-marketing-prod/fetch/spend_alignment_by_month_v1/metadata.yaml)

**Description**: Compare spend data by month between summary tables and detailed tables


**Friendly name**: Monthly Spend Alignment

**Schedule**: weekly

**Owners**: [bewu@mozilla.com](mailto:bewu@mozilla.com)

**DAG name**: [bqetl_marketing_fetch](https://github.com/mozilla/bigquery-etl/blob/master/dags/bqetl_marketing_fetch.py)

##[latest_trafficking](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-marketing-prod/fetch/latest_trafficking)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-marketing-prod/fetch/latest_trafficking/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-marketing-prod.fetch.latest_trafficking`
AS
SELECT
  int64_field_0 AS fetch_id,
  * EXCEPT (int64_field_0),
FROM
  `moz-fx-data-marketing-prod.fetch.trafficking_*`
WHERE
  _TABLE_SUFFIX = (SELECT MAX(_TABLE_SUFFIX) FROM `moz-fx-data-marketing-prod.fetch.trafficking_*`)
~~~~
##[spend_alignment_by_campaign_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-marketing-prod/fetch/spend_alignment_by_campaign_v1)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-marketing-prod/fetch/spend_alignment_by_campaign_v1/metadata.yaml)

**Description**: Compare spend data by campaign between summary tables and detailed tables


**Friendly name**: Campaign Spend Alignment

**Schedule**: weekly

**Owners**: [bewu@mozilla.com](mailto:bewu@mozilla.com)

**DAG name**: [bqetl_marketing_fetch](https://github.com/mozilla/bigquery-etl/blob/master/dags/bqetl_marketing_fetch.py)

