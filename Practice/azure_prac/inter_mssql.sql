
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

-- group by -------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE employees (
    employee_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    role VARCHAR(50),
    location VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE
);
-- Use the same INSERT statements from MySQL without AUTO_INCREMENT mention

INSERT INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES
                                                                                                 ('Alice', 'Johnson', 'Sales', 'Manager', 'New York', 90000.00, '2018-05-20'),
                                                                                                 ('Bob', 'Smith', 'Sales', 'Executive', 'New York', 60000.00, '2020-03-14'),
                                                                                                 ('Carol', 'Davis', 'Sales', 'Executive', 'London', 58000.00, '2019-11-03'),
                                                                                                 ('David', 'Brown', 'Sales', 'Analyst', 'London', 50000.00, '2021-07-12'),
                                                                                                 ('Eve', 'Miller', 'IT', 'Developer', 'New York', 75000.00, '2017-02-08'),
                                                                                                 ('Frank', 'Wilson', 'IT', 'Developer', 'London', 72000.00, '2019-09-25'),
                                                                                                 ('Grace', 'Moore', 'IT', 'Manager', 'New York', 95000.00, '2016-08-18'),
                                                                                                 ('Hank', 'Taylor', 'IT', 'Analyst', 'London', 68000.00, '2021-01-05'),
                                                                                                 ('Ivy', 'Anderson', 'HR', 'Manager', 'London', 88000.00, '2015-04-11'),
                                                                                                 ('Jack', 'Thomas', 'HR', 'Executive', 'New York', 55000.00, '2022-06-30'),
                                                                                                 ('Karen', 'Jackson', 'HR', 'Analyst', 'London', 53000.00, '2020-08-09'),
                                                                                                 ('Leo', 'White', 'Finance', 'Manager', 'New York', 98000.00, '2017-10-02'),
                                                                                                 ('Mia', 'Harris', 'Finance', 'Executive', 'London', 64000.00, '2019-12-17'),
                                                                                                 ('Nina', 'Martin', 'Finance', 'Analyst', 'New York', 62000.00, '2021-04-20'),
                                                                                                 ('Oscar', 'Garcia', 'Finance', 'Analyst', 'London', 61000.00, '2022-01-15'),
                                                                                                 ('Paul', 'Martinez', 'IT', 'Developer', 'New York', 78000.00, '2018-09-27'),
                                                                                                 ('Quinn', 'Robinson', 'Sales', 'Manager', 'London', 91000.00, '2016-06-06'),
                                                                                                 ('Ruth', 'Clark', 'Sales', 'Executive', 'London', 59000.00, '2020-10-18'),
                                                                                                 ('Sam', 'Rodriguez', 'Finance', 'Executive', 'New York', 65000.00, '2019-07-13'),
                                                                                                 ('Tina', 'Lewis', 'HR', 'Executive', 'London', 54000.00, '2021-11-04'),
                                                                                                 ('Uma', 'Lee', 'Finance', 'Manager', 'London', 97000.00, '2015-12-29'),
                                                                                                 ('Victor', 'Walker', 'IT', 'Analyst', 'New York', 70000.00, '2019-01-21'),
                                                                                                 ('Wendy', 'Hall', 'Sales', 'Analyst', 'New York', 52000.00, '2020-09-10'),
                                                                                                 ('Xavier', 'Allen', 'IT', 'Developer', 'London', 76000.00, '2021-06-19'),
                                                                                                 ('Yara', 'Young', 'Finance', 'Executive', 'New York', 66000.00, '2018-03-15'),
                                                                                                 ('Zane', 'King', 'HR', 'Analyst', 'New York', 51000.00, '2022-04-25'),
                                                                                                 ('Adam', 'Scott', 'Finance', 'Manager', 'New York', 99000.00, '2016-07-22'),
                                                                                                 ('Bella', 'Green', 'IT', 'Manager', 'London', 94000.00, '2017-05-11'),
                                                                                                 ('Chris', 'Adams', 'Sales', 'Executive', 'New York', 61000.00, '2019-02-28');


INSERT INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES
-- Seattle
('Alice', 'Ford', 'Engineering', 'Developer', 'Seattle', 78000.00, '2021-03-15'),
('Brian', 'Chase', 'Engineering', 'Developer', 'Seattle', 81000.00, '2020-07-21'),
('Cindy', 'Liu', 'Engineering', 'Manager', 'Seattle', 95000.00, '2019-11-04'),
('David', 'Kim', 'Marketing', 'Specialist', 'Seattle', 62000.00, '2022-05-18'),

-- Miami
('Evelyn', 'Ross', 'Engineering', 'Developer', 'Miami', 72000.00, '2021-08-09'),
('Frank', 'Hall', 'Engineering', 'QA Engineer', 'Miami', 65000.00, '2020-12-02'),
('Grace', 'Patel', 'HR', 'Recruiter', 'Miami', 59000.00, '2023-01-10'),
('Henry', 'Adams', 'Finance', 'Analyst', 'Miami', 69000.00, '2020-04-25'),

-- Austin
('Isabel', 'Grant', 'Finance', 'Analyst', 'Austin', 71000.00, '2019-06-17'),
('Jack', 'Ward', 'Finance', 'Manager', 'Austin', 95000.00, '2021-02-28'),
('Karen', 'Webb', 'Engineering', 'Developer', 'Austin', 78000.00, '2022-09-14'),
('Leo', 'Turner', 'Marketing', 'Specialist', 'Austin', 63000.00, '2023-04-07'),

-- Boston
('Mia', 'Scott', 'Marketing', 'Manager', 'Boston', 87000.00, '2018-10-12'),
('Nathan', 'Brooks', 'Engineering', 'Developer', 'Boston', 75000.00, '2020-06-19'),
('Olivia', 'Price', 'Engineering', 'QA Engineer', 'Boston', 64000.00, '2021-12-05'),
('Peter', 'Long', 'HR', 'Manager', 'Boston', 85000.00, '2019-03-30'),

-- Denver
('Quincy', 'James', 'Engineering', 'Developer', 'Denver', 77000.00, '2021-05-22'),
('Rachel', 'West', 'Finance', 'Analyst', 'Denver', 70000.00, '2022-08-15'),
('Samuel', 'Clark', 'Finance', 'Manager', 'Denver', 94000.00, '2020-01-09'),
('Tina', 'Edwards', 'Marketing', 'Specialist', 'Denver', 65000.00, '2023-06-03'),

-- Chicago
('Uma', 'Khan', 'Engineering', 'Developer', 'Chicago', 79000.00, '2020-09-27'),
('Victor', 'Bell', 'Engineering', 'Manager', 'Chicago', 96000.00, '2019-02-14'),
('Wendy', 'Young', 'Finance', 'Analyst', 'Chicago', 72000.00, '2021-11-11'),
('Xavier', 'Ross', 'HR', 'Recruiter', 'Chicago', 60000.00, '2022-07-20');


select * from employees;

select employees.department ,
    count(employees.department) as total_dept
    from employees
    group by department;-- all non aggree cols must be group by

select employees.role ,
    count(employees.role) as total_roles
    from employees
GROUP BY role;

select employees.department ,
       count(employees.department) as total_dept,
       employees.role ,
       count(employees.role) as total_roles
from employees
group by department , role;-- all non aggree cols must be group by

select department , max(salary)
    from employees
    where location in ('London','New York','Chicago','Seattle')
    group by department
    having avg(salary) > 60000.00
    order by department;

SELECT department, role, COUNT(*) AS count_role
FROM employees
GROUP BY department, role
ORDER BY department, role;

select year(employees.hire_date) as joining_year ,
    count(*) as hire_count
    from employees
    group by year(hire_date)
    order by joining_year;

SELECT department, role, COUNT(*) AS count_role
FROM employees
GROUP BY department, role
ORDER BY department, role;

select employees.department , employees.role , sum(employees.salary) as salarypool
    from employees
    group by department , role with rollup ;

SELECT SUM(salarypool) AS salarypool
FROM (
    SELECT department, role, SUM(salary) AS salarypool
    FROM employees
    GROUP BY department, role
) AS role_salary;


-- Simulating GROUPING SETS in MySQL
SELECT department, role, SUM(salary) AS salarypool
FROM employees
GROUP BY department, role

UNION ALL

SELECT department, NULL AS roles, SUM(salary) AS salarypool
FROM employees
GROUP BY department

UNION ALL

SELECT NULL AS department, NULL AS roles, SUM(salary) AS salarypool
FROM employees;

select department , role , sum(salary) as salarypool
	from employees
	group by cube(department , role)
	order by department , role , salarypool;

select department , role , sum(salary) as salarypool
	from employees
	group by grouping sets(
		(department,role),
		(department),
		()
	);
/*
Alright — let’s break down exactly how

```sql
SELECT department, role, SUM(salary) AS salarypool
FROM employees
GROUP BY GROUPING SETS (
    (department, role),
    (department),
    ()
);
```

works, step-by-step.

---

## **1️⃣ GROUPING SETS — what’s the idea?**

Normally in SQL:

```sql
GROUP BY department, role
```

gives **one fixed grouping** — you get sums per `(department, role)` pair only.

**`GROUPING SETS`** says:

> "I want **multiple** groupings in one query — and union them into a single result set."

Here, we have **three grouping sets**:

1. `(department, role)` → detailed breakdown
2. `(department)` → subtotal per department (role ignored)
3. `()` → grand total (all rows together)

---

## **2️⃣ Step-by-step execution flow**

Let’s imagine a small table:

| department | role      | salary |
| ---------- | --------- | ------ |
| Sales      | Manager   | 5000   |
| Sales      | Executive | 3000   |
| HR         | Manager   | 4000   |
| HR         | Clerk     | 2000   |

---

### **Step A — First grouping set `(department, role)`**

SQL engine groups **by both columns**:

```
Sales, Manager   → 5000
Sales, Executive → 3000
HR, Manager      → 4000
HR, Clerk        → 2000
```

---

### **Step B — Second grouping set `(department)`**

Now SQL engine ignores `role` and groups only by `department`:

```
Sales → 5000 + 3000 = 8000
HR    → 4000 + 2000 = 6000
```

---

### **Step C — Third grouping set `()`**

No columns → **all rows together**:

```
Grand total → 5000 + 3000 + 4000 + 2000 = 14000
```

---

### **Step D — Combine results**

SQL **UNION ALL**-style merges all rows into one result:

| department | role      | salarypool |               |
| ---------- | --------- | ---------- | ------------- |
| Sales      | Manager   | 5000       |               |
| Sales      | Executive | 3000       |               |
| HR         | Manager   | 4000       |               |
| HR         | Clerk     | 2000       |               |
| Sales      | NULL      | 8000       | ← subtotal    |
| HR         | NULL      | 6000       | ← subtotal    |
| NULL       | NULL      | 14000      | ← grand total |

---

## **3️⃣ How NULLs appear**

* When a column is **not in the current grouping set**, its value is `NULL` in the output.
* These NULLs aren’t “real data NULLs” — they mean *“this column is aggregated over all values”*.

---

## **4️⃣ Why it’s useful**

Without `GROUPING SETS`, you’d have to run **three separate queries** (detailed, subtotal, total) and `UNION` them manually. This does all in **one scan** of the table — much faster.

---

If you want, I can **draw you a visual flowchart** showing how SQL runs each grouping set and merges the results — that’s the clearest way to “see” it happen.
Do you want me to make that?
*/

-- DISTINCT VS GROUP BY
SELECT count(DISTINCT employees.department) as distict_dept FROM employees;
select sum(dept) as dept from (select count(*) as dept from employees group by employees.department) as total_dept ;

-- JOINS --------------------------------------------------------------------------------------------------------------------------------------------------------

-- Create departments table first (referenced by emp table)
CREATE TABLE departments (
    department_id INT IDENTITY(1,1) PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    budget DECIMAL(12,2)
);

-- Insert departments data
INSERT INTO departments (department_name, location, budget) VALUES
('Engineering', 'New York', 500000.00),
('Sales', 'Chicago', 300000.00),
('Marketing', 'Los Angeles', 200000.00),
('HR', 'New York', 150000.00),
('Finance', 'Boston', 250000.00),
('IT Support', 'Austin', 180000.00),
('Operations', 'Seattle', 220000.00),
('Research', 'San Francisco', 400000.00),
('Customer Service', 'Miami', 120000.00),
('Legal', 'Washington DC', 180000.00);

-- Create emp table with self-referencing foreign key
CREATE TABLE emp (
    emp_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    mgr_id INT,
    dept_id INT,
    salary DECIMAL(10,2),
    hire_dt DATE,
    FOREIGN KEY (mgr_id) REFERENCES emp(emp_id),
    FOREIGN KEY (dept_id) REFERENCES departments(department_id)
);

-- Insert emp data
INSERT INTO emp (name, email, mgr_id, dept_id, salary, hire_dt) VALUES
('John Smith', 'john.smith@company.com', NULL, 1, 95000.00, '2020-01-15'),
('Sarah Johnson', 'sarah.johnson@company.com', 1, 1, 75000.00, '2020-03-20'),
('Mike Davis', 'mike.davis@company.com', 1, 1, 70000.00, '2021-05-10'),
('Emma Wilson', 'emma.wilson@company.com', NULL, 2, 80000.00, '2019-08-12'),
('David Brown', 'david.brown@company.com', 4, 2, 65000.00, '2021-02-18'),
('Lisa Garcia', 'lisa.garcia@company.com', 4, 2, 62000.00, '2022-01-05'),
('Robert Taylor', 'robert.taylor@company.com', NULL, 3, 85000.00, '2020-11-30'),
('Jennifer Lee', 'jennifer.lee@company.com', 7, 3, 58000.00, '2021-09-15'),
('Michael Wang', 'michael.wang@company.com', NULL, 4, 90000.00, '2018-06-01'),
('Amanda Clark', 'amanda.clark@company.com', 9, 4, 55000.00, '2022-03-10');

-- Create customers table
CREATE TABLE customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    city VARCHAR(50),
    registration_date DATE
);

-- Insert customers data
INSERT INTO customers (customer_name, email, phone, city, registration_date) VALUES
('Alice Cooper', 'alice.cooper@email.com', '555-0101', 'New York', '2023-01-15'),
('Bob Martinez', 'bob.martinez@email.com', '555-0102', 'Los Angeles', '2023-02-20'),
('Carol White', 'carol.white@email.com', '555-0103', 'Chicago', '2023-03-10'),
('Daniel Kim', 'daniel.kim@email.com', '555-0104', 'Houston', '2023-04-05'),
('Eva Rodriguez', 'eva.rodriguez@email.com', '555-0105', 'Phoenix', '2023-05-12'),
('Frank Thompson', 'frank.thompson@email.com', '555-0106', 'Philadelphia', '2023-06-18'),
('Grace Chen', 'grace.chen@email.com', '555-0107', 'San Antonio', '2023-07-22'),
('Henry Johnson', 'henry.johnson@email.com', '555-0108', 'San Diego', '2023-08-30'),
('Iris Patel', 'iris.patel@email.com', '555-0109', 'Dallas', '2023-09-14'),
('Jack Wilson', 'jack.wilson@email.com', '555-0110', 'Austin', '2023-10-25');

-- Create products table
CREATE TABLE products (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock_quantity INT DEFAULT 0
);

-- Insert products data
INSERT INTO products (product_name, category, price, stock_quantity) VALUES
('Laptop Pro 15"', 'Electronics', 1299.99, 50),
('Wireless Mouse', 'Electronics', 29.99, 200),
('Office Chair', 'Furniture', 199.99, 30),
('Standing Desk', 'Furniture', 399.99, 15),
('Coffee Mug', 'Office Supplies', 12.99, 100),
('Notebook Set', 'Office Supplies', 8.99, 150),
('Smartphone', 'Electronics', 699.99, 75),
('Tablet 10"', 'Electronics', 329.99, 60),
('Desk Lamp', 'Furniture', 45.99, 40),
('Pen Set', 'Office Supplies', 15.99, 120);

-- Create orders table
CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    product_id INT,
    employee_id INT,
    quantity INT DEFAULT 1,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (employee_id) REFERENCES emp(emp_id)
);

-- Insert orders data
INSERT INTO orders (customer_id, product_id, employee_id, quantity, order_date, total_amount) VALUES
(1, 1, 5, 1, '2024-01-10', 1299.99),
(2, 7, 6, 1, '2024-01-15', 699.99),
(3, 3, 5, 2, '2024-01-20', 399.98),
(1, 2, 6, 3, '2024-02-01', 89.97),
(4, 4, 5, 1, '2024-02-05', 399.99),
(5, 5, 6, 5, '2024-02-10', 64.95),
(2, 8, 5, 1, '2024-02-15', 329.99),
(6, 6, 6, 10, '2024-03-01', 89.90),
(7, 9, 5, 2, '2024-03-10', 91.98),
(3, 10, 6, 4, '2024-03-15', 63.96);

select name , department_name
    from emp inner join departments on
    emp.dept_id = departments.department_id;
select * from emp;
select * from departments; -- INNER JOIN

select departments.department_name , emp.name
    from departments left join emp
    on departments.department_id = emp.dept_id; -- LEFT JOIN

select orders.order_date , orders.total_amount, customers.customer_id , customers.customer_name , customers.city
    from orders right join customers
    on customers.customer_id = orders.customer_id; -- RIGHT JOIN

select orders.order_date , orders.total_amount, customers.customer_id , customers.customer_name , customers.city
    from orders full outer join customers
    on customers.customer_id = orders.customer_id; -- RIGHT JOIN

/*select emp_id , name , emp.dept_id , order_id , order_date
from emp cross join orders
on emp.emp_id = orders.employee_id; -- Problem: CROSS JOIN cannot have an ON condition. This will throw a syntax error.*/


select emp_id , name , emp.dept_id , order_id , order_date
from emp cross join orders


/*
 -- Returns every employee paired with every order
-- 10 employees × 10 orders = 100 rows
-- No relationship filtering - pure Cartesian product
 **Exactly right!**

CROSS JOIN has **no condition**, that's why there are **no NULLs**.

**The logic:**
- **CROSS JOIN** = No filtering condition → Every row from table1 combines with every row from table2
- **No condition** = No "matching" or "non-matching" concept
- **No matching concept** = No reason to insert NULLs for "missing" data

**Other joins create NULLs because they have conditions:**

```sql
-- LEFT JOIN has a condition
FROM emp LEFT JOIN orders ON emp.emp_id = orders.employee_id
-- When condition fails → NULL for orders columns

-- CROSS JOIN has no condition
FROM emp CROSS JOIN orders
-- No condition to fail → No NULLs needed
```

**Simple way to remember:**
- **Condition exists** → Can fail → NULLs possible
- **No condition** → Nothing to fail → No NULLs

**CROSS JOIN just says:** "Give me every employee with every order, no questions asked!"

So you get:
- Employee 1 + Order 1
- Employee 1 + Order 2
- Employee 1 + Order 3
- ...
- Employee 10 + Order 10

**100 complete rows, no NULLs from the join operation.**

You nailed the concept! 🎯
 */
select * from emp;
select a.emp_id , a.name , b.name
from emp as a
         inner join emp as b
                    on a.mgr_id = b.emp_id; -- INNER



select a.emp_id , a.name , b.name
from emp as a
         left join emp as b
                    on a.mgr_id = b.emp_id; -- LEFT



select a.emp_id , a.name , b.name
from emp as a
         right join emp as b
                    on a.mgr_id = b.emp_id; -- RIGHT


select a.emp_id , a.name , b.name
from emp as a
         full outer join emp as b
                    on a.mgr_id = b.emp_id -- FULL OUTER
                

/*select a.emp_id , a.name , b.name
from emp as a
         cross join emp as b
                    on a.mgr_id = b.emp_id; -- CROSS -- same ans without null no other comb possible anyway*/

select a.emp_id , a.name , b.name
from emp as a
         cross join emp as b; -- CROSS

/*
 **Not exactly!**

Self join is **broader** than just inner join.

**Self join = Any join where table1 = table2**

You can do self joins with **any** join type:

```sql
-- Self INNER JOIN
FROM emp a INNER JOIN emp b ON a.mgr_id = b.emp_id

-- Self LEFT JOIN
FROM emp a LEFT JOIN emp b ON a.mgr_id = b.emp_id

-- Self RIGHT JOIN
FROM emp a RIGHT JOIN emp b ON a.mgr_id = b.emp_id

-- Self CROSS JOIN
FROM emp a CROSS JOIN emp b
```

**More accurate:**
- **Self join** = Concept of joining table to itself
- **INNER JOIN** = Type of join (only matching rows)
- **Self INNER JOIN** = Joining table to itself + only matching rows

**Example differences:**

```sql
-- Self INNER JOIN: Only employees WITH managers
SELECT a.name, b.name as manager
FROM emp a JOIN emp b ON a.mgr_id = b.emp_id;
-- Result: 6 rows (excludes John, Emma, Robert, Michael)

-- Self LEFT JOIN: ALL employees, managers where available
SELECT a.name, b.name as manager
FROM emp a LEFT JOIN emp b ON a.mgr_id = b.emp_id;
-- Result: 10 rows (includes NULLs for employees without managers)
```

**So the formula is:**
**Self join = Same table used twice**
**Join type = INNER/LEFT/RIGHT/CROSS determines the behavior**

Self join ≠ Inner join, but **Self Inner Join = Inner Join on same table** 🎯

 **Execution sequence of the SQL statement:**

```sql
select a.emp_id , a.name , b.name
from emp as a
         inner join emp as b
                    on a.mgr_id = b.emp_id;
```

**Logical Processing Order:**

1. **FROM emp as a**
   - Load the first instance of emp table, alias it as 'a'

2. **INNER JOIN emp as b**
   - Load the second instance of emp table, alias it as 'b'
   - Prepare for join operation

3. **ON a.mgr_id = b.emp_id**
   - Apply join condition
   - For each row in 'a', find matching rows in 'b' where mgr_id = emp_id
   - Keep only rows that satisfy the condition (INNER JOIN behavior)

4. **SELECT a.emp_id, a.name, b.name**
   - Project the specified columns from the joined result set
   - Return emp_id and name from table 'a', name from table 'b'

**What happens internally:**
```
Step 1: FROM emp as a        → Load employees as 'a'
Step 2: INNER JOIN emp as b  → Load employees as 'b'
Step 3: ON condition         → Match where a.mgr_id = b.emp_id
Step 4: SELECT columns       → Project requested columns
```

**Result:** Only employees who have managers (mgr_id is not NULL and matches an existing emp_id) will be returned with their manager's name.

**Note:** Query optimizer may physically execute in different order for performance, but logical result follows this sequence.
 */

select * from emp as a , emp as b
    where a.mgr_id = b.emp_id; -- without join

-- Create student_games table
CREATE TABLE student_games (
                               student_id INT,
                               game_id INT
);

-- Insert sample data
-- Students playing only 1 game
INSERT INTO student_games (student_id, game_id) VALUES (101, 1);
INSERT INTO student_games (student_id, game_id) VALUES (102, 2);
INSERT INTO student_games (student_id, game_id) VALUES (103, 3);

-- Students playing exactly 2 games
INSERT INTO student_games (student_id, game_id) VALUES (201, 1);
INSERT INTO student_games (student_id, game_id) VALUES (201, 2);
INSERT INTO student_games (student_id, game_id) VALUES (202, 2);
INSERT INTO student_games (student_id, game_id) VALUES (202, 3);

-- Students playing more than 3 games
INSERT INTO student_games (student_id, game_id) VALUES (301, 1);
INSERT INTO student_games (student_id, game_id) VALUES (301, 2);
INSERT INTO student_games (student_id, game_id) VALUES (301, 3);
INSERT INTO student_games (student_id, game_id) VALUES (301, 4);
INSERT INTO student_games (student_id, game_id) VALUES (302, 1);
INSERT INTO student_games (student_id, game_id) VALUES (302, 2);
INSERT INTO student_games (student_id, game_id) VALUES (302, 3);
INSERT INTO student_games (student_id, game_id) VALUES (302, 4);
INSERT INTO student_games (student_id, game_id) VALUES (302, 5);

-- Students with NULL game_id (registered but not assigned games)
INSERT INTO student_games (student_id, game_id) VALUES (401, NULL);
INSERT INTO student_games (student_id, game_id) VALUES (402, NULL);

-- View all data
SELECT * FROM student_games ORDER BY student_id, game_id;

select student_games.student_id
from student_games
group by student_id
having count(*) < 3;
SELECT * FROM student_games where student_games.student_id=201 ORDER BY student_id, game_id;


-- claude ---
-- Original GROUP BY + HAVING solution
SELECT student_id
FROM student_games
GROUP BY student_id
HAVING COUNT(*) < 3;

-- View all data
SELECT * FROM student_games ORDER BY student_id, game_id;

-- QUERIES:

-- 1. Count games per student
SELECT student_id, COUNT(game_id) as games_count
FROM student_games 
GROUP BY student_id
ORDER BY student_id;

-- 2. Students playing only 1 game
SELECT student_id, COUNT(game_id) as games_count
FROM student_games 
WHERE game_id IS NOT NULL
GROUP BY student_id 
HAVING COUNT(game_id) = 1;

-- 3. Students playing exactly 2 games
SELECT student_id, COUNT(game_id) as games_count
FROM student_games 
WHERE game_id IS NOT NULL
GROUP BY student_id 
HAVING COUNT(game_id) = 2;

-- 4. Students playing more than 3 games
SELECT student_id, COUNT(game_id) as games_count
FROM student_games 
WHERE game_id IS NOT NULL
GROUP BY student_id 
HAVING COUNT(game_id) > 3;

-- 5. Students with NULL games (no games assigned)
SELECT student_id
FROM student_games 
WHERE game_id IS NULL;

-- 6. Students with their game list (comma separated)
-- ✅ CORRECT MS SQL Server version
SELECT student_id, STRING_AGG(CAST(game_id AS VARCHAR(10)), ', ') as games_list
FROM student_games 
WHERE game_id IS NOT NULL
GROUP BY student_id;

-- 7. Game participation summary
SELECT 
    student_id,
    COUNT(game_id) as total_games,
    CASE 
        WHEN COUNT(game_id) = 0 THEN 'No Games'
        WHEN COUNT(game_id) = 1 THEN 'Single Game'
        WHEN COUNT(game_id) = 2 THEN 'Two Games'
        WHEN COUNT(game_id) > 3 THEN 'Multiple Games (3+)'
        ELSE 'Few Games'
    END as participation_level
FROM student_games 
GROUP BY student_id
ORDER BY total_games DESC, student_id;

-- 8. Most popular games
SELECT game_id, COUNT(student_id) as student_count
FROM student_games 
WHERE game_id IS NOT NULL
GROUP BY game_id 
ORDER BY student_count DESC;

-- 9. Students playing specific game (example: game_id = 1)
SELECT DISTINCT student_id
FROM student_games 
WHERE game_id = 1;

-- 10. Total unique students and games
SELECT 
    COUNT(DISTINCT student_id) as total_students,
    COUNT(DISTINCT game_id) as total_games
FROM student_games;

select products.product_id , orders.order_id , emp.emp_id
from products left join orders on orders.product_id = products.product_id
left join emp on orders.employee_id = emp.emp_id;

select products.product_id , orders.order_id , emp.emp_id
from products right join orders on orders.product_id = products.product_id
              left join emp on orders.employee_id = emp.emp_id;

-- More readable equivalent of Query 2
select products.product_id, orders.order_id, emp.emp_id
from orders left join products on orders.product_id = products.product_id
            left join emp on orders.employee_id = emp.emp_id;

-- ranks ---------------------------------------------------------------------------------------------------------------------------------------------
-- SQL Server
CREATE TABLE sales_data (
    sale_id INT IDENTITY(1,1) PRIMARY KEY,
    sale_date DATE NOT NULL,
    salesperson_id INT,
    product_category NVARCHAR(50),
    sale_amount DECIMAL(10,2) NOT NULL,
    quantity_sold INT,
    region NVARCHAR(50)
);

-- Universal table structure (works for all databases)
CREATE TABLE student_grades (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    subject VARCHAR(50) NOT NULL,
    grade DECIMAL(5,2) NOT NULL,
    exam_date DATE NOT NULL,
    semester VARCHAR(20),
    credit_hours INT
);

INSERT INTO student_grades VALUES
(1, 'Emma Wilson', 'Mathematics', 92.5, '2024-05-15', 'Spring 2024', 3),
(2, 'Liam Chen', 'Mathematics', 88.0, '2024-05-15', 'Spring 2024', 3),
(3, 'Sophie Rodriguez', 'Physics', 95.0, '2024-05-20', 'Spring 2024', 4),
(4, 'Mason Kim', 'Chemistry', 87.5, '2024-05-18', 'Spring 2024', 3),
(5, 'Ava Patel', 'Mathematics', 91.0, '2024-05-15', 'Spring 2024', 3),
(6, 'Noah Johnson', 'Physics', 89.5, '2024-05-20', 'Spring 2024', 4),
(7, 'Isabella Brown', 'Chemistry', 93.0, '2024-05-18', 'Spring 2024', 3),
(8, 'Ethan Davis', 'Mathematics', 85.5, '2024-05-15', 'Spring 2024', 3),
(9, 'Mia Garcia', 'Physics', 90.0, '2024-05-20', 'Spring 2024', 4),
(10, 'James Martinez', 'Biology', 88.5, '2024-05-22', 'Spring 2024', 4),
(11, 'Charlotte Lee', 'Chemistry', 94.5, '2024-05-18', 'Spring 2024', 3),
(12, 'Benjamin Taylor', 'Mathematics', 86.0, '2024-05-15', 'Spring 2024', 3),
(13, 'Amelia Anderson', 'Biology', 92.0, '2024-05-22', 'Spring 2024', 4),
(14, 'Lucas Thompson', 'Physics', 87.0, '2024-05-20', 'Spring 2024', 4),
(15, 'Harper White', 'Chemistry', 90.5, '2024-05-18', 'Spring 2024', 3),
(16, 'Alexander Harris', 'Biology', 89.0, '2024-05-22', 'Spring 2024', 4),
(17, 'Evelyn Clark', 'Mathematics', 93.5, '2024-05-15', 'Spring 2024', 3),
(18, 'Michael Lewis', 'Physics', 91.5, '2024-05-20', 'Spring 2024', 4),
(19, 'Abigail Walker', 'Biology', 87.5, '2024-05-22', 'Spring 2024', 4),
(20, 'William Hall', 'Chemistry', 92.0, '2024-05-18', 'Spring 2024', 3);

-- Insert sales data (20 rows)
INSERT INTO sales_data (sale_date, salesperson_id, product_category, sale_amount, quantity_sold, region) VALUES
('2024-01-15', 1, 'Electronics', 25000.00, 50, 'North'),
('2024-01-16', 2, 'Clothing', 18000.00, 120, 'South'),
('2024-01-17', 3, 'Electronics', 32000.00, 40, 'East'),
('2024-01-18', 1, 'Books', 8000.00, 200, 'North'),
('2024-01-19', 4, 'Electronics', 45000.00, 75, 'West'),
('2024-01-20', 2, 'Clothing', 22000.00, 80, 'South'),
('2024-01-21', 5, 'Books', 12000.00, 150, 'East'),
('2024-01-22', 3, 'Electronics', 38000.00, 60, 'East'),
('2024-01-23', 1, 'Clothing', 16000.00, 90, 'North'),
('2024-01-24', 6, 'Books', 9000.00, 180, 'West'),
('2024-01-25', 4, 'Electronics', 41000.00, 65, 'West'),
('2024-01-26', 2, 'Clothing', 24000.00, 100, 'South'),
('2024-01-27', 5, 'Books', 11000.00, 220, 'East'),
('2024-01-28', 7, 'Electronics', 29000.00, 45, 'North'),
('2024-01-29', 3, 'Clothing', 19000.00, 75, 'East'),
('2024-01-30', 6, 'Books', 13000.00, 160, 'West'),
('2024-01-31', 1, 'Electronics', 35000.00, 55, 'North'),
('2024-02-01', 4, 'Clothing', 21000.00, 85, 'West'),
('2024-02-02', 7, 'Books', 10000.00, 190, 'North'),
('2024-02-03', 2, 'Electronics', 39000.00, 70, 'South');


select * from student_grades;
select * from sales_data;

select sales_data.product_category , quantity_sold , sales_data.sale_amount , row_number()
        over (order by quantity_sold desc) as sr_no from sales_data;

select  student_name, subject , grade , rank()
        over (order by grade desc) as sr_no from student_grades;


select  student_name, subject , grade , rank()
        over (partition by student_grades.subject order by grade desc) as sr_no from student_grades;

select student_grades.student_name , grade , student_grades.subject,
    row_number() over (partition by student_grades.subject order by grade desc,student_grades.student_name) as sr_no,
    rank() over (partition by student_grades.subject order by grade desc,student_grades.student_name) as rankk,
    dense_rank() over (partition by student_grades.subject order by grade desc,student_grades.student_name) as dense
from student_grades;

with cte as (
    select name ,
           salary ,
           emp.dept_id ,
           row_number() over (partition by dept_id order by salary desc) as dept_top3
    from emp
) select dept_id , name , salary from cte where dept_top3 <= 2;

-- First insert managers (no mgr_id reference)
INSERT INTO emp (name, email, mgr_id, dept_id, salary, hire_dt) VALUES
                                                                    ('John CEO', 'john.ceo@company.com', NULL, 1, 150000.00, '2015-01-01'),
                                                                    ('Sarah VP Eng', 'sarah.vp@company.com', 1, 1, 120000.00, '2016-03-15'),
                                                                    ('Mike VP Sales', 'mike.vp@company.com', 1, 2, 120000.00, '2016-06-20'),
                                                                    ('Lisa VP HR', 'lisa.vp@company.com', 1, 3, 115000.00, '2017-02-10'),
                                                                    ('David Dir Eng', 'david.dir@company.com', 2, 1, 95000.00, '2017-08-15'),
                                                                    ('Emma Dir Sales', 'emma.dir@company.com', 3, 2, 95000.00, '2018-01-20'),
                                                                    ('Robert Dir HR', 'robert.dir@company.com', 4, 3, 90000.00, '2018-05-10');

-- Then insert employees with manager references and LOTS of salary duplicates
INSERT INTO emp (name, email, mgr_id, dept_id, salary, hire_dt) VALUES
                                                                    ('Alice Johnson', 'alice.j@company.com', 5, 1, 85000.00, '2019-03-15'),
                                                                    ('Bob Smith', 'bob.s@company.com', 5, 1, 85000.00, '2019-07-22'),
                                                                    ('Carol Davis', 'carol.d@company.com', 6, 2, 75000.00, '2020-01-10'),
                                                                    ('Frank Miller', 'frank.m@company.com', 5, 1, 85000.00, '2019-11-30'),
                                                                    ('Grace Taylor', 'grace.t@company.com', 7, 3, 65000.00, '2020-08-12'),
                                                                    ('Henry Anderson', 'henry.a@company.com', 6, 2, 75000.00, '2021-06-18'),
                                                                    ('Ivy Thomas', 'ivy.t@company.com', 5, 1, 90000.00, '2018-04-03'),
                                                                    ('Jack Jackson', 'jack.j@company.com', 6, 2, 70000.00, '2020-12-01'),
                                                                    ('Karen White', 'karen.w@company.com', 6, 2, 75000.00, '2019-03-25'),
                                                                    ('Liam Harris', 'liam.h@company.com', 7, 3, 65000.00, '2021-09-07'),
                                                                    ('Mia Clark', 'mia.c@company.com', 5, 1, 85000.00, '2020-05-20'),
                                                                    ('Noah Lewis', 'noah.l@company.com', 6, 2, 70000.00, '2022-01-15'),
                                                                    ('Olivia Walker', 'olivia.w@company.com', 6, 2, 75000.00, '2019-10-08'),
                                                                    ('Paul Hall', 'paul.h@company.com', 5, 1, 90000.00, '2018-12-12'),
                                                                    ('Quinn Young', 'quinn.y@company.com', 7, 3, 60000.00, '2021-04-22'),
                                                                    ('Rachel King', 'rachel.k@company.com', 6, 2, 70000.00, '2020-07-14'),
                                                                    ('Sam Wright', 'sam.w@company.com', 6, 2, 70000.00, '2021-11-03'),
                                                                    ('Tina Lopez', 'tina.l@company.com', 5, 1, 85000.00, '2019-02-28'),
                                                                    ('Uma Patel', 'uma.p@company.com', 7, 3, 65000.00, '2020-11-05'),
                                                                    ('Victor Chen', 'victor.c@company.com', 5, 1, 90000.00, '2021-03-18'),
                                                                    ('Wendy Kim', 'wendy.k@company.com', 6, 2, 75000.00, '2021-08-22'),
                                                                    ('Xavier Brown', 'xavier.b@company.com', 7, 3, 60000.00, '2022-02-14'),
                                                                    ('Yuki Tanaka', 'yuki.t@company.com', 5, 1, 85000.00, '2022-05-30');

INSERT INTO sales_data (sale_date, salesperson_id, product_category, sale_amount, quantity_sold, region) VALUES
                                                                                                             ('2024-01-15', 1, 'Electronics', 25000.00, 100, 'North'),
                                                                                                             ('2024-01-16', 2, 'Clothing', 18000.00, 75, 'South'),
                                                                                                             ('2024-01-17', 3, 'Electronics', 32000.00, 100, 'East'),
                                                                                                             ('2024-01-18', 1, 'Books', 8000.00, 50, 'North'),
                                                                                                             ('2024-01-19', 4, 'Electronics', 45000.00, 150, 'West'),
                                                                                                             ('2024-01-20', 2, 'Clothing', 22000.00, 75, 'South'),
                                                                                                             ('2024-01-21', 5, 'Books', 12000.00, 50, 'East'),
                                                                                                             ('2024-01-22', 3, 'Electronics', 38000.00, 100, 'East'),
                                                                                                             ('2024-01-23', 1, 'Clothing', 16000.00, 75, 'North'),
                                                                                                             ('2024-01-24', 6, 'Books', 9000.00, 25, 'West'),
                                                                                                             ('2024-01-25', 4, 'Electronics', 41000.00, 150, 'West'),
                                                                                                             ('2024-01-26', 2, 'Clothing', 24000.00, 100, 'South'),
                                                                                                             ('2024-01-27', 5, 'Books', 11000.00, 50, 'East'),
                                                                                                             ('2024-01-28', 7, 'Electronics', 29000.00, 100, 'North'),
                                                                                                             ('2024-01-29', 3, 'Clothing', 19000.00, 75, 'East'),
                                                                                                             ('2024-01-30', 6, 'Books', 13000.00, 25, 'West'),
                                                                                                             ('2024-01-31', 1, 'Electronics', 35000.00, 150, 'North'),
                                                                                                             ('2024-02-01', 4, 'Clothing', 21000.00, 75, 'West'),
                                                                                                             ('2024-02-02', 7, 'Books', 10000.00, 25, 'North'),
                                                                                                             ('2024-02-03', 2, 'Electronics', 39000.00, 150, 'South'),
                                                                                                             ('2024-02-04', 5, 'Clothing', 20000.00, 100, 'East'),
                                                                                                             ('2024-02-05', 3, 'Books', 14000.00, 50, 'East'),
                                                                                                             ('2024-02-06', 6, 'Electronics', 33000.00, 100, 'West'),
                                                                                                             ('2024-02-07', 1, 'Clothing', 17000.00, 75, 'North'),
                                                                                                             ('2024-02-08', 4, 'Books', 12500.00, 25, 'West'),
                                                                                                             ('2024-02-09', 7, 'Electronics', 31000.00, 150, 'North'),
                                                                                                             ('2024-02-10', 2, 'Clothing', 23000.00, 100, 'South'),
                                                                                                             ('2024-02-11', 5, 'Books', 15000.00, 50, 'East'),
                                                                                                             ('2024-02-12', 3, 'Electronics', 37000.00, 150, 'East'),
                                                                                                             ('2024-02-13', 6, 'Clothing', 18500.00, 75, 'West');



INSERT INTO student_grades VALUES
-- Rows 21-50 (with explicit student_id starting from 21)
(21, 'Emma Wilson', 'Mathematics', 92.5, '2024-05-15', 'Spring 2024', 3),
(22, 'Liam Chen', 'Mathematics', 88.0, '2024-05-15', 'Spring 2024', 3),
(23, 'Sophie Rodriguez', 'Physics', 95.0, '2024-05-20', 'Spring 2024', 4),
(24, 'Mason Kim', 'Chemistry', 87.5, '2024-05-18', 'Spring 2024', 3),
(25, 'Ava Patel', 'Mathematics', 92.5, '2024-05-15', 'Spring 2024', 3),      -- Duplicate 92.5
(26, 'Noah Johnson', 'Physics', 89.5, '2024-05-20', 'Spring 2024', 4),
(27, 'Isabella Brown', 'Chemistry', 87.5, '2024-05-18', 'Spring 2024', 3),   -- Duplicate 87.5
(28, 'Ethan Davis', 'Mathematics', 88.0, '2024-05-15', 'Spring 2024', 3),    -- Duplicate 88.0
(29, 'Mia Garcia', 'Physics', 95.0, '2024-05-20', 'Spring 2024', 4),         -- Duplicate 95.0
(30, 'James Martinez', 'Biology', 90.0, '2024-05-22', 'Spring 2024', 4),
(31, 'Charlotte Lee', 'Chemistry', 87.5, '2024-05-18', 'Spring 2024', 3),    -- Duplicate 87.5
(32, 'Benjamin Taylor', 'Mathematics', 88.0, '2024-05-15', 'Spring 2024', 3),-- Duplicate 88.0
(33, 'Amelia Anderson', 'Biology', 90.0, '2024-05-22', 'Spring 2024', 4),    -- Duplicate 90.0
(34, 'Lucas Thompson', 'Physics', 89.5, '2024-05-20', 'Spring 2024', 4),     -- Duplicate 89.5
(35, 'Harper White', 'Chemistry', 93.0, '2024-05-18', 'Spring 2024', 3),
(36, 'Alexander Harris', 'Biology', 85.0, '2024-05-22', 'Spring 2024', 4),
(37, 'Evelyn Clark', 'Mathematics', 92.5, '2024-05-15', 'Spring 2024', 3),   -- Duplicate 92.5
(38, 'Michael Lewis', 'Physics', 95.0, '2024-05-20', 'Spring 2024', 4),      -- Duplicate 95.0
(39, 'Abigail Walker', 'Biology', 85.0, '2024-05-22', 'Spring 2024', 4),     -- Duplicate 85.0
(40, 'William Hall', 'Chemistry', 93.0, '2024-05-18', 'Spring 2024', 3),     -- Duplicate 93.0
(41, 'Grace Murphy', 'Mathematics', 88.0, '2024-05-15', 'Spring 2024', 3),   -- Duplicate 88.0
(42, 'Oliver Scott', 'Physics', 89.5, '2024-05-20', 'Spring 2024', 4),       -- Duplicate 89.5
(43, 'Lily Cooper', 'Chemistry', 87.5, '2024-05-18', 'Spring 2024', 3),      -- Duplicate 87.5
(44, 'Henry Reed', 'Biology', 90.0, '2024-05-22', 'Spring 2024', 4),         -- Duplicate 90.0
(45, 'Zoe Bailey', 'Mathematics', 92.5, '2024-05-15', 'Spring 2024', 3),     -- Duplicate 92.5
(46, 'Jack Foster', 'Physics', 95.0, '2024-05-20', 'Spring 2024', 4),        -- Duplicate 95.0
(47, 'Maya Hughes', 'Chemistry', 93.0, '2024-05-18', 'Spring 2024', 3),      -- Duplicate 93.0
(48, 'Ryan Powell', 'Biology', 85.0, '2024-05-22', 'Spring 2024', 4),        -- Duplicate 85.0
(49, 'Chloe Ward', 'Mathematics', 88.0, '2024-05-15', 'Spring 2024', 3),     -- Duplicate 88.0
(50, 'Luke Torres', 'Physics', 89.5, '2024-05-20', 'Spring 2024', 4),        -- Duplicate 89.5
-- Additional 20 rows to make it 50 total
(51, 'Aria Patel', 'Mathematics', 92.5, '2024-05-15', 'Spring 2024', 3),     -- Duplicate 92.5
(52, 'Kai Thompson', 'Physics', 95.0, '2024-05-20', 'Spring 2024', 4),       -- Duplicate 95.0
(53, 'Luna Martinez', 'Chemistry', 87.5, '2024-05-18', 'Spring 2024', 3),    -- Duplicate 87.5
(54, 'Ezra Johnson', 'Biology', 90.0, '2024-05-22', 'Spring 2024', 4),       -- Duplicate 90.0
(55, 'Nova Brown', 'Mathematics', 88.0, '2024-05-15', 'Spring 2024', 3),     -- Duplicate 88.0
(56, 'Phoenix Garcia', 'Physics', 89.5, '2024-05-20', 'Spring 2024', 4),     -- Duplicate 89.5
(57, 'River Lee', 'Chemistry', 93.0, '2024-05-18', 'Spring 2024', 3),        -- Duplicate 93.0
(58, 'Sage Wilson', 'Biology', 85.0, '2024-05-22', 'Spring 2024', 4),        -- Duplicate 85.0
(59, 'Atlas Davis', 'Mathematics', 92.5, '2024-05-15', 'Spring 2024', 3),    -- Duplicate 92.5
(60, 'Iris Chen', 'Physics', 95.0, '2024-05-20', 'Spring 2024', 4),          -- Duplicate 95.0
(61, 'Orion Kim', 'Chemistry', 87.5, '2024-05-18', 'Spring 2024', 3),        -- Duplicate 87.5
(62, 'Wren Anderson', 'Biology', 90.0, '2024-05-22', 'Spring 2024', 4),      -- Duplicate 90.0
(63, 'Felix Rodriguez', 'Mathematics', 88.0, '2024-05-15', 'Spring 2024', 3),-- Duplicate 88.0
(64, 'Stella Harris', 'Physics', 89.5, '2024-05-20', 'Spring 2024', 4),      -- Duplicate 89.5
(65, 'Jasper White', 'Chemistry', 93.0, '2024-05-18', 'Spring 2024', 3),     -- Duplicate 93.0
(66, 'Hazel Clark', 'Biology', 85.0, '2024-05-22', 'Spring 2024', 4),        -- Duplicate 85.0
(67, 'Leo Murphy', 'Mathematics', 92.5, '2024-05-15', 'Spring 2024', 3),     -- Duplicate 92.5
(68, 'Willow Scott', 'Physics', 95.0, '2024-05-20', 'Spring 2024', 4),       -- Duplicate 95.0
(69, 'Rowan Cooper', 'Chemistry', 87.5, '2024-05-18', 'Spring 2024', 3),     -- Duplicate 87.5
(70, 'Indigo Reed', 'Biology', 90.0, '2024-05-22', 'Spring 2024', 4);

select customer_id,total_amount from orders;

select orders.customer_id , sum(orders.total_amount) revenue,
       ntile(1) over (order by sum(orders.total_amount) desc) as revenue_decile
from orders
group by customer_id
order by revenue desc;

select orders.customer_id , sum(orders.total_amount) revenue,
       ntile(2) over (order by sum(orders.total_amount) desc) as revenue_decile
from orders
group by customer_id
order by revenue desc;

select orders.customer_id , sum(orders.total_amount) revenue,
       ntile(3) over (order by sum(orders.total_amount) desc) as revenue_decile
from orders
group by customer_id
order by revenue desc;

select orders.customer_id , sum(orders.total_amount) revenue,
       ntile(7) over (order by sum(orders.total_amount) desc) as revenue_decile
from orders
group by customer_id
order by revenue desc;

select orders.customer_id , sum(orders.total_amount) revenue,
       ntile(199) over (order by sum(orders.total_amount) desc) as revenue_decile
from orders
group by customer_id
order by revenue desc;

select student_grades.student_name , grade , student_grades.subject,
       row_number() over (partition by student_grades.subject order by grade desc) as sr_no,
       rank() over (partition by student_grades.subject order by grade desc) as rankk,
       dense_rank() over (partition by student_grades.subject order by grade desc) as dense,
       percent_rank() over (partition by subject order by grade)*100 as percentile,
       cume_dist() over (partition by subject order by grade desc) as c_dist
from student_grades
order by subject,sr_no;


-- partition by , window func-----------------------------------------------------------------------------------------------------------------------------

-- Create table (portable types)
CREATE TABLE sample_data (
                             id int,
                             name VARCHAR(100),
                             category VARCHAR(50),
                             created_at DATE,
                             amount DECIMAL(10,2)
);
INSERT INTO sample_data (id, name, category, created_at, amount) VALUES
(7, 'Golf', 'A', '2024-04-01', 45.00),
(8, 'Hotel', 'B', '2024-04-10', 510.10),
(9, 'India', 'C', '2024-04-22', 180.00),
(10, 'Juliet', 'A', '2024-05-01', 270.30),
(1, 'Alpha', 'A', '2024-01-10', 100.00),
(2, 'Bravo', 'A', '2024-01-11', 150.50),
(3, 'Charlie', 'B', '2024-02-01', 75.25),
(4, 'Delta', 'B', '2024-02-15', 220.00),
(5, 'Echo', 'C', '2024-03-05', 90.00),
(6, 'Foxtrot', 'C', '2024-03-20', 310.75);

select * from sample_data order by id;

-- evaluating dup records using partition by -----------------------------------------------------------------------------------------------------------------
-- - Keep row detail while adding group-level metrics, unlike GROUP BY which collapses rows.
WITH cte AS (
    SELECT id,
           name,
           category,
           created_at,
           amount,
           ROW_NUMBER() OVER (PARTITION BY id, name, category, created_at, amount order by id) AS sr_no
    FROM sample_data
)
SELECT * FROM cte ORDER BY id, sr_no;

select id ,
       row_number() over (partition by id,name,category,created_at,amount order by id ) as sr_no
from sample_data ;


with cte as (
    select id ,
           row_number() over (partition by id,name,category,created_at,amount  order by id) as sr_no
    from sample_data
)
select id , max(sr_no) as total_enteries from cte where sr_no > 1 group by id;

-- datetime--------------------------------------------------------------------------------------------------------------------------------------------------

-- Create a single table that holds every SQL Server date/time type
CREATE TABLE dbo.DateTimePlayground
(
    id                int IDENTITY(1,1) PRIMARY KEY,
    only_date         date,               -- 0001-01-01..9999-12-31 [1]
    only_time_7       time(7),            -- 100ns units, 0-7 fractional seconds [10][5]
    legacy_datetime   datetime,           -- legacy, ~3.33ms rounding [3][1][13]
    modern_dt2_7      datetime2(7),       -- modern, 0-7 fractional seconds [10]
    with_offset_7     datetimeoffset(7),  -- datetime2 + offset [-14:00..+14:00] [1]
    small_dt          smalldatetime       -- legacy, minute precision [1]
);
-- Insert a “typical” row
INSERT INTO dbo.DateTimePlayground
(
    only_date,
    only_time_7,
    legacy_datetime,
    modern_dt2_7,
    with_offset_7,
    small_dt
)
VALUES
(
    '2024-12-31',                         -- DATE [1]
    '23:59:59.1234567',                   -- TIME(7) [10][5]
    '2024-12-31 23:59:59.997',            -- DATETIME max second fraction [3]
    '2024-12-31 23:59:59.1234567',        -- DATETIME2(7) precise [10]
    '2024-12-31 23:59:59.1234567 +05:30', -- DATETIMEOFFSET(7) [1]
    '2024-12-31 23:59'                    -- SMALLDATETIME minute precision [1]
);

-- Precision/rounding check: DATETIME rounds to 0/3/7 ms; DATETIME2 preserves 7 digits
INSERT INTO dbo.DateTimePlayground
(
    only_date, only_time_7, legacy_datetime, modern_dt2_7, with_offset_7, small_dt
)
VALUES
(
    '2025-01-01',
    '00:00:00.0000001',                   -- TIME(7) tiny fraction [10][5]
    '2025-01-01 00:00:00.001',            -- will round to .000 or .003 or .007 [3][13]
    '2025-01-01 00:00:00.0000001',        -- DT2 keeps 7-digit precision [10]
    '2025-01-01 00:00:00.0000001 +00:00', -- offset-aware [1]
    '2025-01-01 00:00'
);

-- Edge/offsets: wide offset range supported in DATETIMEOFFSET [-14:00..+14:00]
-- Edge/offsets: wide offset range supported in DATETIMEOFFSET [-14:00..+14:00]
INSERT INTO dbo.DateTimePlayground
(only_date, only_time_7, legacy_datetime, modern_dt2_7, with_offset_7, small_dt)
VALUES
('0001-01-01', '12:00:00', '2000-01-01 12:00:00', '0001-01-01 12:00:00.0000000', '2000-01-01 12:00:00.0000000 -14:00', '2000-01-01 12:00'),
('9999-12-31', '12:00:00', '2020-06-15 08:30:00.123', '9999-12-31 12:00:00.9999999', '2020-06-15 08:30:00.1230000 +14:00', '2020-06-15 08:30');
INSERT INTO dbo.DateTimePlayground
(only_date, only_time_7, legacy_datetime, modern_dt2_7, with_offset_7, small_dt)
VALUES
-- DATE extremes (min/max), TIME extremes, DATETIME not applicable at 0001 (use DATETIME2 for that)
('0001-01-01', '00:00:00.0000000', '1753-01-01 00:00:00.000', '0001-01-01 00:00:00.0000000', '0001-01-01 00:00:00.0000000 +00:00', '1900-01-01 00:00'),
('9999-12-31', '23:59:59.9999999', '9999-12-31 23:59:59.997', '9999-12-31 23:59:59.9999999', '9999-12-31 23:59:59.9999999 +00:00', '2079-06-06 23:59'),

-- DATETIME lower bound and rounding edge checks
('1753-01-01', '00:00:00.0000000', '1753-01-01 00:00:00.000', '1753-01-01 00:00:00.0000000', '1753-01-01 00:00:00.0000000 +00:00', '1900-01-01 00:00'),
('2000-01-01', '12:34:56.1234567', '2000-01-01 12:34:56.001', '2000-01-01 12:34:56.0010000', '2000-01-01 12:34:56.0010000 +05:30', '2000-01-01 12:34'),
('2000-01-01', '12:34:56.1234567', '2000-01-01 12:34:56.002', '2000-01-01 12:34:56.0020000', '2000-01-01 12:34:56.0020000 -04:00', '2000-01-01 12:34'),
('2000-01-01', '12:34:56.1234567', '2000-01-01 12:34:56.003', '2000-01-01 12:34:56.0030000', '2000-01-01 12:34:56.0030000 +00:00', '2000-01-01 12:34'),

-- DATETIME upper end: max representable fraction is .997
('9999-12-31', '23:59:59.9999999', '9999-12-31 23:59:59.997', '9999-12-31 23:59:59.9999999', '9999-12-31 23:59:59.9999999 +00:00', '2079-06-06 23:59'),

-- DATETIMEOFFSET offset extremes
('2000-01-01', '00:00:00.0000000', '2000-01-01 00:00:00.000', '2000-01-01 00:00:00.0000000', '2000-01-01 00:00:00.0000000 -14:00', '2000-01-01 00:00'),
('2000-01-01', '00:00:00.0000000', '2000-01-01 00:00:00.000', '2000-01-01 00:00:00.0000000', '2000-01-01 00:00:00.0000000 +14:00', '2000-01-01 00:00'),

-- SMALLDATETIME extremes (min and max)
('1900-01-01', '00:00:00.0000000', '1900-01-01 00:00:00.000', '1900-01-01 00:00:00.0000000', '1900-01-01 00:00:00.0000000 +00:00', '1900-01-01 00:00'),
('2079-06-06', '23:59:59.9999999', '2079-06-06 23:59:59.997', '2079-06-06 23:59:59.9999999', '2079-06-06 23:59:59.9999999 +00:00', '2079-06-06 23:59');
SELECT * FROM dbo.DateTimePlayground ORDER BY id;

select GETDATE() as gd ,
       GETUTCDATE() as utc,
       SYSDATETIME() sysdt,
       SYSUTCDATETIME() as sysutc,
       SYSDATETIMEOFFSET() as offs;
       
DECLARE @d DATETIME2(7) = '2027-04-30 5:30:09.8974678';
select 
    DATEPART(year,@d) as Y,
    DATEPART(month,@d) as m,
    DATEPART(weekday,@d) AS WK,
    DATEPART(hour,@d) as HR,
    DATEPART(minute,@d) AS MINN,
    DATEPART(second,@d) AS S;

DECLARE @start datetime2(7) = '2025-01-01T00:00:00';
DECLARE @end   datetime2(7) = '2025-08-09T22:36:45.9876543';

select 
    DATEADD(day,67,@start) as addday,
    DATEADD(MONTH,55,@end) as addmonth,
    DATEADD(YEAR,9,@start) as addy,
    DATEDIFF(DAY,78,@start) as subday,
    DATEDIFF_BIG(SECOND,@start,@end) as subsec,
    datediff_big(year,@start,@end) as suby; -- datepart + sub/add

declare @any datetime2(7) = '2028-09-07T08:23:56.9785679';
select EOMONTH(@any) as eom,
    EOMONTH(@any,-1) eom_prev,
    DATEFROMPARTS(2029,09,26) as datee;

-- -- 3.5 ISO 8601 parsing (recommended to avoid regional ambiguity)
-- Use unambiguous ISO strings: 'YYYY-MM-DDTHH:MM:SS[.fffffff][Z|{+|-}HH:MM]'

select cast('2027-09-30T23:06:51.9796876' as DATETIME2(7)) as casted,
       cast('2027-09-30T23:06:51+05:30' as datetimeoffset(7)) as casted_offs; 


declare @utc DATETIME2(7) = SYSUTCDATETIME();
select todatetimeoffset(@utc,'+00:00') as utc_offs,
        SWITCHOFFSET(TODATETIMEOFFSET(@utc,'+00:00'),'+05:30') as indian_time,
        SWITCHOFFSET(SYSUTCDATETIME(),'+05:30') as indian;

/* 
112: 'YYYYMMDD'

120: 'YYYY-MM-DD HH:MI:SS' (24h)

121: 'YYYY-MM-DD HH:MI:SS.mmm' (ODBC canonical with ms)

126: 'YYYY-MM-DDTHH:MM:SS.mmm' (ISO8601; for datetime2 use SYSDATETIME then CONVERT)
*/
select convert(varchar(35),'2028-09-07T08:23:56.9785679',113) as iso;


-- 4.5 Find rows that fall in the last full calendar month
DECLARE @today date = CAST(SYSDATETIME() AS date);
DECLARE @start_last_month date = DATEADD(month, DATEDIFF(month, 0, @today) - 1, 0);
DECLARE @end_last_month   date = EOMONTH(@start_last_month);

SELECT *
FROM dbo.DateTimePlayground
WHERE only_date >= @start_last_month
  AND only_date <= @end_last_month
ORDER BY only_date; 