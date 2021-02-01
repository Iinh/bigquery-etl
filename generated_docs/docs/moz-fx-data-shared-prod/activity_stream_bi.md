---
title: activity_stream_bi
---

##[impression_stats_flat_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/activity_stream_bi/impression_stats_flat_v1)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/activity_stream_bi/impression_stats_flat_v1/metadata.yaml)

**Friendly name**: Impression Stats Flat

**Description**: Unnested representation of tile impression statistics

**Owners**: [jklukas@mozilla.com](mailto:jklukas@mozilla.com)

**Schedule**: daily

**DAG name**: [bqetl_activity_stream](https://github.com/mozilla/bigquery-etl/blob/master/dags/bqetl_activity_stream.py)

##[impression_stats_by_experiment_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/activity_stream_bi/impression_stats_by_experiment_v1)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/activity_stream_bi/impression_stats_by_experiment_v1/metadata.yaml)

**Friendly name**: Impression Stats By Experiment

**Description**: Representation of tile impression statistics, clustered by experiment_id to allow efficient analysis of individual experiments

**Owners**: [jklukas@mozilla.com](mailto:jklukas@mozilla.com)

**Schedule**: daily

**DAG name**: [bqetl_activity_stream](https://github.com/mozilla/bigquery-etl/blob/master/dags/bqetl_activity_stream.py)

