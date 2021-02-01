---
title: mozilla_vpn_external
---

##[devices_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/mozilla_vpn_external/devices_v1)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/mozilla_vpn_external/devices_v1/metadata.yaml)

**Friendly name**: Mozilla VPN Devices

**Description**: A mirror of the devices table from the Mozilla VPN (Guardian) CloudSQL database, updated daily to match the current state of the table. The table history is not needed, because changes made are not destructive, except in the case of self-serve data deletion.


**Owners**: [dthorn@mozilla.com](mailto:dthorn@mozilla.com)

**Schedule**: daily

**DAG name**: [bqetl_mozilla_vpn](https://github.com/mozilla/bigquery-etl/blob/master/dags/bqetl_mozilla_vpn.py)

##[users_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/mozilla_vpn_external/users_v1)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/mozilla_vpn_external/users_v1/metadata.yaml)

**Friendly name**: Mozilla VPN Users

**Description**: A mirror of the users table from the Mozilla VPN (Guardian) CloudSQL database, updated daily to match the current state of the table. The table history is not needed, because changes made are not destructive, except in the case of self-serve data deletion.


**Owners**: [dthorn@mozilla.com](mailto:dthorn@mozilla.com)

**Schedule**: daily

**DAG name**: [bqetl_mozilla_vpn](https://github.com/mozilla/bigquery-etl/blob/master/dags/bqetl_mozilla_vpn.py)

##[waitlist_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/mozilla_vpn_external/waitlist_v1)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/mozilla_vpn_external/waitlist_v1/metadata.yaml)

**Friendly name**: Mozilla VPN Waitlist

**Description**: A mirror of the waitlist table from the Mozilla VPN (Guardian) CloudSQL database, updated daily to match the current state of the table. The table history is not needed, because changes made are not destructive, except in the case of self-serve data deletion.


**Owners**: [dthorn@mozilla.com](mailto:dthorn@mozilla.com)

**Schedule**: daily

**DAG name**: [bqetl_mozilla_vpn](https://github.com/mozilla/bigquery-etl/blob/master/dags/bqetl_mozilla_vpn.py)

##[subscriptions_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/mozilla_vpn_external/subscriptions_v1)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/mozilla_vpn_external/subscriptions_v1/metadata.yaml)

**Friendly name**: Mozilla VPN Subscriptions

**Description**: A mirror of the subscriptions table from the Mozilla VPN (Guardian) CloudSQL database, updated daily to match the current state of the table. The table history is not needed, because changes made are not destructive, except in the case of self-serve data deletion.


**Owners**: [dthorn@mozilla.com](mailto:dthorn@mozilla.com)

**Schedule**: daily

**DAG name**: [bqetl_mozilla_vpn](https://github.com/mozilla/bigquery-etl/blob/master/dags/bqetl_mozilla_vpn.py)

