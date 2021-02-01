---
title: stripe
---

##[customers](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/stripe/customers)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/stripe/customers/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.stripe.customers`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod`.stripe_derived.customers_v1
~~~~
##[plan](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/stripe/plan)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/stripe/plan/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.stripe.plans`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod`.stripe_derived.plans_v1
~~~~
##[product](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/stripe/product)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/stripe/product/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.stripe.products`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod`.stripe_derived.products_v1
~~~~
##[subscription](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/stripe/subscription)
### [View](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/stripe/subscription/view.sql)

~~~~sql
CREATE OR REPLACE VIEW
  `moz-fx-data-shared-prod.stripe.subscriptions`
AS
SELECT
  *
FROM
  `moz-fx-data-shared-prod`.stripe_derived.subscriptions_v1
~~~~
