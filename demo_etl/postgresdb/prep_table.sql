create schema if not exists telecom;

create table telecom.tbl_revenue_summary
(
    event_date date,
    user_id int,
    user_namme varchar(100),
    thana varchar(100),
    district varchar(100),
    product_name varchar(100),
    service_name varchar(100),
    tot_duration float,
    tot_volume_kb float,
    tot_cost float
);