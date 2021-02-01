---
title: udf
---

##[days_since_created_profile_as_28_bits](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/days_since_created_profile_as_28_bits)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/days_since_created_profile_as_28_bits/metadata.yaml)

**Description**: Takes in a difference between submission date and profile creation date and returns a bit pattern representing the profile creation date IFF the profile date is the same as the submission date or no more than 6 days earlier. Analysis has shown that client-reported profile creation dates are much less reliable outside of this range and cannot be used as reliable indicators of new profile creation.

**Friendly name**: Days Since Created Profile As 28 Bits

##[active_values_from_days_seen_map](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/active_values_from_days_seen_map)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/active_values_from_days_seen_map/metadata.yaml)

**Description**: Given a map of representing activity for STRING `key`s, this function returns an array of which `key`s were active for the time period in question. start_offset should be at most 0. n_bits should be at most the remaining bits.

**Friendly name**: Active Values From Days Seen Map

##[parquet_array_sum](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/parquet_array_sum)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/parquet_array_sum/metadata.yaml)

**Description**: Sum an array from a parquet-derived field. These are lists of an `element` that contain the field value.

**Friendly name**: Parquet Array Sum

##[coalesce_adjacent_days_28_bits](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/coalesce_adjacent_days_28_bits)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/coalesce_adjacent_days_28_bits/metadata.yaml)

**Description**: We generally want to believe only the first reasonable profile creation date that we receive from a client. Given bits representing usage from the previous day and the current day, this function shifts the first argument by one day and returns either that value if non-zero and non-null, the current day value if non-zero and non-null, or else 0.

**Friendly name**: Coalesce Adjacent Days 28 Bits

##[json_mode_last](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/json_mode_last)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/json_mode_last/metadata.yaml)

**Description**: 

**Friendly name**: Json Mode Last

##[bits_to_days_since_seen](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bits_to_days_since_seen)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bits_to_days_since_seen/metadata.yaml)

**Description**: Given a BYTES, return the number of days since the client was last seen.  If no bits are set, returns NULL, indicating we don't know. Otherwise the results are 0-indexed, meaning \x01 will return 0.  Tests showed this being 5-10x faster than the simpler alternative: CREATE OR REPLACE FUNCTION   udf.bits_to_days_since_seen(b BYTES) AS ((     SELECT MIN(n)     FROM UNNEST(GENERATE_ARRAY(0, 364)) AS n     WHERE BIT_COUNT(SUBSTR(b >> n, -1) & b'\x01') > 0)); See also: bits_to_days_since_first_seen.sql

**Friendly name**: Bits To Days Since Seen

##[bits28_days_since_seen](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bits28_days_since_seen)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bits28_days_since_seen/metadata.yaml)

**Description**: 

**Friendly name**: Bits28 Days Since Seen

##[histogram_to_mean](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/histogram_to_mean)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/histogram_to_mean/metadata.yaml)

**Description**: 

**Friendly name**: Histogram To Mean

##[glean_timespan_nanos](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/glean_timespan_nanos)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/glean_timespan_nanos/metadata.yaml)

**Description**: 

**Friendly name**: Glean Timespan Nanos

##[null_if_empty_list](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/null_if_empty_list)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/null_if_empty_list/metadata.yaml)

**Description**: Return NULL if list is empty, otherwise return list. This cannot be done with NULLIF because NULLIF does not support arrays.

**Friendly name**: Null If Empty List

##[country_code_to_flag](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/country_code_to_flag)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/country_code_to_flag/metadata.yaml)

**Description**: For a given two-letter ISO 3166-1 alpha-2 country code, returns a string consisting of two Unicode regional indicator symbols, which is rendered in supporting fonts (such as in the BigQuery console or STMO) as flag emoji.  This is just for fun. See:  - https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2 - https://en.wikipedia.org/wiki/Regional_Indicator_Symbol

**Friendly name**: Country Code To Flag

##[add_searches_by_index](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/add_searches_by_index)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/add_searches_by_index/metadata.yaml)

**Description**: Return sums of each search type grouped by the index. Results are ordered by index.

**Friendly name**: Add Searches By Index

##[array_of_12_zeroes](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/array_of_12_zeroes)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/array_of_12_zeroes/metadata.yaml)

**Description**: An array of 12 zeroes

**Friendly name**: Array Of 12 Zeroes

##[new_monthly_engine_searches_struct](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/new_monthly_engine_searches_struct)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/new_monthly_engine_searches_struct/metadata.yaml)

**Description**: This struct represents the past year's worth of searches. Each month has its own entry, hence 12.

**Friendly name**: New Monthly Engine Searches Struct

##[normalize_metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/normalize_metadata)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/normalize_metadata/metadata.yaml)

**Description**: 

**Friendly name**: Normalize Metadata

##[pos_of_leading_set_bit](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/pos_of_leading_set_bit)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/pos_of_leading_set_bit/metadata.yaml)

**Description**: Returns the 0-based index of the first set bit. No set bits returns NULL.

**Friendly name**: Pos Of Leading Set Bit

##[shift_28_bits_one_day](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/shift_28_bits_one_day)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/shift_28_bits_one_day/metadata.yaml)

**Description**: Shift input bits one day left and drop any bits beyond 28 days.

**Friendly name**: Shift 28 Bits One Day

##[bits28_to_string](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bits28_to_string)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bits28_to_string/metadata.yaml)

**Description**: 

**Friendly name**: Bits28 To String

##[kv_array_append_to_json_string](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/kv_array_append_to_json_string)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/kv_array_append_to_json_string/metadata.yaml)

**Description**: Returns a JSON string which has the `pair` appended to the provided `input` JSON string. NULL is also valid for `input`. Examples:    udf.kv_array_append_to_json_string('{"foo":"bar"}', [STRUCT("baz" AS key, "boo" AS value)])    '{"foo":"bar","baz":"boo"}' udf.kv_array_append_to_json_string('{}', [STRUCT("baz" AS key, "boo" AS value)])    '{"baz": "boo"}'

**Friendly name**: Kv Array Append To Json String

##[combine_experiment_days](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/combine_experiment_days)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/combine_experiment_days/metadata.yaml)

**Description**: The "clients_last_seen" class of tables represent various types of client activity within a 28-day window as bit patterns.  This function takes in two arrays of structs where each entry gives the bit pattern for days in which we saw a ping for a given user in a given experiment. We combine the bit patterns for the previous day and the current day, returning a single array of experiment structs.

**Friendly name**: Combine Experiment Days

##[normalize_glean_ping_info](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/normalize_glean_ping_info)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/normalize_glean_ping_info/metadata.yaml)

**Description**: 

**Friendly name**: Normalize Glean Ping Info

##[shift_one_day](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/shift_one_day)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/shift_one_day/metadata.yaml)

**Description**: Returns the bitfield shifted by one day, 0 for NULL

**Friendly name**: Shift One Day

##[bits_to_days_seen](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bits_to_days_seen)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bits_to_days_seen/metadata.yaml)

**Description**: Given a BYTE, get the number of days the user was seen. NULL input returns NULL output.

**Friendly name**: Bits To Days Seen

##[bitcount_lowest_7](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bitcount_lowest_7)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bitcount_lowest_7/metadata.yaml)

**Description**: This function counts the 1s in lowest 7 bits of an INT64

**Friendly name**: Bitcount Lowest 7

##[bits28_range](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bits28_range)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bits28_range/metadata.yaml)

**Description**: 

**Friendly name**: Bits28 Range

##[histogram_to_threshold_count](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/histogram_to_threshold_count)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/histogram_to_threshold_count/metadata.yaml)

**Description**: 

**Friendly name**: Histogram To Threshold Count

##[get_key_with_null](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/get_key_with_null)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/get_key_with_null/metadata.yaml)

**Description**: 

**Friendly name**: Get Key With Null

##[normalize_os](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/normalize_os)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/normalize_os/metadata.yaml)

**Description**: 

**Friendly name**: Normalize Os

##[active_n_weeks_ago](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/active_n_weeks_ago)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/active_n_weeks_ago/metadata.yaml)

**Description**: 

**Friendly name**: Active N Weeks Ago

##[main_summary_scalars](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/main_summary_scalars)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/main_summary_scalars/metadata.yaml)

**Description**: 

**Friendly name**: Main Summary Scalars

##[histogram_max_key_with_nonzero_value](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/histogram_max_key_with_nonzero_value)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/histogram_max_key_with_nonzero_value/metadata.yaml)

**Description**: Find the largest numeric bucket that contains a value greater than zero. https://github.com/mozilla/telemetry-batch-view/blob/ea0733c/src/main/scala/com/mozilla/telemetry/utils/MainPing.scala#L253-L266

**Friendly name**: Histogram Max Key With Nonzero Value

##[aggregate_map_first](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/aggregate_map_first)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/aggregate_map_first/metadata.yaml)

**Description**: Returns an aggregated map with all the keys and the first corresponding value from the given maps

**Friendly name**: Aggregate Map First

##[bits28_to_dates](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bits28_to_dates)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bits28_to_dates/metadata.yaml)

**Description**: 

**Friendly name**: Bits28 To Dates

##[vector_add](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/vector_add)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/vector_add/metadata.yaml)

**Description**: This function adds two vectors. The two vectors can have different length. If one vector is null, the other vector will be returned directly.

**Friendly name**: Vector Add

##[keyed_histogram_get_sum](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/keyed_histogram_get_sum)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/keyed_histogram_get_sum/metadata.yaml)

**Description**: Take a keyed histogram of type STRUCT<key STRING, value STRING>, extract the histogram of the given key, and return the sum value

**Friendly name**: Keyed Histogram Get Sum

##[round_timestamp_to_minute](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/round_timestamp_to_minute)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/round_timestamp_to_minute/metadata.yaml)

**Description**: Floor a timestamp object to the given minute interval.

**Friendly name**: Round Timestamp To Minute

##[add_monthly_searches](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/add_monthly_searches)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/add_monthly_searches/metadata.yaml)

**Description**: Adds together two engine searches structs. Each engine searches struct has a MAP[engine -> search_counts_struct]. We want to add add together the prev and curr's values for a certain engine.  This allows us to be flexible with the number of engines we're using.

**Friendly name**: Add Monthly Searches

##[map_sum](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/map_sum)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/map_sum/metadata.yaml)

**Description**: 

**Friendly name**: Map Sum

##[int_to_365_bits](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/int_to_365_bits)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/int_to_365_bits/metadata.yaml)

**Description**: 

**Friendly name**: Int To 365 Bits

##[decode_int64](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/decode_int64)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/decode_int64/metadata.yaml)

**Description**: 

**Friendly name**: Decode Int64

##[smoot_usage_from_28_bits](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/smoot_usage_from_28_bits)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/smoot_usage_from_28_bits/metadata.yaml)

**Description**: Calculates a variety of metrics based on bit patterns of daily usage for the smoot_usage_* tables.

**Friendly name**: Smoot Usage From 28 Bits

##[extract_count_histogram_value](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/extract_count_histogram_value)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/extract_count_histogram_value/metadata.yaml)

**Description**: 

**Friendly name**: Extract Count Histogram Value

##[array_slice](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/array_slice)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/array_slice/metadata.yaml)

**Description**: 

**Friendly name**: Array Slice

##[dedupe_array](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/dedupe_array)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/dedupe_array/metadata.yaml)

**Description**: Return an array containing only distinct values of the given array

**Friendly name**: Dedupe Array

##[histogram_merge](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/histogram_merge)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/histogram_merge/metadata.yaml)

**Description**: 

**Friendly name**: Histogram Merge

##[mode_last_retain_nulls](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/mode_last_retain_nulls)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/mode_last_retain_nulls/metadata.yaml)

**Description**: 

**Friendly name**: Mode Last Retain Nulls

##[bits_to_active_n_weeks_ago](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bits_to_active_n_weeks_ago)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bits_to_active_n_weeks_ago/metadata.yaml)

**Description**: Given a BYTE and an INT64, return whether the user was active that many weeks ago.  NULL input returns NULL output.

**Friendly name**: Bits To Active N Weeks Ago

##[event_code_points_to_string](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/event_code_points_to_string)
##[days_seen_bytes_to_rfm](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/days_seen_bytes_to_rfm)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/days_seen_bytes_to_rfm/metadata.yaml)

**Description**: Return the frequency, recency, and T from a BYTE array, as defined in https://lifetimes.readthedocs.io/en/latest/Quickstart.html#the-shape-of-your-data RFM refers to Recency, Frequency, and Monetary value.

**Friendly name**: Days Seen Bytes To Rfm

##[bits28_active_in_range](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bits28_active_in_range)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bits28_active_in_range/metadata.yaml)

**Description**: 

**Friendly name**: Bits28 Active In Range

##[mode_last](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/mode_last)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/mode_last/metadata.yaml)

**Description**: 

**Friendly name**: Mode Last

##[geo_struct](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/geo_struct)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/geo_struct/metadata.yaml)

**Description**: Convert geoip lookup fields to a struct, replacing '??' with NULL.  Returns NULL if if required field country would be NULL. Replaces '??' with NULL because '??' is a placeholder that may be used if there was an issue during geoip lookup in hindsight.

**Friendly name**: Geo Struct

##[aggregate_search_map](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/aggregate_search_map)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/aggregate_search_map/metadata.yaml)

**Description**: Aggregates the total counts of the given search counters

**Friendly name**: Aggregate Search Map

##[quantile_search_metric_contribution](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/quantile_search_metric_contribution)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/quantile_search_metric_contribution/metadata.yaml)

**Description**: This function returns how much of one metric is contributed by the quantile of another metric. Quantile variable should add an offset to get the requried percentile value. Example: udf.quantile_search_metric_contribution(sap, search_with_ads, sap_percentiles[OFFSET(9)]) It returns search_with_ads if sap value in top 10% volumn else null.

**Friendly name**: Quantile Search Metric Contribution

##[array_11_zeroes_then](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/array_11_zeroes_then)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/array_11_zeroes_then/metadata.yaml)

**Description**: An array of 11 zeroes, followed by a supplied value

**Friendly name**: Array 11 Zeroes Then

##[aggregate_active_addons](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/aggregate_active_addons)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/aggregate_active_addons/metadata.yaml)

**Description**: This function selects most frequently occuring value for each addon_id, using the latest value in the input among ties. The type for active_addons is ARRAY<STRUCT<addon_id STRING, ...>>, i.e. the output of `SELECT ARRAY_CONCAT_AGG(active_addons) FROM telemetry.main_summary_v4`, and is left unspecified to allow changes to the fields of the STRUCT.

**Friendly name**: Aggregate Active Addons

##[extract_document_type](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/extract_document_type)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/extract_document_type/metadata.yaml)

**Description**: Extract the document type from a table name e.g. _TABLE_SUFFIX.

**Friendly name**: Extract Document Type

##[pos_of_trailing_set_bit](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/pos_of_trailing_set_bit)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/pos_of_trailing_set_bit/metadata.yaml)

**Description**: Identical to bits28_days_since_seen.  Returns a 0-based index of the rightmost set bit in the passed bit pattern or null if no bits are set (bits = 0).  To determine this position, we take a bitwise AND of the bit pattern and its complement, then we determine the position of the bit via base-2 logarithm; see https://stackoverflow.com/a/42747608/1260237

**Friendly name**: Pos Of Trailing Set Bit

##[bool_to_365_bits](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bool_to_365_bits)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bool_to_365_bits/metadata.yaml)

**Description**: Convert a boolean to 365 bit byte array

**Friendly name**: Bool To 365 Bits

##[bits28_retention](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bits28_retention)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bits28_retention/metadata.yaml)

**Description**: 

**Friendly name**: Bits28 Retention

##[combine_days_seen_maps](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/combine_days_seen_maps)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/combine_days_seen_maps/metadata.yaml)

**Description**: The "clients_last_seen" class of tables represent various types of client activity within a 28-day window as bit patterns. This function takes in two arrays of structs (aka maps) where each entry gives the bit pattern for days in which we saw a ping for a given user in a given key. We combine the bit patterns for the previous day and the current day, returning a single map. See `udf.combine_experiment_days` for a more specific example of this approach.

**Friendly name**: Combine Days Seen Maps

##[boolean_histogram_to_boolean](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/boolean_histogram_to_boolean)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/boolean_histogram_to_boolean/metadata.yaml)

**Description**: Given histogram h, return TRUE if it has a value in the "true" bucket, or FALSE if it has a value in the "false" bucket, or NULL otherwise. https://github.com/mozilla/telemetry-batch-view/blob/ea0733c/src/main/scala/com/mozilla/telemetry/utils/MainPing.scala#L309-L317

**Friendly name**: Boolean Histogram To Boolean

##[zeroed_array](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/zeroed_array)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/zeroed_array/metadata.yaml)

**Description**: Generates an array if all zeroes, of arbitrary length

**Friendly name**: Zeroed Array

##[extract_schema_validation_path](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/extract_schema_validation_path)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/extract_schema_validation_path/metadata.yaml)

**Description**: Return a path derived from an error message in `payload_bytes_error`

**Friendly name**: Extract Schema Validation Path

##[bitmask_lowest_7](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bitmask_lowest_7)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bitmask_lowest_7/metadata.yaml)

**Description**: 

**Friendly name**: Bitmask Lowest 7

##[pack_event_properties](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/pack_event_properties)
##[bits_to_days_since_first_seen](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bits_to_days_since_first_seen)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bits_to_days_since_first_seen/metadata.yaml)

**Description**: Given a BYTES, return the number of days since the client was first seen.  If no bits are set, returns NULL, indicating we don't know. Otherwise the result is 0-indexed, meaning that for \x01, it will return 0.  Results showed this being between 5-10x faster than the simpler alternative: CREATE OR REPLACE FUNCTION udf.bits_to_days_since_first_seen(b BYTES) AS ((     SELECT MAX(n)     FROM UNNEST(GENERATE_ARRAY( 0, 8 * BYTE_LENGTH(b))) AS n     WHERE BIT_COUNT(SUBSTR(b >> n, -1) & b'\x01') > 0)); See also: bits_to_days_since_seen.sql

**Friendly name**: Bits To Days Since First Seen

##[coalesce_adjacent_days_365_bits](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/coalesce_adjacent_days_365_bits)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/coalesce_adjacent_days_365_bits/metadata.yaml)

**Description**: Coalesce previous data's PCD with the new data's PCD. We generally want to believe only the first reasonable profile creation date that we receive from a client. Given bytes representing usage from the previous day and the current day, this function shifts the first argument by one day and returns either that value if non-zero and non-null, the current day value if non-zero and non-null, or else 0.

**Friendly name**: Coalesce Adjacent Days 365 Bits

##[combine_adjacent_days_28_bits](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/combine_adjacent_days_28_bits)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/combine_adjacent_days_28_bits/metadata.yaml)

**Description**: Combines two bit patterns. The first pattern represents activity over a 28-day period ending "yesterday". The second pattern represents activity as observed today (usually just 0 or 1). We shift the bits in the first pattern by one to set the new baseline as "today", then perform a bitwise OR of the two patterns.

**Friendly name**: Combine Adjacent Days 28 Bits

##[extract_document_version](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/extract_document_version)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/extract_document_version/metadata.yaml)

**Description**: Extract the document version from a table name e.g. _TABLE_SUFFIX.

**Friendly name**: Extract Document Version

##[normalize_fenix_metrics](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/normalize_fenix_metrics)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/normalize_fenix_metrics/metadata.yaml)

**Description**: Accepts a glean metrics struct as input and returns a modified struct that nulls out histograms for older versions of the Glean SDK that reported pathological binning; see https://bugzilla.mozilla.org/show_bug.cgi?id=1592930

**Friendly name**: Normalize Fenix Metrics

##[bitmask_365](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bitmask_365)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bitmask_365/metadata.yaml)

**Description**: A bitmask for 365 bits

**Friendly name**: Bitmask 365

##[array_drop_first_and_append](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/array_drop_first_and_append)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/array_drop_first_and_append/metadata.yaml)

**Description**: Drop the first element of an array, and append the given element.  Result is an array with the same length as the input.

**Friendly name**: Array Drop First And Append

##[gzip_length_footer](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/gzip_length_footer)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/gzip_length_footer/metadata.yaml)

**Description**: Given a gzip compressed byte string, extract the uncompressed size from the footer.  WARNING: THIS FUNCTION IS NOT RELIABLE FOR ARBITRARY GZIP STREAMS. It should, however, be safe to use for checking the decompressed size of payload in payload_bytes_decoded (and NOT payload_bytes_raw) because that payload is produced by the decoder and limited to conditions where the footer is accurate. From https://stackoverflow.com/a/9213826 First, the only information about the uncompressed length is four bytes at the end of the gzip file (stored in little-endian order). By necessity, that is the length modulo 232. So if the uncompressed length is 4 GB or more, you won't know what the length is. You can only be certain that the uncompressed length is less than 4 GB if the compressed length is less than something like 232 / 1032 + 18, or around 4 MB. (1032 is the maximum compression factor of deflate.) Second, and this is worse, a gzip file may actually be a concatenation of multiple gzip streams. Other than decoding, there is no way to find where each gzip stream ends in order to look at the four-byte uncompressed length of that piece. (Which may be wrong anyway due to the first reason.) Third, gzip files will sometimes have junk after the end of the gzip stream (usually zeros). Then the last four bytes are not the length.

**Friendly name**: Gzip Length Footer

##[json_extract_histogram](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/json_extract_histogram)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/json_extract_histogram/metadata.yaml)

**Description**: 

**Friendly name**: Json Extract Histogram

##[zero_as_365_bits](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/zero_as_365_bits)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/zero_as_365_bits/metadata.yaml)

**Description**: Zero represented as a 365-bit byte array

**Friendly name**: Zero As 365 Bits

##[parse_iso8601_date](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/parse_iso8601_date)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/parse_iso8601_date/metadata.yaml)

**Description**: Take a ISO 8601 date or date and time string and return a DATE.  Return null if parse fails.  Possible formats: 2019-11-04, 2019-11-04T21:15:00+00:00, 2019-11-04T21:15:00Z, 20191104T211500Z

**Friendly name**: Parse Iso8601 Date

##[map_bing_revenue_country_to_country_code](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/map_bing_revenue_country_to_country_code)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/map_bing_revenue_country_to_country_code/metadata.yaml)

**Description**: For use by LTV revenue join only. Maps the Bing country to a country code. Only keeps the country codes we want to aggregate on.

**Friendly name**: Map Bing Revenue Country To Country Code

##[int_to_hex_string](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/int_to_hex_string)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/int_to_hex_string/metadata.yaml)

**Description**: 

**Friendly name**: Int To Hex String

##[safe_sample_id](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/safe_sample_id)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/safe_sample_id/metadata.yaml)

**Description**: Stably hash a client_id to an integer between 0 and 99, or NULL if client_id isn't 36 bytes

**Friendly name**: Safe Sample Id

##[get_key](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/get_key)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/get_key/metadata.yaml)

**Description**: 

**Friendly name**: Get Key

##[hmac_sha256](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/hmac_sha256)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/hmac_sha256/metadata.yaml)

**Description**: Given a key and message, return the HMAC-SHA256 hash. This algorithm can be found in Wikipedia: https://en.wikipedia.org/wiki/HMAC#Implementation  This implentation is validated against the NIST test vectors. See test/validation/hmac_sha256.py for more information.

**Friendly name**: Hmac Sha256

##[bits28_from_string](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bits28_from_string)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bits28_from_string/metadata.yaml)

**Description**: 

**Friendly name**: Bits28 From String

##[merge_scalar_user_data](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/merge_scalar_user_data)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/merge_scalar_user_data/metadata.yaml)

**Description**: Given an array of scalar metric data that might have duplicate values for a metric, merge them into one value.

**Friendly name**: Merge Scalar User Data

##[bitmask_range](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bitmask_range)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bitmask_range/metadata.yaml)

**Description**: Returns a bitmask that can be used to return a subset of an integer representing a bit array. The start_ordinal argument is an integer specifying the starting position of the slice, with start_ordinal = 1 indicating the first bit. The length argument is the number of bits to include in the mask.  The arguments were chosen to match the semantics of the SUBSTR function; see https://cloud.google.com/bigquery/docs/reference/standard-sql/functions-and-operators#substr

**Friendly name**: Bitmask Range

##[map_mode_last](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/map_mode_last)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/map_mode_last/metadata.yaml)

**Description**: 

**Friendly name**: Map Mode Last

##[ga_is_mozilla_browser](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/ga_is_mozilla_browser)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/ga_is_mozilla_browser/metadata.yaml)

**Description**: Determine if a browser in a Google Analytics data is produced by Mozilla


**Friendly name**: Is Mozilla Browser

##[fenix_build_to_datetime](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/fenix_build_to_datetime)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/fenix_build_to_datetime/metadata.yaml)

**Friendly name**: Fenix Build To Datetime

**Description**: Convert the Fenix client_info.app_build-format string to a DATETIME.
May return NULL on failure.

Fenix originally used an [8-digit app_build format](
  https://github.com/mozilla-mobile/fenix/blob/c7283447/automation/gradle/versionCode.gradle#L12-L16)

In short it is `yDDDHHmm`:

 * y is years since 2018
 * DDD is day of year, 0-padded, 001-366
 * HH is hour of day, 00-23
 * mm is minute of hour, 00-59

The last date seen with an 8-digit build ID is 2020-08-10.

Newer builds use a [10-digit format](
  https://github.com/mozilla-mobile/fenix/blob/e6ee13dc/buildSrc/src/main/java/Config.kt#L55-L112)
where the integer represents a pattern consisting of 32 bits.
The 17 bits starting 13 bits from the left represent a number of hours since
UTC midnight beginning 2014-12-28.

This function tolerates both formats.

After using this you may wish to `DATETIME_TRUNC(result, DAY)` for grouping
by build date.


##[bitmask_lowest_28](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bitmask_lowest_28)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bitmask_lowest_28/metadata.yaml)

**Description**: 

**Friendly name**: Bitmask Lowest 28

##[bits_from_offsets](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bits_from_offsets)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/bits_from_offsets/metadata.yaml)

**Friendly name**: Bits From Offsets

**Description**: Returns a bit pattern of type BYTES compactly encoding the given array of positive integer offsets.
This is primarily useful to generate a compact encoding of dates on which a feature was used, with arbitrarily long history. Example aggregation:
```sql bits_from_offsets(
  ARRAY_AGG(IF(foo, DATE_DIFF(anchor_date, submission_date, DAY), NULL)
            IGNORE NULLS)
) ```
The resulting value can be cast to an INT64 representing the most recent 64 days via:
```sql CAST(CONCAT('0x', TO_HEX(RIGHT(bits >> i, 4))) AS INT64) ```
Or representing the most recent 28 days (compatible with bits28 functions) via:
```sql CAST(CONCAT('0x', TO_HEX(RIGHT(bits >> i, 4))) AS INT64) << 36 >> 36 ```


##[normalize_glean_baseline_client_info](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/normalize_glean_baseline_client_info)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/normalize_glean_baseline_client_info/metadata.yaml)

**Description**: 

**Friendly name**: Normalize Glean Baseline Client Info

##[normalize_monthly_searches](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/normalize_monthly_searches)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/normalize_monthly_searches/metadata.yaml)

**Description**: Sum up the monthy search count arrays by normalized engine

**Friendly name**: Normalize Monthly Searches

##[parse_desktop_telemetry_uri](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/parse_desktop_telemetry_uri)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/parse_desktop_telemetry_uri/metadata.yaml)

**Description**: Parses and labels the components of a telemetry desktop ping submission uri Per https://docs.telemetry.mozilla.org/concepts/pipeline/http_edge_spec.html#special-handling-for-firefox-desktop-telemetry the format is /submit/telemetry/docId/docType/appName/appVersion/appUpdateChannel/appBuildID e.g. /submit/telemetry/ce39b608-f595-4c69-b6a6-f7a436604648/main/Firefox/61.0a1/nightly/20180328030202

**Friendly name**: Parse Desktop Telemetry Uri

##[normalize_main_payload](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/normalize_main_payload)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/normalize_main_payload/metadata.yaml)

**Description**: Accepts a pipeline metadata struct as input and returns a modified struct that includes a few parsed or normalized variants of the input metadata fields.

**Friendly name**: Normalize Main Payload

##[map_revenue_country](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/map_revenue_country)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/map_revenue_country/metadata.yaml)

**Description**: Only for use by the LTV Revenue join.  Maps country codes to the codes we have in the revenue dataset. Buckets small Bing countries into "other".

**Friendly name**: Map Revenue Country

##[glean_timespan_seconds](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/glean_timespan_seconds)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/glean_timespan_seconds/metadata.yaml)

**Description**: 

**Friendly name**: Glean Timespan Seconds

##[aggregate_search_counts](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/aggregate_search_counts)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/aggregate_search_counts/metadata.yaml)

**Description**: 

**Friendly name**: Aggregate Search Counts

##[kv_array_to_json_string](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/kv_array_to_json_string)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/kv_array_to_json_string/metadata.yaml)

**Description**: Returns a JSON string representing the input key-value array. Value type must be able to be represented as a string - this function will cast to a string. At Mozilla, the schema for a map is STRUCT<key_value ARRAY<STRUCT<key ANY TYPE, value ANY TYPE>>>. To use this with that representation, it should be as `udf.kv_array_to_json_string(struct.key_value)`.

**Friendly name**: Kv Array To Json String

##[combine_adjacent_days_365_bits](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/combine_adjacent_days_365_bits)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/combine_adjacent_days_365_bits/metadata.yaml)

**Description**: 

**Friendly name**: Combine Adjacent Days 365 Bits

##[one_as_365_bits](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/one_as_365_bits)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/one_as_365_bits/metadata.yaml)

**Description**: One represented as a byte array of 365 bits

**Friendly name**: One As 365 Bits

##[deanonymize_event](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/deanonymize_event)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/deanonymize_event/metadata.yaml)

**Description**: Rename struct fields in anonymous event tuples to meaningful names.

**Friendly name**: Deanonymize Event

##[mod_uint128](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/mod_uint128)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/mod_uint128/metadata.yaml)

**Description**: This function returns "dividend mod divisor" where the dividend and the result is encoded in bytes, and divisor is an integer.

**Friendly name**: Mod Uint128

##[add_monthly_engine_searches](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/add_monthly_engine_searches)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/add_monthly_engine_searches/metadata.yaml)

**Description**: This function specifically windows searches into calendar-month windows. This means groups are not necessarily directly comparable, since different months have different numbers of days.  On the first of each month, a new month is appended, and the first month is dropped.  If the date is not the first of the month, the new entry is added to the last element in the array.  For example, if we were adding 12 to [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]:  On the first of the month, the result would be [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 12] On any other day of the month, the result would be [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 24]  This happens for every aggregate (searches, ad clicks, etc.)

**Friendly name**: Add Monthly Engine Searches

##[shift_365_bits_one_day](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/shift_365_bits_one_day)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/shift_365_bits_one_day/metadata.yaml)

**Description**: Shift input bits one day left and drop any bits beyond 365 days.

**Friendly name**: Shift 365 Bits One Day

##[json_extract_int_map](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/json_extract_int_map)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/json_extract_int_map/metadata.yaml)

**Description**: 

**Friendly name**: Json Extract Int Map

##[histogram_percentiles](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/histogram_percentiles)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/histogram_percentiles/metadata.yaml)

**Description**: 

**Friendly name**: Histogram Percentiles

##[normalize_search_engine](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/normalize_search_engine)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/normalize_search_engine/metadata.yaml)

**Description**: Return normalized engine name for recognized engines

**Friendly name**: Normalize Search Engine

##[safe_crc32_uuid](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/safe_crc32_uuid)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/safe_crc32_uuid/metadata.yaml)

**Description**: Calculate the CRC-32 hash of a 36-byte UUID, or NULL if the value isn't 36 bytes.  This implementation is limited to an exact length because recursion does not work. Based on https://stackoverflow.com/a/18639999/1260237 See https://en.wikipedia.org/wiki/Cyclic_redundancy_check

**Friendly name**: Safe CRC-32 Uuid

##[extract_histogram_sum](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/extract_histogram_sum)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/extract_histogram_sum/metadata.yaml)

**Description**: This is a performance optimization compared to the more general mozfun.hist.extract for cases where only the histogram sum is needed.  It must support all the same format variants as mozfun.hist.extract but this simplification is necessary to keep the main_summary query complexity in check.

**Friendly name**: Extract Histogram Sum

##[histogram_normalize](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/histogram_normalize)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/udf/histogram_normalize/metadata.yaml)

**Description**: 

**Friendly name**: Histogram Normalize

