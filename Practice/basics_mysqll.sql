show databases;
show tables;
select table_name from information_schema.TABLES;
use DBMS;
select * from AI_models;


-- DDL ---------------------------------------------------------------------------------------------------------------------------
create table trail (
    name varchar(20),
    id int(3) zerofill
);
insert into trail(name , id)
    values ('awwru',101),
           ('mitch',2);
select * from trail;


alter table trail
    add city varchar(10);
select * from trail;


alter table trail
    modify city text;
select * from trail;

alter table trail
    change city shaher text;
select * from trail;

rename table trail to detrail;
alter table detrail
    add id int;
alter table detrail
    add city varchar(10);
insert into detrail(name , id)
values ('awwru',101),
       ('mitch',2);
-- drop table trail;


-- Drop a database
-- DROP DATABASE db_name;

-- Drop an index
-- DROP INDEX index_name ON table_name;

alter table detrail drop column id;

-- truncate table detrail;

select * from detrail;

create index indx on detrail(id);
create unique index u_indx on detrail(city);
create index indxs on detrail(name,id,city);

create view obs as select name , id , city from detrail where id!=0;
select * from obs;

create or replace view obs as select name from detrail where id=101;
select * from obs;

create schema us;
-- comment on table detrail is "is a trail table";


-- DML ---------------------------------------------------------------------------------------------------------------------------

-- continued in inter_mysql.sql
