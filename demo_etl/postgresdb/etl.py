##import required libraries
import pyspark.sql
from pyspark.sql import SparkSession


#Mysql-0connector
conn = mysql.connector.connect(user='root', database='telecom',
                               password='password',
                               host="mysql-0",
                               port=33061)






##create spark session
#.config("spark.jars", "/usr/share/java/mysql-connector-java-8.0.22.jar") \
spark_mysql = SparkSession \
    .builder \
    .config('spark.jars.packages', 'mysql:mysql-connector-java:5.1.44') \
    .master("local").appName("PySpark_MySQL_data_load").getOrCreate()


def extract_revenue_fact_to_df():
    revenue_df = spark_mysql.read \
        .format('jdbc') \
        .option('url', 'jdbc:mysql://mysql-0:33061') \
        .option('driver', 'com.mysql.jdbc.Driver') \
        .option('user', 'root') \
        .option('password', 'password') \
        .option('dbtable', 'telecom.tbl_fact_revenue') \
        .load()

    return revenue_df


def extract_location_to_df():
    location_df = spark_mysql.read \
        .format('jdbc') \
        .option('url', 'jdbc:mysql://mysql-0:33061') \
        .option('driver', 'com.mysql.jdbc.Driver') \
        .option('user', 'root') \
        .option('password', 'password') \
        .option('dbtable', 'telecom.tbl_dim_location') \
        .load()

    return location_df


def extract_user_to_df():
    user_df = spark_mysql.read \
        .format('jdbc') \
        .option('url', 'jdbc:mysql://mysql-0:33061') \
        .option('driver', 'com.mysql.jdbc.Driver') \
        .option('user', 'root') \
        .option('password', 'password') \
        .option('dbtable', 'telecom.tbl_dim_user') \
        .load()

    return user_df

def extract_service_to_df():
    service_df = spark_mysql.read \
        .format('jdbc') \
        .option('url', 'jdbc:mysql://mysql-0:33061') \
        .option('driver', 'com.mysql.jdbc.Driver') \
        .option('user', 'root') \
        .option('password', 'password') \
        .option('dbtable', 'telecom.tbl_dim_service') \
        .load()

    return service_df

def extract_product_to_df():
    product_df = spark_mysql.read \
        .format('jdbc') \
        .option('url', 'jdbc:mysql://mysql-0:33061') \
        .option('driver', 'com.mysql.jdbc.Driver') \
        .option('user', 'root') \
        .option('password', 'password') \
        .option('dbtable', 'telecom.tbl_dim_product') \
        .load()

    return product_df






def transform_summary(revenue_df, user_df, product_df, service_df, location_df):
    ## transforming tables
    # avg_rating = users_df.groupBy("movie_id").mean("rating")
    # df = movies_df.join(
    # avg_rating,
    # movies_df.id == avg_rating.movie_id
    # )

    df = revenue_df.join(user_df, revenue_df.user_id == user_df.id) \
        .join(service_df, revenue_df.service_id == service_df.id) \
        .join(location_df, revenue_df.location_id == location_df.id) \
        .join(product_df, user_df.product_id == product_df.id) 

    summary_df = df.groupBy("event_date","user_id","user_name","product_name","service_name","thana","district") \
        .sum("duration","volumme","cost")
    
    return summary_df


##load transformed dataframe to the database
def load_df_to_db(df):
    mode = "overwrite"
    url = "jdbc:postgresql://localhost:54321/postgres"
    properties = {"user": "postgres",
                  "password": "password",
                  "driver": "org.postgresql.Driver"
                  }
    df.write.jdbc(url=url,
                  table = "telecom.tbl_revenue_summary",
                  mode = mode,
                  properties = properties)


if __name__ == "__main__":

    #Extract Data from Mysql
    revenue_df = extract_revenue_fact_to_df()
    print(revenue_df.show())

    service_df = extract_service_to_df()
    print(service_df.show())

    product_df = extract_product_to_df()
    print(product_df.show())

    user_df = extract_user_to_df()
    print(user_df.show())

    location_df = extract_location_to_df()
    print(location_df.show())

    #summarize Data
    summary_df = transform_summary(revenue_df=revenue_df, user_df=user_df, service_df=service_df, product_df=product_df, location_df=location_df)
    print(summary_df.shpw())

    ##load the Summary data in postgresql 
    load_df_to_db(summary_df)

