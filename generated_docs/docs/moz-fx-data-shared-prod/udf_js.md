---
title: udf_js
---

##[jackknife_sum_ci](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf_js/jackknife_sum_ci)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf_js/jackknife_sum_ci/metadata.yaml)

**Description**: Calculates a confidence interval using a jackknife resampling technique for the sum of an array of counts for various buckets; see https://en.wikipedia.org/wiki/Jackknife_resampling  Users must specify the number of expected buckets as the first parameter to guard against the case where empty buckets lead to an array with missing elements.  Usage generally involves first calculating an aggregate count per bucket, then aggregating over buckets, passing ARRAY_AGG(metric) to this function.  Example:  WITH bucketed AS (   SELECT     submission_date,     SUM(dau) AS dau_sum   FROM     mytable GROUP BY     submission_date,     bucket_id ) SELECT   submission_date, udf_js.jackknife_sum_ci(ARRAY_AGG(dau_sum)).* FROM   bucketed GROUP BY   submission_date

**Friendly name**: Jackknife Sum Ci

##[json_extract_keyed_histogram](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf_js/json_extract_keyed_histogram)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf_js/json_extract_keyed_histogram/metadata.yaml)

**Description**: Returns an array of parsed structs from a JSON string representing a keyed histogram.  This is likely only useful for histograms that weren't properly parsed to fields, so ended up embedded in an additional_properties JSON blob. Normally, keyed histograms will be modeled as a key/value struct where the values are JSON representations of single histograms. There is no pure SQL equivalent to this function, since BigQuery does not provide any functions for listing or iterating over keysn in a JSON map.

**Friendly name**: Json Extract Keyed Histogram

##[main_summary_addon_scalars](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf_js/main_summary_addon_scalars)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf_js/main_summary_addon_scalars/metadata.yaml)

**Description**: Parse scalars from payload.processes.dynamic into map columns for each value type. https://github.com/mozilla/telemetry-batch-view/blob/ea0733c00df191501b39d2c4e2ece3fe703a0ef3/src/main/scala/com/mozilla/telemetry/utils/MainPing.scala#L385-L399

**Friendly name**: Main Summary Addon Scalars

##[jackknife_ratio_ci](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf_js/jackknife_ratio_ci)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf_js/jackknife_ratio_ci/metadata.yaml)

**Description**: Calculates a confidence interval using a jackknife resampling technique for the weighted mean of an array of ratios for various buckets; see https://en.wikipedia.org/wiki/Jackknife_resampling  Users must specify the number of expected buckets as the first parameter to guard against the case where empty buckets lead to an array with missing elements. Usage generally involves first calculating an aggregate per bucket, then aggregating over buckets, passing ARRAY_AGG(metric) to this function. Example:  WITH bucketed AS (   SELECT     submission_date, SUM(active_days_in_week) AS active_days_in_week,     SUM(wau) AS wau FROM     mytable   GROUP BY     submission_date,     bucket_id ) SELECT   submission_date,   udf_js.jackknife_ratio_ci(20, ARRAY_AGG(STRUCT(CAST(active_days_in_week AS float64), CAST(wau as FLOAT64)))) AS intensity FROM   bucketed GROUP BY submission_date

**Friendly name**: Jackknife Ratio Ci

##[json_extract_events](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf_js/json_extract_events)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf_js/json_extract_events/metadata.yaml)

**Description**: 

**Friendly name**: Json Extract Events

##[json_extract_missing_cols](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf_js/json_extract_missing_cols)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf_js/json_extract_missing_cols/metadata.yaml)

**Description**: Extract missing columns from additional properties.  More generally, get a list of nodes from a JSON blob. Array elements are indicated as [...].  param input: The JSON blob to explode param indicates_node: An array of strings. If a key's value is an object, and contains one of these values, that key is returned as a node. param known_nodes: An array of strings. If a key is in this array, it is returned as a node.  Notes: - Use indicates_node for things like histograms. For example ['histogram_type'] will ensure that each histogram will be returned as a missing node, rather than the subvalues within the histogram   (e.g. values, sum, etc.) - Use known_nodes if you're aware of a missing section, like ['simpleMeasurements']  See here for an example usage https://sql.telemetry.mozilla.org/queries/64460/source

**Friendly name**: Json Extract Missing Cols

##[crc32](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf_js/crc32)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf_js/crc32/metadata.yaml)

**Description**: Calculate the CRC-32 hash of an input string.  The implementation here could be optimized. In particular, it calculates a lookup table on every invocation which could be cached and reused. In practice, though, this implementation appears to be fast enough that further optimization is not yet warranted.  Based on https://stackoverflow.com/a/18639999/1260237 See https://en.wikipedia.org/wiki/Cyclic_redundancy_check

**Friendly name**: CRC-32

##[jackknife_mean_ci](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf_js/jackknife_mean_ci)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf_js/jackknife_mean_ci/metadata.yaml)

**Description**: Calculates a confidence interval using a jackknife resampling technique for the mean of an array of values for various buckets; see https://en.wikipedia.org/wiki/Jackknife_resampling  Users must specify the number of expected buckets as the first parameter to guard against the case where empty buckets lead to an array with missing elements.  Usage generally involves first calculating an aggregate per bucket, then aggregating over buckets, passing ARRAY_AGG(metric) to this function.

**Friendly name**: Jackknife Mean Ci

##[main_summary_disabled_addons](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf_js/main_summary_disabled_addons)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf_js/main_summary_disabled_addons/metadata.yaml)

**Description**: Report the ids of the addons which are in the addonDetails but not in the activeAddons.  They are the disabled addons (possibly because they are legacy). We need this as addonDetails may contain both disabled and active addons. https://github.com/mozilla/telemetry-batch-view/blob/ea0733c00df191501b39d2c4e2ece3fe703a0ef3/src/main/scala/com/mozilla/telemetry/views/MainSummaryView.scala#L451-L464

**Friendly name**: Main Summary Disabled Addons

##[json_extract_histogram](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf_js/json_extract_histogram)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf_js/json_extract_histogram/metadata.yaml)

**Description**: Returns a parsed struct from a JSON string representing a histogram.  This implementation uses JavaScript and is provided for performance comparison; see udf/udf_json_extract_histogram for a pure SQL implementation that will likely be more usable in practice.

**Friendly name**: Json Extract Histogram

##[main_summary_active_addons](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf_js/main_summary_active_addons)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf_js/main_summary_active_addons/metadata.yaml)

**Description**: Add fields from additional_attributes to active_addons in main_v4.  Return an array instead of a "map" for backwards compatibility.  The INT64 columns from BigQuery may be passed as strings, so parseInt before returning them if they will be coerced to BOOL.  The fields from additional_attributes due to union types: integer or boolean for foreignInstall and userDisabled; string or number for version. https://github.com/mozilla/telemetry-batch-view/blob/ea0733c00df191501b39d2c4e2ece3fe703a0ef3/src/main/scala/com/mozilla/telemetry/views/MainSummaryView.scala#L422-L449

**Friendly name**: Main Summary Active Addons

##[sample_id](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf_js/sample_id)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf_js/sample_id/metadata.yaml)

**Description**: Stably hash a client_id to an integer between 0 and 99. This function is technically defined in SQL, but it calls a JS UDF implementation of a CRC-32 hash, so we defined it here to make it clear that its performance may be limited by BigQuery's JavaScript UDF environment.

**Friendly name**: Sample Id

##[gunzip](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf_js/gunzip)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf_js/gunzip/metadata.yaml)

**Description**: Unzips a GZIP string.  This implementation relies on the zlib.js library (https://github.com/imaya/zlib.js) and the atob function for decoding base64.

**Friendly name**: Gunzip

