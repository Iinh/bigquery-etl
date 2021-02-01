---
title: monitoring
---

##[deletion_request_volume](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/monitoring/deletion_request_volume)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/monitoring/deletion_request_volume/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.monitoring.deletion_request_volume`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.monitoring_derived.deletion_request_volume_v1`
~~~~
##[structured_distinct_docids](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/monitoring/structured_distinct_docids)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/monitoring/structured_distinct_docids/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.monitoring.structured_distinct_docids`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.monitoring_derived.structured_distinct_docids_v1`
~~~~
##[shredder_progress](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/monitoring/shredder_progress)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/monitoring/shredder_progress/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.monitoring.shredder_progress`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.monitoring_derived.shredder_progress_v1`
~~~~
##[structured_missing_columns](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/monitoring/structured_missing_columns)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/monitoring/structured_missing_columns/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.monitoring.structured_missing_columns`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.monitoring_derived.structured_missing_columns_v1`
~~~~
##[bigquery_etl_scheduled_query_usage](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/monitoring/bigquery_etl_scheduled_query_usage)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/monitoring/bigquery_etl_scheduled_query_usage/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.monitoring.bigquery_etl_scheduled_query_usage`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.monitoring_derived.bigquery_etl_scheduled_query_usage_v1`
~~~~
##[column_size](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/monitoring/column_size)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/monitoring/column_size/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.monitoring.column_size`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.monitoring_derived.column_size_v1`
~~~~
##[average_ping_sizes](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/monitoring/average_ping_sizes)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/monitoring/average_ping_sizes/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.monitoring.average_ping_sizes`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.monitoring_derived.average_ping_sizes_v1`
~~~~
##[telemetry_missing_columns](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/monitoring/telemetry_missing_columns)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/monitoring/telemetry_missing_columns/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.monitoring.telemetry_missing_columns`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.monitoring_derived.telemetry_missing_columns_v3`
~~~~
##[telemetry_distinct_docids](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/monitoring/telemetry_distinct_docids)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/monitoring/telemetry_distinct_docids/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.monitoring.telemetry_distinct_docids`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.monitoring_derived.telemetry_distinct_docids_v1`
~~~~
##[schema_error_counts](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/monitoring/schema_error_counts)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/monitoring/schema_error_counts/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.monitoring.schema_error_counts`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.monitoring_derived.schema_error_counts_v2`
~~~~
##[stable_table_sizes](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/monitoring/stable_table_sizes)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/monitoring/stable_table_sizes/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.monitoring.stable_table_sizes`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.monitoring_derived.stable_table_sizes_v1`
~~~~
##[structured_error_counts](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/monitoring/structured_error_counts)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/monitoring/structured_error_counts/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.monitoring.structured_error_counts`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.monitoring_derived.structured_error_counts_v1`
~~~~
##[bigquery_etl_scheduled_queries_cost](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/monitoring/bigquery_etl_scheduled_queries_cost)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/monitoring/bigquery_etl_scheduled_queries_cost/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.monitoring.bigquery_etl_scheduled_queries_cost`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.monitoring_derived.bigquery_etl_scheduled_queries_cost_v1`
~~~~
##[structured_detailed_error_counts](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/monitoring/structured_detailed_error_counts)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/monitoring/structured_detailed_error_counts/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.monitoring.structured_detailed_error_counts`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.monitoring_derived.structured_detailed_error_counts_v1`
~~~~
##[document_sample_nonprod](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/monitoring/document_sample_nonprod)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/monitoring/document_sample_nonprod/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.monitoring.document_sample_nonprod`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.monitoring_derived.document_sample_nonprod_v1`
~~~~
