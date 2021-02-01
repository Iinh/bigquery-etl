---
title: account_ecosystem_restricted
---

##[ecosystem_client_id_deletion_v1](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/account_ecosystem_restricted/ecosystem_client_id_deletion_v1)
### [Metadata](https://github.com/mozilla/bigquery-etl/blob/master/sql/moz-fx-data-shared-prod/account_ecosystem_restricted/ecosystem_client_id_deletion_v1/metadata.yaml)

**Friendly name**: Ecosystem Client ID Deletion

**Description**: Provides ecosystem_client_id values that have appeared in a deletion-request ping.
Also includes the hashed version of the ID to enable deletion of rows in derived tables containing the hash.


**Owners**: [jklukas@mozilla.com](mailto:jklukas@mozilla.com)

**Schedule**: daily

**DAG name**: [bqetl_account_ecosystem](https://github.com/mozilla/bigquery-etl/blob/master/dags/bqetl_account_ecosystem.py)

