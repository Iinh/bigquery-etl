---
title: activity_stream
---

##[impression_stats_by_experiment](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/activity_stream/impression_stats_by_experiment)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/activity_stream/impression_stats_by_experiment/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.activity_stream.impression_stats_by_experiment`
AS
SELECT
  tile_id,
  tile_id_types.type AS tile_type,
  stats.* EXCEPT (tile_id)
FROM
  `moz-fx-data-shared-prod.activity_stream_bi.impression_stats_by_experiment_v1` AS stats
LEFT JOIN
  `moz-fx-data-shared-prod.activity_stream.tile_id_types` AS tile_id_types
USING
  (tile_id)
~~~~
##[tile_id_types](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/activity_stream/tile_id_types)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/activity_stream/tile_id_types/view.sql)

~~~~sql
-- This is an authorized view that allows us to read specific data from
-- a project owned by the Pocket team; if the definition here changes,
-- it may need to be manually redeployed by Data Ops.
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.activity_stream.tile_id_types`
AS
SELECT
  *
FROM
  `pocket-tiles.pocket_tiles_data.tile_id_types`
~~~~
##[impression_stats_flat](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/activity_stream/impression_stats_flat)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/activity_stream/impression_stats_flat/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.activity_stream.impression_stats_flat`
AS
SELECT
  tile_id,
  tile_id_types.type AS tile_type,
  stats.* EXCEPT (tile_id)
FROM
  `moz-fx-data-shared-prod.activity_stream_bi.impression_stats_flat_v1` AS stats
LEFT JOIN
  `moz-fx-data-shared-prod.activity_stream.tile_id_types` AS tile_id_types
USING
  (tile_id)
~~~~
