create database telecom;



create table telecom.tbl_dim_service
(
    id int primary key,
    name varchar(100)
);

insert into telecom.tbl_dim_service
    (id, name)
values
    (1,'VOICE'),
    (2,'SMS'),
    (3,'DATA');





create table telecom.tbl_dim_product
(
    id int primary key,
    name varchar(100)
);

insert into telecom.tbl_dim_product
    (id, name)
values
    (1,'PREPAID'),
    (2,'POSTPAID');




create table telecom.tbl_dim_user
(
    id int primary key,
    name varchar(100),
    product_id int,
    foreign key(product_id) references tbl_dim_product(id)
);

insert into telecom.tbl_dim_user
    (id, name, product_id)
values
    (01800001,'SAEED',1),
    (01800002,'SAAD',2),
    (01800003,'JAID',1),
    (01800004,'JOHN',2);


create table telecom.tbl_dim_location
(
    id int primary key,
    thana varchar(100),
    district varchar(100),
    country varchar(100)
);

insert into telecom.tbl_dim_location
    (id, thana, district, country)
values
    (1,'Khulshi','Chittagong','Banghladesh'),
    (1,'Pachlaish','Chittagong','Banghladesh'),
    (1,'Rauzan','Chittagong','Banghladesh'),
    (1,'Hazaribagh','Dhaka','Banghladesh'),
    (1,'Dhanmondi','Dhaka','Banghladesh'),
    (1,'Lalbag','Dhaka','Banghladesh');




create table telecom.tbl_fact_revenue
(
    event_date date,
    event_time datetime,
    user_id int,
    location_id int,
    service_id int,
    duration float,
    volume_kb float,
    cost float,
    foreign key(user_id) references tbl_dim_user(id),
    foreign key(service_id) references tbl_dim_service(id),
    foreign key(location_id) references tbl_dim_location(id)

);

insert into telecom.tbl_fact_revenue
    (event_date ,event_time ,user_id  ,location_id ,service_id ,duration,volume_kb,cost)
values
    ('2022-01-01', '2022-01-01 10:30:00', 01800001,  1, 1, 10, 0, 11),
    ('2022-01-01', '2022-01-01 10:40:00', 01800002,  2, 1, 10, 0, 11),
    ('2022-01-01', '2022-01-01 10:50:00', 01800003,  3, 1, 10, 0, 11),
    
    ('2022-01-01', '2022-01-01 11:30:00', 01800001,  1, 2, 0, 0, 1),
    ('2022-01-01', '2022-01-01 11:40:00', 01800002,  2, 2, 0, 0, 1),
    ('2022-01-01', '2022-01-01 11:50:00', 01800003,  3, 2, 0, 0, 2),

    ('2022-01-01', '2022-01-01 11:30:00', 01800001,  1, 3, 0, 110, 11),
    ('2022-01-01', '2022-01-01 11:40:00', 01800002,  2, 3, 0,303, 20),
    ('2022-01-01', '2022-01-01 11:50:00', 01800003,  3, 3, 0, 100, 10),


    ('2022-01-01', '2022-01-01 10:30:00', 01800001, 1, 1, 1, 10, 0, 11),
    ('2022-01-01', '2022-01-01 10:30:00', 01800001, 1, 1, 1, 10, 0, 11),
    ('2022-01-01', '2022-01-01 10:30:00', 01800001, 1, 1, 1, 10, 0, 11),
    ('2022-01-01', '2022-01-01 10:30:00', 01800001, 1, 1, 1, 10, 0, 11),
    ('2022-01-01', '2022-01-01 10:30:00', 01800001, 1, 1, 1, 10, 0, 11),
    ('2022-01-01', '2022-01-01 10:30:00', 01800001, 1, 1, 1, 10, 0, 11),
    ('2022-01-01', '2022-01-01 10:30:00', 01800001, 1, 1, 1, 10, 0, 11),
    ('2022-01-01', '2022-01-01 10:30:00', 01800001, 1, 1, 1, 10, 0, 11),
    ('2022-01-01', '2022-01-01 10:30:00', 01800001, 1, 1, 1, 10, 0, 11),
    ('2022-01-01', '2022-01-01 10:30:00', 01800001, 1, 1, 1, 10, 0, 11),
    ('2022-01-01', '2022-01-01 10:30:00', 01800001, 1, 1, 1, 10, 0, 11);

    


