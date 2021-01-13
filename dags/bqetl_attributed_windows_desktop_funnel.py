# Generated via https://github.com/mozilla/bigquery-etl/blob/master/bigquery_etl/query_scheduling/generate_airflow_dags.py

from airflow import DAG
from airflow.operators.sensors import ExternalTaskSensor
import datetime
from utils.gcp import bigquery_etl_query, gke_command

default_args = {
    "owner": "wlachance@mozilla.com",
    "start_date": datetime.datetime(2020, 7, 1, 0, 0),
    "end_date": None,
    "email": ["wlachance@mozilla.com", "telemetry-alerts@mozilla.com"],
    "depends_on_past": False,
    "retry_delay": datetime.timedelta(seconds=1800),
    "email_on_failure": True,
    "email_on_retry": True,
    "retries": 2,
}

with DAG(
    "bqetl_attributed_windows_desktop_funnel",
    default_args=default_args,
    schedule_interval="@daily",
) as dag:

    telemetry_derived__attr_win_desktop_funnel_new_profiles__v1 = bigquery_etl_query(
        task_id="telemetry_derived__attr_win_desktop_funnel_new_profiles__v1",
        destination_table="attributed_windows_desktop_funnel_new_profiles_v1",
        dataset_id="telemetry_derived",
        project_id="moz-fx-data-shared-prod",
        owner="example@mozilla.com",
        email=[
            "example@mozilla.com",
            "telemetry-alerts@mozilla.com",
            "wlachance@mozilla.com",
        ],
        date_partition_parameter="submission_date",
        depends_on_past=False,
        dag=dag,
    )

    telemetry_derived__attr_windows_desktop_funnel_installs___v1 = bigquery_etl_query(
        task_id="telemetry_derived__attr_windows_desktop_funnel_installs___v1",
        destination_table="attributed_windows_desktop_funnel_installs_v1",
        dataset_id="telemetry_derived",
        project_id="moz-fx-data-shared-prod",
        owner="wlachance@mozilla.com",
        email=["telemetry-alerts@mozilla.com", "wlachance@mozilla.com"],
        date_partition_parameter="submission_date",
        depends_on_past=False,
        dag=dag,
    )

    telemetry_derived__attr_windows_desktop_funnel_sessions___v1 = bigquery_etl_query(
        task_id="telemetry_derived__attr_windows_desktop_funnel_sessions___v1",
        destination_table="attributed_windows_desktop_funnel_sessions_v1",
        dataset_id="telemetry_derived",
        project_id="moz-fx-data-shared-prod",
        owner="shong@mozilla.com",
        email=[
            "shong@mozilla.com",
            "telemetry-alerts@mozilla.com",
            "wlachance@mozilla.com",
        ],
        date_partition_parameter="submission_date",
        depends_on_past=False,
        dag=dag,
    )

    wait_for_copy_deduplicate_all = ExternalTaskSensor(
        task_id="wait_for_copy_deduplicate_all",
        external_dag_id="copy_deduplicate",
        external_task_id="copy_deduplicate_all",
        execution_delta=datetime.timedelta(days=-1, seconds=82800),
        check_existence=True,
        mode="reschedule",
        pool="DATA_ENG_EXTERNALTASKSENSOR",
    )

    telemetry_derived__attr_win_desktop_funnel_new_profiles__v1.set_upstream(
        wait_for_copy_deduplicate_all
    )
    wait_for_telemetry_derived__clients_last_seen__v1 = ExternalTaskSensor(
        task_id="wait_for_telemetry_derived__clients_last_seen__v1",
        external_dag_id="bqetl_main_summary",
        external_task_id="telemetry_derived__clients_last_seen__v1",
        execution_delta=datetime.timedelta(days=-1, seconds=79200),
        check_existence=True,
        mode="reschedule",
        pool="DATA_ENG_EXTERNALTASKSENSOR",
    )

    telemetry_derived__attr_win_desktop_funnel_new_profiles__v1.set_upstream(
        wait_for_telemetry_derived__clients_last_seen__v1
    )

    telemetry_derived__attr_windows_desktop_funnel_installs___v1.set_upstream(
        wait_for_copy_deduplicate_all
    )

    wait_for_ga_derived__www_site_metrics_summary__v1 = ExternalTaskSensor(
        task_id="wait_for_ga_derived__www_site_metrics_summary__v1",
        external_dag_id="bqetl_google_analytics_derived",
        external_task_id="ga_derived__www_site_metrics_summary__v1",
        execution_delta=datetime.timedelta(days=-1, seconds=3600),
        check_existence=True,
        mode="reschedule",
        pool="DATA_ENG_EXTERNALTASKSENSOR",
    )

    telemetry_derived__attr_windows_desktop_funnel_sessions___v1.set_upstream(
        wait_for_ga_derived__www_site_metrics_summary__v1
    )
