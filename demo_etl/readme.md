#pull repo#

open teminal
## create network
docker network create -d bridge etl-demo-net

## go to ./mysqldb/ (cd)
cd ./mysqldb/

## build mysql image
docker build --tag my-sql-image-0 . 

## create mysql container
docker run -it -d --name mysql-0 -p 33061:33061 --network="etl-demo-net"  -e MYSQL_ROOT_PASSWORD=password mysql-image-0

## optional
    ## run bash
    docker exec -ti mysql-0 bash   
    ## connect to mysql
    mysql -u root -ppassword
    ## check data
    use binge_db;
    select * from binge_db.movies;

## go to ./postgresdb/
cd ../postgresdb/

## build postgres image (check if ./postgresdb instead of . works)
docker build --tag postgres-image-0 ./postgresdb/  

## create postgres container
docker run -ti --rm -d --name postgres-0 --network etl-demo-net -p 54321:54321 -e POSTGRES_PASSWORD=password postgres-image-0

## optional
    ## run bash
    docker exec -ti postgres-0 bash   
    ## connect to mysql
    psql -U postgres
    ## check data
    \c prod;
    set search_path to binge_db;
    \dt
    select * from binge_db.movies;

## create pyspark/airflow container
