show databases;
show tables;
select table_name from information_schema.TABLES;
use DBMS;

create table t(name varchar(100) , id int , age text);
insert into t(name , id , age )
values ('s',101,'20') ,
       ('s',101,'20'),
       ('s',101,'20'),
       ('s',101,'20'),
       ('s',101,'20'),
       ('s',101,'20'),
       ('s',101,'20'),
       ('s',101,'20');
select * from t;
alter table t add city text;
select * from t;
alter table t change city shaher text;
alter table t change id idd int;
alter table t change name nam varchar(100);
alter table t change idd id int;
alter table t change nam name varchar(100);

alter table t modify id tinyint;
alter table t modify name text;

alter table t drop column shaher;
alter table t add column city text;

rename table t to tt;
-- drop tt;
-- truncate tt;