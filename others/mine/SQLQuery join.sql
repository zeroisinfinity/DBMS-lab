Create Table A (Aid int, Name varchar(20))
Create Table B (Bid int, Name varchar(20),Aid int)

insert Into A values(1,'Sam')
insert Into A values(2,'tom')
insert Into A values(3,'harry')
insert Into A values(4,'katich')
insert Into A values(5,'kate')



insert Into B values(11,'harry',3)
insert Into B values(12,'katich',4)
insert Into B values(13,'kate',5)
insert Into B values(14,'mate',6)
insert Into B values(15,'sat',7)

select * from A;
select * from B;

--select * from A join B on table_name1.common col=table name2.common col;
select * from A join B on A.Aid=B.Aid;

select A.Aid,A.name from A join B on A.Aid=B.Aid;
select A.Aid,A.Name,Bid from A join B on A.Aid = B.Aid;

--LEFT
select * from A LEFT join B on A.Aid=B.Aid; ---* FOR whole table A and B

select A.Aid,A.Name from A LEFT join B on A.Aid=B.Aid;
select * from A right join B on A.Aid=B.Aid;
select * from A full join B on A.Aid=B.Aid ;

---i have 3 tables A,B,C,D
--select * from A join B on A.Aid=B.Aid JOIN c on b.Bid=c.bid join D on c.cid=d.cid;

--inner outer
--Equi join

create table EMP_new (id int, name varchar (10),Company varchar (10),Work varchar (10));
insert into EMP_new values (1,'Amit','Info','pune')
insert into EMP_new values (2,'Puja','Tcs','Mumbai')
insert into EMP_new values (3,'Poonam','Tech','Pune')
insert into EMP_new values (4,'Abhi','Logic','Nagpur')
insert into EMP_new values (5,'Kirti','Lim','Nagar');

create table Job (salary int,base varchar (10),id int)
insert into job values (10000,'Pune',1)
insert into job values (20000,'Mumbai',3)
insert into job values (30000,'Nagpur',4)
insert into job values (40000,'Pune',5)
insert into job values (35000,'Nagar',2);
select * from EMP_new;
select * from job;

select * from EMP_new  join Job on EMP_new.id=job.id where EMP_new.Work=job.base;
select * from EMP_new,Job where EMP_new.id=Job.id and EMP_new.Work=job.base;

--cross joine-1u
select * from A
select * from B

select * from A cross join B;

--self join (only one table)

create table ABC (salary int,base varchar (10),id int)
insert into ABC values (10000,'Pune',1)
insert into ABC values (20000,'Mumbai',3)
insert into ABC values (30000,'Nagpur',4)
insert into ABC values (40000,'Pune',5)
insert into ABC values (35000,'Nagar',2);
SELECT * FROM ABC
 
 SELECT * FROM ABC AS A1,ABC AS A2
