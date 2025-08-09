create table set1(id int, name varchar(10));
create table set2(id int, name varchar(10));
insert into set1 values (1,'A');
insert into set1 values (2,'B');
insert into set1 values (3,'C');
insert into set1 values (4,'D');
select * from set1;

insert into set2 values (4,'D');
insert into set2 values (4,'E');
insert into set2 values (6,'F');
insert into set2 values (7,'G');
select * from set1
select * from set2;

 select * from set1 union select * from set2;
 select * from set1 union  all select * from set2;
 select * from set1 intersect select * from set2;
 select * from set1 except select * from set2;
 select * from set2 except select * from set1;

--select * from set1 minus select * from set2;
 select id from set1 except select id from set2;
 select id from set2 except select id from set1;

 select * from INFORMATION_SCHEMA.COLUMNS








 ---create table set1(id int, name varchar(10));
----create table set2(id int, name varchar(10));
--insert into set1 values (1,'A');
--insert into set1 values (2,'B');
----insert into set1 values (3,'C');
--insert into set1 values (4,'D');
--insert into set2 values (4,'D');
--insert into set2 values (4,'E');
--insert into set2 values (6,'F');
--insert into set2 values (7,'G');