# etl_demo
This is a Demo of an ETL flow using docker for the platforms &amp; airflow for scheduling the etl task.

# Steps:

## 1. Pull
2
​
3
open teminal
4
## create network
5
docker network create -d bridge etl-demo-net
6
​
7
## go to ./mysqldb/ (cd)
8
cd ./mysqldb/
9
​
10
## build mysql image
11
docker build --tag my-sql-image-0 . 
12
​
13
## create mysql container
14
docker run -it -d --name mysql-0 -p 33061:33061 --network="etl-demo-net"  -e MYSQL_ROOT_PASSWORD=password mysql-image-0
15
​
16
## optional
17
    ## run bash
18
    docker exec -ti mysql-0 bash   
19
    ## connect to mysql
20
    mysql -u root -ppassword
21
    ## check data
22
    use binge_db;
23
    select * from binge_db.movies;
24
​
25
## go to ./postgresdb/
26
cd ../postgresdb/
27
​
28
## build postgres image (check if ./postgresdb instead of . works)
29
docker build --tag postgres-image-0 ./postgresdb/  
30
​
31
## create postgres container
32
docker run -ti --rm -d --name postgres-0 --network etl-demo-net -p 54321:54321 -e POSTGRES_PASSWORD=password postgres-image-0
33
​
34
## optional
35
    ## run bash
36
    docker exec -ti postgres-0 bash   
37
    ## connect to mysql
38
    psql -U postgres
39
    ## check data
40
    \c prod;
41
    set search_path to binge_db;
42
    \dt
43
    select * from binge_db.movies;
44
​
45
## create pyspark/airflow container
No file chosen
Attach files by dragging & dropping, selecting or pasting them.
@saeed1507100
Commit changes
Commit summary
Create readme.md
Optional extended description
Add an optional extended description…
 Commit directly to the main branch.
 Create a new branch for this commit and start a pull request. Learn more about pull requests.
 
© 2022 GitHub, Inc.
Terms
Privacy
Security
Status
Docs
Contact GitHub
Pricing
API
Training
Blog
About
