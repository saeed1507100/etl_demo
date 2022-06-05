# etl_demo
This is a Demo of an ETL flow using docker for the platforms &amp; airflow for scheduling the etl task.

# Steps:

## 1. Pull

## 2. open teminal/commandline

## 3. create network
docker network create -d bridge etl-demo-net

## 4. go to demo_etl/ (cd)
8
cd ./demo_etl/

## 5. build mysql image
docker build --tag my-sql-image-0 ./mysqldb/ 

## 6. create mysql container
docker run -it -d --name mysql-0 -p 33061:33061 --network="etl-demo-net"  -e MYSQL_ROOT_PASSWORD=password mysql-image-0

### optional
    #### run bash
    docker exec -ti mysql-0 bash   
    #### connect to mysql
    mysql -u root -ppassword
    ### check data
    use telecom;
    select * from telecom.tbl_trans_revenue;


## 7. build postgres image (check if ./postgresdb instead of . works)
docker build --tag postgres-image-0 ./postgresdb/  

## 8. create postgres container
docker run -ti --rm -d --name postgres-0 --network etl-demo-net -p 54321:54321 -e POSTGRES_PASSWORD=password postgres-image-0

### optional
    #### run bash
    docker exec -ti postgres-0 bash   
    #### connect to postgresql
    psql -U postgres
    #### check data
    set search_path to telecom;
    select * from binge_db.tbl_revenue_summary;


## Check the scheduled job
    docker exec -ti postgres-0 bash 
    airflow webserver
