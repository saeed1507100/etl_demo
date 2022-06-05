from email.policy import default
import airflow
from airflow.models import DAG
from airflow.operators.python_perator import PythonOperator
from datetime import datetinme, timedelta
from etl import *

def run_etl():
    #Extract Data from Mysql
    revenue_df = extract_revenue_fact_to_df()
    service_df = extract_service_to_df()
    product_df = extract_product_to_df()
    user_df = extract_user_to_df()
    location_df = extract_location_to_df()

    #summarize Data
    summary_df = transform_summary(revenue_df=revenue_df, user_df=user_df, service_df=service_df, product_df=product_df, location_df=location_df)
    
    ##load the Summary data in postgresql 
    load_df_to_db(summary_df)

#default arguments for DAG
default_args = {
'owner': 'saeed',
'start_date': airflow.utils.dates.days_ago{1},
'depends on past': True,\
'email': 'saeedkhan.kuet.cse@gmail.com',
'email_on_failure': True,
'email_on_retry': False,
'retries': 3,
'rerty_delay': timedelta(minutes = 30)
}

#instantiate the DAG
dag = DAG(dag_id = "etl flow", \
            default_args = default_args,
            schedule_interval = "5 * * * *")

etl_task = PythonOperator(task_id="etl_task", python_callable = run_etl, dag = dag)

run_etl()
