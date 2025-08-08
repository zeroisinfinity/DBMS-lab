
create table test_int(id int primary key identity(10,5),
    active TINYINT NOT NULL,
    ageid SMALLINT DEFAULT 0,
    days INT,       -- No MEDIUMINT, use INT
    rankk BIGINT
);

exec sp_help 'test_int';

INSERT INTO test_int (active, ageid, rankk) VALUES
(1, 10, 1001),
(0, 11, 1002),
(1, 12, 1003),
(0, 13, 1004),
(1, 14, 1005),
(1, 15, 1006),
(0, 16, 1007),
(1, 17, 1008),
(0, 18, 1009),
(1, 19, 1010),
(1, 20, 1011),
(0, 21, 1012),
(1, 22, 1013),
(0, 23, 1014),
(1, 24, 1015),
(1, 25, 1016),
(0, 26, 1017),
(1, 27, 1018),
(0, 28, 1019),
(1, 29, 1020);

UPDATE test_int
SET days = CASE 
    WHEN id = 10 THEN ageid * 365
    WHEN id = 11 THEN ageid * 365
    WHEN id = 12 THEN ageid * 365
    WHEN id = 13 THEN ageid * 365
    ELSE days
END;

declare @i int = 10;
while @i <= 29*5
    begin
    update test_int set days = ageid * 365 where id = @i;
    set  @i = @i+1;
end;

select * from test_int;


INSERT INTO test_int (active, ageid, days,  rankk) VALUES
                                                (0, 199, 3680 , 1001);
-- fine


-- INSERT INTO test_int (active, ageid, days,  rankk) VALUES (0896, 199, 3680 , 1001);
-- [22001][1264] Data truncation: Out of range value for column 'active' at row 1

-- INSERT INTO test_int (active, ageid, days,  rankk) VALUES (0, 1996577 , 3680 , 1001);
-- [22001][1264] Data truncation: Out of range value for column 'active' at row 1

-- INSERT INTO test_int (active, ageid, days,  rankk) VALUES (0, 19 , 3687557775670 , 1001);
-- [22001][1264] Data truncation: Out of range value for column 'active' at row 1

INSERT INTO test_int (active, ageid, days,  rankk) VALUES (0, 19 , 36875 , 1065756578541);
-- fine

-- INSERT INTO test_int (active, ageid, days,  rankk) VALUES (0, 19 , 36875 , 10657565785756875741);
-- [22001][1264] Data truncation: Out of range value for column 'active' at row 1

declare @j int = 60;
while @j <= 115
begin 
delete from test_int where id = @j;
set @j = @j + 1;
end;

select * from test_int;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE test_float (
    id INT IDENTITY(1,5) PRIMARY KEY,
    salary DECIMAL(7,4) NOT NULL,
    litre FLOAT,            -- or REAL if you want lower precision
    pi FLOAT                -- use FLOAT instead of DOUBLE
);


-- INSERT INTO test_float (salary, litre, pi) VALUES (1234.5678, 10.5, 3.14159265);
-- Msg 8115, Level 16, State 8, Line 2 Arithmetic overflow error converting numeric to data type numeric.

alter table test_float 
    alter column salary decimal(10,4);

INSERT INTO test_float (salary, litre, pi) VALUES
                                               (1234.5678, 10.5, 3.14159265),
                                               (2345.6789, 20.2, 3.14),
                                               (3456.7890, 15.75, 3.1415),
                                               (4567.8901, 12.3, 3.14159),
                                               (5678.9012, 18.6, 3.1416),
                                               (6789.0123, 11.1, 3.141),
                                               (7890.1234, 16.4, 3.142),
                                               (8901.2345, 19.9, 3.14),
                                               (9012.3456, 14.7, 3.13),
                                               (10123.4567, 13.8, 3.15);
select * from test_float;

-- String literals and escaping
SELECT 'test', '"test"', '""test""', 'te''st';
SELECT 'They''ve found this tutorial to be helpful';
SELECT 'They''ve responded, "We found this tutorial helpful"';

-- temporary cols----------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE NumericReachTest (
    ID INT PRIMARY KEY,
    Region VARCHAR(50),
    SignalStrength DECIMAL(5,2),
    ReachInKM DECIMAL(6,2),
    PopulationCovered BIGINT,
    NoiseLevel DECIMAL(3,2),
    QualityScore DECIMAL(5,2),
    CostEstimate DECIMAL(10,2)
);
INSERT INTO NumericReachTest VALUES
(1, 'North', 87.5, 120.3, 500000, 0.2, 89.6, 12500.00),
(2, 'South', 65.4, 89.6, 300000, 0.8, 78.3, 9800.00),
(3, 'East', 90.0, 140.7, 700000, 0.1, 92.5, 15000.50),
(4, 'West', 55.8, 45.2, 120000, 1.2, 60.9, 5600.00),
(5, 'Central', 75.1, 100.0, 400000, 0.5, 85.0, 11200.25),
(6, 'Northwest', 42.3, 32.6, 80000, 1.5, 52.0, 4200.75),
(7, 'Southeast', 93.4, 160.2, 900000, 0.1, 95.0, 16700.00),
(8, 'Northeast', 88.2, 110.5, 600000, 0.3, 88.7, 13000.00),
(9, 'Southwest', 60.9, 78.9, 250000, 0.9, 70.4, 8700.00),
(10, 'Midlands', 70.0, 95.0, 350000, 0.4, 82.1, 10400.00);

select * from NumericReachTest;
select  ID*10 as id from NumericReachTest; -- option 1 mysql type 
select id = ID*10 from NumericReachTest; -- option 2 mssql/azure(t-sql) type
alter table NumericReachTest
    alter column id int;
select id from NumericReachTest;

DECLARE @k INT = 1;
while @k <= 10
    begin 
        UPDATE NumericReachTest set id = ID+500 where ID = @k;
        set @k = @k + 1;
    end;
select * from NumericReachTest;

alter table NumericReachTest
    add test int;
select test from NumericReachTest;


UPDATE NumericReachTest set test = ID-500 where ID between 501 and 510;
select * from NumericReachTest;

create synonym numr for dbo.NumericReachTest;
EXEC sp_rename 'NumericReachTest', 'numrr';

-- Add new column
ALTER TABLE NumericReachTest
add nill INT;

-- Update nill to NULL for id between 351 and 357
UPDATE numr
SET nill = NULL
WHERE ID BETWEEN 501 AND 507;

-- Update nill to 77 for id > 357
UPDATE numr
SET nill = 77
WHERE ID > 507;

-- Select records where nill IS NULL
SELECT * FROM numr WHERE nill IS NOT NULL;

-- datalength change ----------------------------------------------------------------------------------------------------------------------------------------------
exec sp_help 'numrr';
-- lets change namet to varchar(200)
alter table numrr
    alter column region varchar(200);

-- sql aggregate func -----------------------------------------------------------------------------------------------------------------------------------------------

SELECT
  MAX(id) - (33 - 10) AS no_of_ppl,
  SUM(active) AS total_active,
  MAX(ageid) - MIN(ageid) - AVG(ageid) AS deviation,
  MAX(ageid) AS oldest,
  MIN(rankk) AS first,
  AVG(days) AS avgdays,
  COUNT(DISTINCT id) AS ppl,
  COUNT(DISTINCT ageid) AS diff_ageppl
FROM test_int;

select top(3) id from test_int;

-- order by -----------------------------------------------------------------------------------------------------------------------------------
-- Table
CREATE TABLE dbo.people (
id INT PRIMARY KEY,
first_name NVARCHAR(100) NOT NULL,
last_name NVARCHAR(100) NOT NULL,
age INT NULL,
price DECIMAL(10,2) NULL,
quantity INT NULL,
status NVARCHAR(20) NULL,
category NVARCHAR(20) NULL,
created_at DATETIME2(0) NOT NULL
);

-- Data (22 rows)
INSERT INTO dbo.people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES
(1,N'Alice',N'Zimmer',30,19.99,2,N'normal',N'A','2024-01-01 09:00:00'),
(2,N'alice',N'zimmer',22,19.99,5,N'high',N'A','2024-01-02 10:00:00'),
(3,N'Álvaro',N'Núñez',35,5.00,20,N'urgent',N'B','2024-01-03 11:00:00'),
(4,N'Bob',N'Anderson',40,NULL,NULL,NULL,N'B','2024-01-04 12:00:00'),
(5,N'BOB',N'anderson',NULL,29.95,1,N'normal',N'B','2024-01-05 13:00:00'),
(6,N'Chloé',N'Brontë',28,10.00,10,N'high',N'C','2024-01-06 14:00:00'),
(7,N'Chloe',N'Bronte',28,10.00,10,N'urgent',N'C','2024-01-07 15:00:00'),
(8,N'Dmitri',N'Ivanov',31,100.00,0,N'normal',N'C','2024-01-08 16:00:00'),
(9,N'Émile',N'Zola',52,1.00,100,N'high',N'D','2024-01-09 17:00:00'),
(10,N'Emile',N'Zola',52,1.00,90,N'normal',N'D','2024-01-10 18:00:00'),
(11,N'Fatima',N'al-Zahra',26,7.77,13,N'urgent',N'D','2024-01-11 19:00:00'),
(12,N'George',N'O’Malley',33,15.50,3,NULL,N'E','2024-01-12 20:00:00'),
(13,N'Hélène',N'D’Arcy',NULL,50.00,2,N'high',N'E','2024-01-13 21:00:00'),
(14,N'Helene',N'DArcy',29,50.00,2,N'normal',N'E','2024-01-14 22:00:00'),
(15,N'Ivan',N'Petrov',41,99.99,1,N'urgent',N'F','2024-01-15 23:00:00'),
(16,N'Ivy',N'petrov',41,0.00,100,N'normal',N'F','2024-01-16 09:00:00'),
(17,N'José',N'García',34,12.34,4,N'high',N'F','2024-01-17 09:30:00'),
(18,N'Jose',N'Garcia',34,12.34,4,NULL,N'G','2024-01-18 10:00:00'),
(19,N'Lars',N'Ångström',NULL,8.88,11,N'normal',N'G','2024-01-19 11:00:00'),
(20,N'Márta',N'Németh',25,3.33,NULL,N'urgent',N'G','2024-01-20 12:00:00'),
(21,N'Marta',N'Nemeth',25,3.33,1,N'high',N'H','2024-01-21 13:00:00'),
(22,N'Zoë',N'Quinn',19,200.00,1,N'normal',N'H','2024-01-22 14:00:00');



select * from people;

INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES
(1001,'Alice','Zimmer',NULL,25.00, NULL,'high', 'B','2024-02-01T09:00:00Z'),
(1002,'alice','zimmer',27, NULL, 3, NULL, 'C','2024-02-02T10:10:00Z'),
(1003,'Álvaro','Núñez',NULL,7.50, 5, 'normal', 'A','2024-02-03T11:20:00Z'),
(1004,'Bob','Anderson',38, 12.00, NULL,'urgent','C','2024-02-04T12:30:00Z'),
(1005,'BOB','anderson',42, NULL, 2, 'high', 'D','2024-02-05T13:40:00Z'),
(1006,'Chloé','Brontë',NULL, 9.99, 1, 'normal', 'E','2024-02-06T14:50:00Z'),
(1007,'Chloe','Bronte',31, NULL, NULL,'high', 'E','2024-02-07T15:55:00Z'),
(1008,'Dmitri','Ivanov',NULL,120.00,2, NULL, 'F','2024-02-08T16:05:00Z'),
(1009,'Émile','Zola', 50, NULL, 80, 'urgent', 'A','2024-02-09T17:15:00Z'),
(1010,'Emile','Zola', NULL, 2.00, NULL,'high', 'B','2024-02-10T18:25:00Z'),
(1011,'Fatima','al-Zahra',NULL,6.66, 10, 'normal', 'G','2024-02-11T19:35:00Z'),
(1012,'George','O’Malley',35, NULL, 4, 'urgent','H','2024-02-12T20:45:00Z'),
(1013,'Hélène','D’Arcy',27, NULL, NULL,'normal','A','2024-02-13T21:55:00Z'),
(1014,'Helene','DArcy', NULL, 55.00, 3, NULL, 'C','2024-02-14T22:05:00Z'),
(1015,'Ivan','Petrov', 39, NULL, 2, 'high', 'D','2024-02-15T23:15:00Z'),
(1016,'Ivy','petrov', NULL, 1.00, NULL,'urgent','E','2024-02-16T09:05:00Z'),
(1017,'José','García', NULL, 14.00, 6, NULL, 'F','2024-02-17T09:35:00Z'),
(1018,'Jose','Garcia', 36, NULL, 5, 'normal','G','2024-02-18T10:10:00Z'),
(1019,'Lars','Ångström',35, 9.99, NULL,'high', 'H','2024-02-19T11:20:00Z'),
(1020,'Márta','Németh', NULL, NULL, 2, 'normal','A','2024-02-20T12:30:00Z'),
(1021,'Marta','Nemeth', 26, 4.44, NULL,'urgent','B','2024-02-21T13:40:00Z');

create index sort_indx on people(price desc , first_name desc , last_name desc , quantity desc); 
-- same btree can be trav for/back so no asc needed ( btree datastruct used for indexing) 

select * from people;

select price,quantity,first_name from people order by price;
select people.first_name,people.last_name , price from people order by last_name ,price desc; -- case insent & accent insent
select people.last_name, people.first_name from people order by last_name , first_name desc;

SELECT first_name, last_name, age, price, quantity, status, category, created_at
FROM people
WHERE last_name IN ('Anderson','anderson')
ORDER BY last_name, first_name DESC;

SELECT first_name, last_name, age, price, quantity, status, category, created_at
FROM people
WHERE last_name IN ('Anderson','anderson')
ORDER BY last_name; -- SAME AS ABOVE

-- case insent & accent insent so price becomes sole sorting identity
-- How to keep the “name grouping” stable and still sort by price
-- Add a stable, final tiebreaker (id). This makes results deterministic:
-- ORDER BY last_name DESC, first_name DESC, price DESC, id ASC
select first_name , last_name , price , id from people order by 2 desc ;
select first_name , last_name , price , id from people order by 2 desc ,  1 desc ;
select first_name , last_name , price , id from people order by 2 desc ,  1 desc , 3 desc ;
select first_name , last_name , price , id from people order by 2 desc ,  1 desc , 3 desc , 4 ;
select first_name , last_name , price , id from people order by 2 desc ,  1 desc , 3 desc , 4 desc;


select price*quantity as total_cost , first_name , last_name , price , id from people order by total_cost desc;
select first_name , last_name , price , id from people order by price*quantity desc;

SELECT price, quantity
FROM dbo.people
ORDER BY
CASE WHEN quantity IS NULL THEN 1 ELSE 0 END, -- NULLs last
quantity DESC;

select price , quantity 
    from people
    order by 
    case when quantity is null then 0 else 1 end,
    quantity desc;


/* You’re using boolean expressions in ORDER BY to control where NULLs go. In SQL Server:

The expression quantity IS NULL returns 1 (true) when quantity is NULL, and 0 (false) otherwise.

When you sort ASC (the default), 0 comes before 1. When you sort DESC, 1 comes before 0.

So:

select price, quantity from people order by quantity is null, quantity desc;

Interpreted as:

ORDER BY (quantity IS NULL) ASC, quantity DESC */

select * from sys.fn_helpcollations();
select first_name from people order by first_name COLLATE Latin1_General_100_CS_AI_SC_UTF8;
SELECT SERVERPROPERTY('Collation');
SELECT first_name FROM people ORDER BY first_name COLLATE Latin1_General_BIN2;

select * from
         (select top(6) price,first_name 
         from people order by 
         case when price is null then 1 else 0 end, 
         price desc) 
as top_prod order by first_name;


SELECT id, first_name
FROM people
ORDER BY first_name desc OFFSET 5 rows 
    fetch next 10 rows only;

SELECT top(20) id, first_name
FROM people
ORDER BY first_name desc;

select * from people order by newid();

select first_name , last_name ,status from people
    order by case status
    when 'urgent' then 1
    when 'high' then 2
    when 'normal' then 3
    else 4
end;




