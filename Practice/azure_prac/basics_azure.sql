select name from sys.databases;
select name from sys.tables;
select TABLE_NAME from INFORMATION_SCHEMA.TABLES;

-- DDL ---------------------------------------------------------------------------------------------------------------------------
CREATE TABLE trail (
    name VARCHAR(20),
    id INT
);

INSERT INTO trail (name, id)
VALUES ('awwru', 101), ('mitch', 2);


ALTER TABLE trail
ADD city VARCHAR(10);

alter table trail 
    alter column city varchar(max);
SELECT * FROM trail;

exec sp_rename 'trail.city','shaher','column'
alter table trail 
    alter column shaher varchar(max);
SELECT * FROM trail;


exec sp_rename 'trail','detrail'

--drop table trail;

alter table detrail drop column shaher;

-- truncate table detrail;

create table t (name varchar(100), id int , age text);
insert t(name , id , age) values 
        ('s',101,'20') ,
           ('s',101,'20'),
           ('s',101,'20'),
           ('s',101,'20'),
           ('s',101,'20'),
           ('s',101,'20'),
           ('s',101,'20'),
           ('s',101,'20');

exec sp_rename 't','tt';
exec sp_rename 'tt.name','nam','column'
alter table tt alter column nam varchar(100); 

exec sp_rename 'tt.id', 'idd', 'column'
alter table tt alter column idd int;

-- drop table tt
-- truncate table tt;

alter table tt 
    add kk text;
alter table tt 
add kkk int;
alter table tt 
add okiiooi int;
alter table tt
add oioo int;
alter table tt
add n varchar(100);

alter table tt 
    alter column n varchar(max);
    alter table tt 
    alter column nam text;
    alter table tt
    alter column kkk int; 
    select * from tt;


alter table detrail
    add city varchar(10);
insert into detrail(name , id)
values ('awwru',101),
       ('mitch',2);



CREATE VIEW obs AS
SELECT name, id, city FROM detrail WHERE id != 0; 

    CREATE INDEX indx ON detrail(id);
-- CREATE UNIQUE INDEX u_indx ON detrail(id);
CREATE INDEX indxs ON detrail(name, id, city);


SELECT * FROM obs;
if OBJECT_ID('obs','V') is not null 
    drop view obs;
create view obs as select id from detrail where id = 101;
select * from obs;

create SCHEMA us;
-- drop schema us;

EXEC sp_addextendedproperty 
  @name = N'MS_Description', 
  @value = N'User ID',
  @level0type = N'SCHEMA', @level0name = 'dbo',
  @level1type = N'TABLE',  @level1name = 'detrail',
  @level2type = N'COLUMN', @level2name = 'id';

  -- alter database tempdb modify name = prac;

  -- DML ---------------------------------------------------------------------------------------------------------------------------

  