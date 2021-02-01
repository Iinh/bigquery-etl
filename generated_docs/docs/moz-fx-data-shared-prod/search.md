---
title: search
---

##[mobile_search_aggregates](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/search/mobile_search_aggregates)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/search/mobile_search_aggregates/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.search.mobile_search_aggregates`
AS
SELECT
  * EXCEPT (normalized_engine),
  `moz-fx-data-shared-prod`.udf.normalize_search_engine(engine) AS normalized_engine,
  search_count AS sap,
FROM
  `moz-fx-data-shared-prod.search_derived.mobile_search_aggregates_v1`
~~~~
##[mobile_search_clients_last_seen](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/search/mobile_search_clients_last_seen)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/search/mobile_search_clients_last_seen/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.search.mobile_search_clients_last_seen`
AS
SELECT
  * EXCEPT (engine_searches, total_searches),
  `moz-fx-data-shared-prod`.udf.normalize_monthly_searches(engine_searches) AS engine_searches,
FROM
  `moz-fx-data-shared-prod.search_derived.mobile_search_clients_last_seen_v1`
~~~~
##[desktop_search_aggregates_for_searchreport](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/search/desktop_search_aggregates_for_searchreport)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/search/desktop_search_aggregates_for_searchreport/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.search.desktop_search_aggregates_for_searchreport`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.search_derived.desktop_search_aggregates_for_searchreport_v1`
~~~~
##[search_rfm](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/search/search_rfm)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/search/search_rfm/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.search.search_rfm`
AS
SELECT
  `moz-fx-data-shared-prod.udf.days_seen_bytes_to_rfm`(days_seen_bytes) AS days_seen,
  `moz-fx-data-shared-prod.udf.days_seen_bytes_to_rfm`(days_searched_bytes) AS days_searched,
  `moz-fx-data-shared-prod.udf.days_seen_bytes_to_rfm`(
    days_tagged_searched_bytes
  ) AS days_tagged_searched,
  `moz-fx-data-shared-prod.udf.days_seen_bytes_to_rfm`(
    days_searched_with_ads_bytes
  ) AS days_searched_with_ads,
  `moz-fx-data-shared-prod.udf.days_seen_bytes_to_rfm`(days_clicked_ads_bytes) AS days_clicked_ads,
  `moz-fx-data-shared-prod.udf.bits_to_days_since_first_seen`(
    days_created_profile_bytes
  ) AS days_since_created_profile,
  * EXCEPT (
    days_seen_bytes,
    days_searched_bytes,
    days_tagged_searched_bytes,
    days_searched_with_ads_bytes,
    days_clicked_ads_bytes,
    days_created_profile_bytes
  )
FROM
  `moz-fx-data-shared-prod.search_derived.search_clients_last_seen_v1`
~~~~
##[mobile_search_aggregates_for_searchreport](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/search/mobile_search_aggregates_for_searchreport)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/search/mobile_search_aggregates_for_searchreport/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.search.mobile_search_aggregates_for_searchreport`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.search_derived.mobile_search_aggregates_for_searchreport_v1`
~~~~
##[search_clients_last_seen](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/search/search_clients_last_seen)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/search/search_clients_last_seen/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.search.search_clients_last_seen`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.search.search_clients_last_seen_v1`
~~~~
##[mobile_search_clients_daily](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/search/mobile_search_clients_daily)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/search/mobile_search_clients_daily/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.search.mobile_search_clients_daily`
AS
SELECT
  * EXCEPT (normalized_engine),
  `moz-fx-data-shared-prod`.udf.normalize_search_engine(engine) AS normalized_engine,
  search_count AS sap,
FROM
  `moz-fx-data-shared-prod.search_derived.mobile_search_clients_daily_v1`
~~~~
##[desktop_search_aggregates_by_userstate](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/search/desktop_search_aggregates_by_userstate)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/search/desktop_search_aggregates_by_userstate/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.search.desktop_search_aggregates_by_userstate`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod.search_derived.desktop_search_aggregates_by_userstate_v1`
~~~~
##[search_clients_daily](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/search/search_clients_daily)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/search/search_clients_daily/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.search.search_clients_daily`
AS
SELECT
  submission_date AS submission_date_s3,
  * EXCEPT (normalized_engine),
  `moz-fx-data-shared-prod`.udf.normalize_search_engine(engine) AS normalized_engine,
FROM
  `moz-fx-data-shared-prod.search_derived.search_clients_daily_v8`
~~~~
##[search_clients_last_seen_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/search/search_clients_last_seen_v1)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/search/search_clients_last_seen_v1/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.search.search_clients_last_seen_v1`
AS
SELECT
  * EXCEPT (total_searches),
  `moz-fx-data-shared-prod`.udf.bits_to_days_since_seen(days_seen_bytes) AS days_since_seen,
  `moz-fx-data-shared-prod`.udf.bits_to_days_since_seen(days_searched_bytes) AS days_since_searched,
  `moz-fx-data-shared-prod`.udf.bits_to_days_since_seen(
    days_tagged_searched_bytes
  ) AS days_since_tagged_searched,
  `moz-fx-data-shared-prod`.udf.bits_to_days_since_seen(
    days_searched_with_ads_bytes
  ) AS days_since_searched_with_ads,
  `moz-fx-data-shared-prod`.udf.bits_to_days_since_seen(
    days_clicked_ads_bytes
  ) AS days_since_clicked_ad,
  `moz-fx-data-shared-prod`.udf.bits_to_days_since_first_seen(
    days_created_profile_bytes
  ) AS days_since_created_profile
FROM
  `moz-fx-data-shared-prod.search_derived.search_clients_last_seen_v1`
~~~~
##[search_aggregates](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/search/search_aggregates)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/search/search_aggregates/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.search.search_aggregates`
AS
SELECT
  submission_date AS submission_date_s3,
  * EXCEPT (normalized_engine),
  `moz-fx-data-shared-prod`.udf.normalize_search_engine(engine) AS normalized_engine,
FROM
  `moz-fx-data-shared-prod.search_derived.search_aggregates_v8`
~~~~
