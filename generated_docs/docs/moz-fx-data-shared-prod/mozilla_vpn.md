---
title: mozilla_vpn
---

##[add_device_events](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/mozilla_vpn/add_device_events)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/mozilla_vpn/add_device_events/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.mozilla_vpn.add_device_events`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod`.mozilla_vpn_derived.add_device_events_v1
~~~~
##[waitlist](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/mozilla_vpn/waitlist)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/mozilla_vpn/waitlist/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.mozilla_vpn.waitlist`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod`.mozilla_vpn_derived.waitlist_v1
~~~~
##[survey_market_fit](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/mozilla_vpn/survey_market_fit)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/mozilla_vpn/survey_market_fit/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.mozilla_vpn.survey_market_fit`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod`.mozilla_vpn_derived.survey_market_fit_v1
~~~~
##[survey_product_quality](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/mozilla_vpn/survey_product_quality)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/mozilla_vpn/survey_product_quality/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.mozilla_vpn.survey_product_quality`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod`.mozilla_vpn_derived.survey_product_quality_v1
~~~~
##[survey_intercept_q3](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/mozilla_vpn/survey_intercept_q3)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/mozilla_vpn/survey_intercept_q3/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.mozilla_vpn.survey_intercept_q3`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod`.mozilla_vpn_derived.survey_intercept_q3_v1
~~~~
##[users](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/mozilla_vpn/users)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/mozilla_vpn/users/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.mozilla_vpn.users`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod`.mozilla_vpn_derived.users_v1
~~~~
##[survey_recommend](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/mozilla_vpn/survey_recommend)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/mozilla_vpn/survey_recommend/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.mozilla_vpn.survey_recommend`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod`.mozilla_vpn_derived.survey_recommend_v1
~~~~
##[login_flows](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/mozilla_vpn/login_flows)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/mozilla_vpn/login_flows/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.mozilla_vpn.login_flows`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod`.mozilla_vpn_derived.login_flows_v1
~~~~
##[protected](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/mozilla_vpn/protected)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/mozilla_vpn/protected/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.mozilla_vpn.protected`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod`.mozilla_vpn_derived.protected_v1
~~~~
##[survey_cancellation_of_service](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/mozilla_vpn/survey_cancellation_of_service)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/mozilla_vpn/survey_cancellation_of_service/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.mozilla_vpn.survey_cancellation_of_service`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod`.mozilla_vpn_derived.survey_cancellation_of_service_v1
~~~~
