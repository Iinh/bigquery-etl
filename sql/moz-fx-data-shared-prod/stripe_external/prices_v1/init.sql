CREATE OR REPLACE TABLE
  `moz-fx-data-shared-prod`.stripe_external.prices_v1
PARTITION BY
  DATE(created)
CLUSTER BY
  created
AS
WITH events AS (
  SELECT
    created AS event_timestamp,
    `data`.price.*,
  FROM
    events_v1
  WHERE
    `data`.price IS NOT NULL
  UNION ALL
  SELECT
    created AS event_timestamp,
    *,
  FROM
    initial_prices_v1
)
SELECT
  id,
  ARRAY_AGG(events ORDER BY event_timestamp DESC LIMIT 1)[OFFSET(0)].* EXCEPT (id),
FROM
  events
GROUP BY
  id
