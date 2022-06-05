create database binge_db;



create table binge_db.movies
(
    id int primary key,
    name varchar(100),
    description varchar(100),
    category varchar(50)
);

insert into binge_db.movies (id, name, description, category)
values
(1,'Spark','Spark is a action movie','action'),
(2,'hadoop','hadoop is a comedy movie','comedy'),
(3,'hive','hive is a romantic movie','romantic'),
(4,'impala','impala is a action movie','action'),
(5,'presto','presto is a action movie','action');

create table binge_db.user_rating
(
    id int,
    movie_id int,
    rating float,
    foreign key(movie_id) references binge_db.movies(id)
);


insert into binge_db.user_rating (id, movie_id, rating)
values
(1,1,9.0),
(1,2,4.0),
(1,3,7.5),
(1,5,3.0),
(1,4,8.0),
(2,1,9.0),
(3,2,4.0),
(2,3,7.5),
(2,5,3.0),
(2,4,8.0),
(2,3,9.0),
(4,3,9.0),
(5,3,9.0);


create table binge_db.avg_rating
(
    user_id int,
    movie_id int,
    avg_rating float,
    foreign key(movie_id) references binge_db.movies(id)
);