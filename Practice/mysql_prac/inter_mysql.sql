
create table test_int(
    id int primary key auto_increment ,
    active tinyint not null,
    ageid smallint zerofill default 0,
    days mediumint,
    rankk bigint
) auto_increment = 10 ;
set @auto_increment_increment =  1;

desc test_int;

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

select * from test_int;

update test_int
    set days = case
        when id = 10 then ageid*365
        WHEN id = 11 THEN ageid * 365
        WHEN id = 12 THEN ageid * 365
        WHEN id = 13 THEN ageid * 365
        else days
    end
where id < 14;

update test_int
    set days = ageid*365
    where id between 14 and 29;

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


delete from test_int where id between 11 and 32;

-- test float ---------------------------------------------------------------------------------------------------------------------------------


create table test_float(
                         id int primary key auto_increment ,
                         salary decimal(7,4) not null,
                         litre float(5),
                         pi double
) auto_increment = 10 ;
set @auto_increment_increment =  1; -- affects ALL TABLES

desc test_float;

-- INSERT INTO test_float (salary, litre, pi) VALUES
                                               -- (1234.5678, 10.5, 3.14159265),
                                               -- (2345.6789, 20.2, 3.14), (3456.7890, 15.75, 3.1415),
-- [22001][1264] Data truncation: Out of range value for column 'salary' at row 1 .. total = 7 digits , points 4

alter table test_float
    modify salary decimal(10,4);

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
INSERT INTO test_float (salary, litre, pi)
    VALUES (123.4567, 12.3, 3.141592653589793238462643383279);
-- inserted BUT TRUNCATED
INSERT INTO test_float (salary, litre, pi)
    VALUES (123.4567, 12.3, 3.1415926535897932384625555555555555555555555555555555555555555555643383279);
-- inserted BUT TRUNCATED

-- test_text ----------------------------------------------------------------------------------------------------------------------------------

create table test_text(
    id int primary key,
    desp tinytext,
    name varchar(120),
    article text,
    synopsys mediumtext,
    book longtext
);


-- Step 2: Insert large content using REPEAT()
INSERT INTO test_text (id, desp, name, article, synopsys, book)
VALUES (
           4,
           REPEAT('A', 255),           -- max TINYTEXT
           'Example Book',
           REPEAT('B', 65535),         -- max TEXT (64 KB)
           REPEAT('C', 16777215),      -- max MEDIUMTEXT (16 MB)
           REPEAT('D', 1000000)        -- 1 MB of LONGTEXT (for demo; can go up to 4GB)
       );

select * from test_text;

-- test binary ---------------------------------------------------------------------------------------------------
create table test_blob(
    id int primary key auto_increment,
    img tinyblob,
    file blob,
    vid mediumblob,
    lec longblob
);

INSERT INTO test_blob (img, file, vid, lec)
VALUES (
           LOAD_FILE('/home/sahil/SQL_scripts/Practice/1046720.jpg'),
           LOAD_FILE('/home/sahil/binLL.c'),
           LOAD_FILE('/home/sahil/.cache/.fr-5HYES2/System/Resources/Komorebi/aerial_mountain_and_ocean/video.mp4'),
           LOAD_FILE('/home/sahil/ai_nexus_classes/classes/AWS - O - 29.01.2025 - Class (15).mp4')
       );
select * from test_blob;
select img from test_blob where id = 1;
-- select convert (file using utf8) from test_blob where id = 1;
select length(img) from test_blob;

-- LIKE ----------------------------------------------------------------------------------------------------------

select * from AI_models;
select * FROM AI_models where name like '%n%';
select * from AI_models where desp like '%less%';
select * from AI_models where desp like '%more%';
select * from AI_models where desp like 'Meta%';
-- not right way select desp from AI_models where desp like 'Meta's%';

-- SELECT "test", "'test'", "''test''", "te""st";
SELECT 'test', '"test"', '""test""', 'te''st';
-- SELECT "They've found this tutorial to be helpful";
SELECT 'They\'ve found this tutorial to be helpful';
SELECT 'They\'ve responded, "We found this tutorial helpful"'; --  a string containing this ' will recognize the backslash as an instruction to cancel out the single quote’s syntactical meaning and instead insert it into the string as an apostrophe.

SELECT HEX(desp), desp FROM AI_models where ai_id in (359,364); -- BINARY LEVEL INSPECTION
-- Your MySQL `LIKE` query failed because it searched for a straight ASCII apostrophe (`'`), but the actual data in the `desp` column uses a Unicode curly apostrophe (`’`), so the pattern didn't match—`'Meta's%'` ≠ `'Meta’s%'` due to the character encoding difference between the two apostrophes.
-- Make sure you are using the correct curly apostrophe ’ (U+2019), not the straight ASCII one '.
SELECT * FROM AI_models
WHERE REPLACE(desp, '’', '''') LIKE '%Meta''s%';
SELECT * FROM AI_models
WHERE REPLACE(desp, '’', '''') LIKE '%Meta\'s%';
select * from AI_models where desp like 'Meta\'s%'; -- not saved

-- temporary col --------------------------------------------------------------------------------------------------------------------------------------
select ai_id, name , parameters , parameters*1000 as param from AI_models;
select parameters*1000 as param , ai_id-350 as sr_no , name as AI from AI_models;
-- OpenAI is estimated to be earning around $23,000 per minute so $33,120,000 per day.
select (curdate() - release_date)*33120 as dailyK_earning_of_AI from AI_models;
-- lets say 5 days halt for maintenance so
select (AI_models.days_since_release - 5)*33120 as finalearnings from AI_models;
alter table AI_models
    add dailyK_earning_of_AI int;
update AI_models
    set AI_models.dailyK_earning_of_AI = (curdate() - release_date)*33120;

-- null -----------------------------------------------------------------------------------------------------------------------------------------------------------
select * from AI_models where desp is not null;
alter table AI_models
    add column nill int;
select * from AI_models where nill is not null;

-- insert into AI_models(nill) values (null),(890),(766),(6787);
UPDATE AI_models
    set nill = null
where ai_id between 351 and 357;

UPDATE AI_models
    set nill = 77
where ai_id > 357;

select * from AI_models where nill is null;

-- datalength change ----------------------------------------------------------------------------------------------------------------------------------------------
desc AI_models;
-- lets change namet to varchar(200)
alter table AI_models
    modify name varchar(200);
desc AI_models;

-- SQL FUCNTIONS -------------------------------------------------------------------------------------------------------------------------------------------------

select * from test_int;

update test_int
set days = ageid*365
where id >= 34;

select max(id) - (33-10) as no_of_ppl ,
       sum(active) as total_active ,
       max(ageid) - min(ageid) - avg(ageid) as deviation,
       max(ageid) as oldest ,
       min(rankk) as first ,
       avg(days) as avgdays,
       count(distinct id) as ppl,
       count(distinct(ageid)) as diff_ageppl
       from test_int;

-- select id from test_float top(10); -- mssql
select id from test_float limit 3; -- MYSQL

-- order clause ---------------------------------------------------------------------------------------------------------------------------------------------

-- Table
CREATE TABLE people (
                        id INT PRIMARY KEY,
                        first_name VARCHAR(100) NOT NULL,
                        last_name VARCHAR(100) NOT NULL,
                        age INT NULL,
                        price DECIMAL(10,2) NULL,
                        quantity INT NULL,
                        status VARCHAR(20) NULL,
                        category VARCHAR(20) NULL,
                        created_at DATETIME NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data (22 rows)
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES
                                                                                                       (1,'Alice','Zimmer',30,19.99,2,'normal','A','2024-01-01 09:00:00'),
                                                                                                       (2,'alice','zimmer',22,19.99,5,'high','A','2024-01-02 10:00:00'),
                                                                                                       (3,'Álvaro','Núñez',35,5.00,20,'urgent','B','2024-01-03 11:00:00'),
                                                                                                       (4,'Bob','Anderson',40,NULL,NULL,NULL,'B','2024-01-04 12:00:00'),
                                                                                                       (5,'BOB','anderson',NULL,29.95,1,'normal','B','2024-01-05 13:00:00'),
                                                                                                       (6,'Chloé','Brontë',28,10.00,10,'high','C','2024-01-06 14:00:00'),
                                                                                                       (7,'Chloe','Bronte',28,10.00,10,'urgent','C','2024-01-07 15:00:00'),
                                                                                                       (8,'Dmitri','Ivanov',31,100.00,0,'normal','C','2024-01-08 16:00:00'),
                                                                                                       (9,'Émile','Zola',52,1.00,100,'high','D','2024-01-09 17:00:00'),
                                                                                                       (10,'Emile','Zola',52,1.00,90,'normal','D','2024-01-10 18:00:00'),
                                                                                                       (11,'Fatima','al-Zahra',26,7.77,13,'urgent','D','2024-01-11 19:00:00'),
                                                                                                       (12,'George','O’Malley',33,15.50,3,NULL,'E','2024-01-12 20:00:00'),
                                                                                                       (13,'Hélène','D’Arcy',NULL,50.00,2,'high','E','2024-01-13 21:00:00'),
                                                                                                       (14,'Helene','DArcy',29,50.00,2,'normal','E','2024-01-14 22:00:00'),
                                                                                                       (15,'Ivan','Petrov',41,99.99,1,'urgent','F','2024-01-15 23:00:00'),
                                                                                                       (16,'Ivy','petrov',41,0.00,100,'normal','F','2024-01-16 09:00:00'),
                                                                                                       (17,'José','García',34,12.34,4,'high','F','2024-01-17 09:30:00'),
                                                                                                       (18,'Jose','Garcia',34,12.34,4,NULL,'G','2024-01-18 10:00:00'),
                                                                                                       (19,'Lars','Ångström',NULL,8.88,11,'normal','G','2024-01-19 11:00:00'),
                                                                                                       (20,'Márta','Németh',25,3.33,NULL,'urgent','G','2024-01-20 12:00:00'),
                                                                                                       (21,'Marta','Nemeth',25,3.33,1,'high','H','2024-01-21 13:00:00'),
                                                                                                       (22,'Zoë','Quinn',19,200.00,1,'normal','H','2024-01-22 14:00:00');


select * from people;
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES
                                                                                                       (1001,'Alice','Zimmer',NULL,25.00, NULL,'high','B','2024-02-01 09:00:00'),
                                                                                                       (1002,'alice','zimmer',27, NULL, 3, NULL, 'C','2024-02-02 10:10:00'),
                                                                                                       (1003,'Álvaro','Núñez',NULL,7.50, 5, 'normal','A','2024-02-03 11:20:00'),
                                                                                                       (1004,'Bob','Anderson',38, 12.00, NULL,'urgent','C','2024-02-04 12:30:00'),
                                                                                                       (1005,'BOB','anderson',42, NULL, 2, 'high', 'D','2024-02-05 13:40:00'),
                                                                                                       (1006,'Chloé','Brontë',NULL, 9.99, 1, 'normal','E','2024-02-06 14:50:00'),
                                                                                                       (1007,'Chloe','Bronte',31, NULL, NULL,'high', 'E','2024-02-07 15:55:00'),
                                                                                                       (1008,'Dmitri','Ivanov',NULL,120.00,2, NULL, 'F','2024-02-08 16:05:00'),
                                                                                                       (1009,'Émile','Zola', 50, NULL, 80, 'urgent','A','2024-02-09 17:15:00'),
                                                                                                       (1010,'Emile','Zola', NULL, 2.00, NULL,'high', 'B','2024-02-10 18:25:00'),
                                                                                                       (1011,'Fatima','al-Zahra',NULL,6.66, 10, 'normal','G','2024-02-11 19:35:00'),
                                                                                                       (1012,'George','O’Malley',35, NULL, 4, 'urgent','H','2024-02-12 20:45:00'),
                                                                                                       (1013,'Hélène','D’Arcy',27, NULL, NULL,'normal','A','2024-02-13 21:55:00'),
                                                                                                       (1014,'Helene','DArcy', NULL, 55.00, 3, NULL, 'C','2024-02-14 22:05:00'),
                                                                                                       (1015,'Ivan','Petrov', 39, NULL, 2, 'high', 'D','2024-02-15 23:15:00'),
                                                                                                       (1016,'Ivy','petrov', NULL, 1.00, NULL,'urgent','E','2024-02-16 09:05:00'),
                                                                                                       (1017,'José','García', NULL, 14.00, 6, NULL, 'F','2024-02-17 09:35:00'),
                                                                                                       (1018,'Jose','Garcia', 36, NULL, 5, 'normal','G','2024-02-18 10:10:00'),
                                                                                                       (1019,'Lars','Ångström',35, 9.99, NULL,'high', 'H','2024-02-19 11:20:00'),
                                                                                                       (1020,'Márta','Németh', NULL, NULL, 2, 'normal','A','2024-02-20 12:30:00'),
                                                                                                       (1021,'Marta','Nemeth', 26, 4.44, NULL,'urgent','B','2024-02-21 13:40:00'),
                                                                                                       (1022,'Zoë','Quinn', NULL, 150.00,2, NULL, 'C','2024-02-22 14:50:00');
select * from people;

create index sort_indx on people(price, first_name , last_name , quantity); -- basic for sorting in mysql

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


select price , quantity from people order by quantity is null , quantity desc;
select price , quantity from people order by people.quantity is null desc , quantity desc;

/* You’re using boolean expressions in ORDER BY to control where NULLs go. In SQL Server:

The expression quantity IS NULL returns 1 (true) when quantity is NULL, and 0 (false) otherwise.

When you sort ASC (the default), 0 comes before 1. When you sort DESC, 1 comes before 0.

So:

select price, quantity from people order by quantity is null, quantity desc;

Interpreted as:

ORDER BY (quantity IS NULL) ASC, quantity DESC */

show collation ;
select people.first_name from people order by people.first_name;
select people.first_name from people order by people.first_name collate utf8mb4_general_ci;


SHOW VARIABLES LIKE 'collation_server';
SHOW VARIABLES LIKE 'character_set_server';

select people.first_name from people order by people.first_name collate utf8mb4_bin;

select * from
             ( select price , first_name from people
               order by price is null ,
               price desc limit 6)
as top_prod order by first_name;

SELECT id, first_name
FROM people
ORDER BY first_name desc
LIMIT 10 OFFSET 5;

SELECT id, first_name
FROM people
ORDER BY first_name desc
LIMIT 20;

/* KEYSET PAGINATION IF OFFSET >> 100
2. Keyset Pagination (Seek Method)
SELECT id, name
FROM products
WHERE name > 'Zebra-1000000'  -- last name from previous page
ORDER BY name ASC
LIMIT 10; */


select * from people order by rand();

select first_name , last_name ,status from people
    order by case status
    when 'urgent' then 1
    when 'high' then 2
    when 'normal' then 3
    else 4
end;

select first_name , last_name ,status from people
order by case 3
             when 'urgent' then 11
             when 'high' then 22
             when 'normal' then 33
             else 44
             end ,
    3 desc;

select people.status,people.first_name,people.last_name
    from people order by field(status,'urgent','high','normal'); -- null first


select people.status,people.first_name,people.last_name
from people order by field(status,'urgent','high','normal') = 0, -- WORKS
                     field(status,'urgent','high','normal');

select people.status,people.first_name,people.last_name
from people order by field(status,'urgent','high','normal') is not null,
                     field(status,'urgent','high','normal'); -- every value is either 0,1,2,3 so no nulls so no use

select people.status,people.first_name,people.last_name
from people order by field(status,'urgent','high','normal') is not null,-- every value is either 0,1,2,3 so no nulls so no use
                     field(status,'urgent','high','normal');


-- group by ---------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE employees (
                           employee_id INT AUTO_INCREMENT PRIMARY KEY,
                           first_name VARCHAR(50),
                           last_name VARCHAR(50),
                           department VARCHAR(50),
                           role VARCHAR(50),
                           location VARCHAR(50),
                           salary DECIMAL(10,2),
                           hire_date DATE
);

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
    group by joining_year
    order by joining_year;

SELECT department, role, COUNT(*) AS count_role
FROM employees
GROUP BY department, role
ORDER BY department, role;

select employees.department , employees.role , sum(employees.salary) as salarypool
    from employees
    group by department , role with rollup ;

select sum(salarypool) as salarypool
    from (SELECT department, sum(salary) AS salarypool
    FROM employees
    GROUP BY department, role
    ORDER BY department) as role_salary
group by department; -- no compplete grand total

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


/*select employees.department , role , sum(employees.salary) as salarypool
    from employees
    group by grouping sets(
    (department , role),
    (department),
    ()
    );*/ -- no grouping sets

/*select employees.department , employees.role
    from employees
    group by cube (department , role);*/ -- no cube

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

-- JOINS --------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE emp (
                     emp_id INT PRIMARY KEY AUTO_INCREMENT,
                     name VARCHAR(100) NOT NULL,
                     email VARCHAR(100) UNIQUE,
                     mgr_id INT,
                     dept_id INT,
                     salary DECIMAL(10,2),
                     hire_dt DATE,
                     FOREIGN KEY (mgr_id) REFERENCES emp(emp_id)
);

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


CREATE TABLE departments (
                             department_id INT PRIMARY KEY AUTO_INCREMENT,
                             department_name VARCHAR(100) NOT NULL,
                             location VARCHAR(100),
                             budget DECIMAL(12,2)
);


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


CREATE TABLE customers (
                           customer_id INT PRIMARY KEY AUTO_INCREMENT,
                           customer_name VARCHAR(100) NOT NULL,
                           email VARCHAR(100) UNIQUE,
                           phone VARCHAR(20),
                           city VARCHAR(50),
                           registration_date DATE
);

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


CREATE TABLE products (
                          product_id INT PRIMARY KEY AUTO_INCREMENT,
                          product_name VARCHAR(100) NOT NULL,
                          category VARCHAR(50),
                          price DECIMAL(10,2),
                          stock_quantity INT DEFAULT 0
);

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



CREATE TABLE orders (
                        order_id INT PRIMARY KEY AUTO_INCREMENT,
                        customer_id INT,
                        product_id INT,
                        employee_id INT,
                        quantity INT DEFAULT 1,
                        order_date DATE,
                        total_amount DECIMAL(10,2),
                        FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
                        FOREIGN KEY (product_id) REFERENCES products(product_id),
                        FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

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

/* select emp_id , name , emp.dept_id , order_id , order_date
    from emp full outer join orders
    on emp.emp_id = orders.employee_id; */  -- not supported

select emp_id , name , emp.dept_id , order_id , order_date
from emp left join orders
on emp.emp_id = orders.employee_id -- same result as union no new emps in orders

union all

select emp_id , name , emp.dept_id , order_id , order_date
from emp right join orders
on emp.emp_id = orders.employee_id
where emp.emp_id is null;

select emp_id , name , emp.dept_id , order_id , order_date
from emp cross join orders
on emp.emp_id = orders.employee_id; -- Problem: CROSS JOIN cannot have an ON condition. This will throw a syntax error.


select emp_id , name , emp.dept_id , order_id , order_date
from emp cross join orders;

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
         left join emp as b
                    on a.mgr_id = b.emp_id

union all  -- FULL OUTER

select a.emp_id , a.name , b.name
from emp as a
         right join emp as b
                    on a.mgr_id = b.emp_id
where a.emp_id is null;



select a.emp_id , a.name , b.name
from emp as a
         cross join emp as b
                    on a.mgr_id = b.emp_id; -- CROSS -- same ans without null no other comb possible anyway

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

-- JOIN-based alternatives:

-- METHOD 1: Using LEFT JOIN to count relationships
SELECT DISTINCT s1.student_id
FROM student_games s1
         LEFT JOIN student_games s2 ON s1.student_id = s2.student_id AND s1.game_id != s2.game_id
         LEFT JOIN student_games s3 ON s1.student_id = s3.student_id AND s1.game_id != s3.game_id AND s2.game_id != s3.game_id
WHERE s3.student_id IS NULL;


-- METHOD 2: Using correlated subquery with EXISTS (MySQL compatible)
SELECT DISTINCT s1.student_id
FROM student_games s1
WHERE NOT EXISTS (
    SELECT 1
    FROM student_games s2, student_games s3, student_games s4
    WHERE s2.student_id = s1.student_id
      AND s3.student_id = s1.student_id
      AND s4.student_id = s1.student_id
      AND (s2.game_id != s3.game_id OR (s2.game_id IS NULL AND s3.game_id IS NOT NULL) OR (s2.game_id IS NOT NULL AND s3.game_id IS NULL))
      AND (s2.game_id != s4.game_id OR (s2.game_id IS NULL AND s4.game_id IS NOT NULL) OR (s2.game_id IS NOT NULL AND s4.game_id IS NULL))
      AND (s3.game_id != s4.game_id OR (s3.game_id IS NULL AND s4.game_id IS NOT NULL) OR (s3.game_id IS NOT NULL AND s4.game_id IS NULL))
);

-- METHOD 3: More practical - using window functions (MySQL 8.0+)
SELECT student_id
FROM (
         SELECT student_id,
                ROW_NUMBER() OVER (PARTITION BY student_id ORDER BY game_id) as rn
         FROM student_games
     ) ranked
GROUP BY student_id
HAVING MAX(rn) < 3;

-- METHOD 4: Self join with counting logic (most readable)
-- CORRECTED METHOD 4:
SELECT DISTINCT s1.student_id  -- Add DISTINCT here
FROM student_games s1
WHERE s1.student_id NOT IN (
    SELECT DISTINCT s2.student_id
    FROM student_games s2
             JOIN student_games s3 ON s2.student_id = s3.student_id AND s2.game_id != s3.game_id
             JOIN student_games s4 ON s2.student_id = s4.student_id AND s2.game_id != s4.game_id AND s3.game_id != s4.game_id
    WHERE s4.student_id IS NOT NULL
);
-- For the second query: SELECT * FROM student_games where student_id=201
-- Join equivalent (though overkill for this simple case):

-- METHOD 1: Self join with DISTINCT
-- Option 3: Simpler approach using subquery count
SELECT DISTINCT s1.*
FROM student_games s1
WHERE (
          SELECT COUNT(*)
          FROM student_games s2
          WHERE s2.student_id = s1.student_id
      ) < 3
ORDER BY s1.student_id, s1.game_id;
-- ----------------------------------------------------------------------------------------------------------------

select products.product_id , orders.order_id , emp.emp_id
    from products left join orders on orders.product_id = products.product_id
    left join emp on orders.employee_id = emp.emp_id;

select products.product_id , orders.order_id , emp.emp_id
from products right join orders on orders.product_id = products.product_id
              left join emp on orders.employee_id = emp.emp_id;

-- ranks -------------------------------------------------------------------------------------------------------------------------------------------------


-- MySQL
CREATE TABLE sales_data (
                            sale_id INT PRIMARY KEY AUTO_INCREMENT,
                            sale_date DATE NOT NULL,
                            salesperson_id INT,
                            product_category VARCHAR(50),
                            sale_amount DECIMAL(10,2) NOT NULL,
                            quantity_sold INT,
                            region VARCHAR(50)
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
                                                                     (7, 'Golf', 'A', DATE '2024-04-01', 45.00),
                                                                     (8, 'Hotel', 'B', DATE '2024-04-10', 510.10),
                                                                     (9, 'India', 'C', DATE '2024-04-22', 180.00),
                                                                     (10, 'Juliet', 'A', DATE '2024-05-01', 270.30),
                                                                     (1, 'Alpha', 'A', DATE '2024-01-10', 100.00),
                                                                     (2, 'Bravo', 'A', DATE '2024-01-11', 150.50),
                                                                     (3, 'Charlie', 'B', DATE '2024-02-01', 75.25),
                                                                     (4, 'Delta', 'B', DATE '2024-02-15', 220.00),
                                                                     (5, 'Echo', 'C', DATE '2024-03-05', 90.00),
                                                                     (6, 'Foxtrot', 'C', DATE '2024-03-20', 310.75);


select * from sample_data order by id;

-- evaluating dup records using partition by -----------------------------------------------------------------------------------------------------------------
-- - Keep row detail while adding group-level metrics, unlike GROUP BY which collapses rows.
with cte as (
    select id ,
           row_number() over (partition by id,name,category,created_at,amount) as sr_no
    from sample_data
)
select * , count(sr_no) as no_of_enteries from cte group by id order by sr_no;

select id ,
       row_number() over (partition by id,name,category,created_at,amount) as sr_no
from sample_data ;


with cte as (
    select id ,
           row_number() over (partition by id,name,category,created_at,amount) as sr_no
    from sample_data
)
select id , max(sr_no) as total_enteries from cte where cte.sr_no > 1 group by id;

/*




-- Query 1: Detect duplicates with row numbers (All databases same)
WITH cte AS (
    SELECT id,
           name,
           category,
           created_at,
           amount,
           ROW_NUMBER() OVER (PARTITION BY id, name, category, created_at, amount) AS sr_no
    FROM sample_data
)
SELECT * FROM cte ORDER BY id, sr_no;

-- Query 2: Count entries per unique combination
-- MySQL & PostgreSQL
WITH cte AS (
    SELECT id,
           ROW_NUMBER() OVER (PARTITION BY id, name, category, created_at, amount) AS sr_no
    FROM sample_data
)
SELECT id,
       COUNT(sr_no) AS no_of_entries
FROM cte
GROUP BY id
ORDER BY id;

-- SQL Server (same as above - works identically)

-- Query 3: Find only duplicate records (simplified version)
-- All Databases
WITH cte AS (
    SELECT id,
           name,
           category,
           created_at,
           amount,
           ROW_NUMBER() OVER (PARTITION BY id, name, category, created_at, amount) AS sr_no
    FROM sample_data
)
SELECT id,
       MAX(sr_no) AS total_entries
FROM cte
WHERE sr_no > 1
GROUP BY id;

-- ==============================================
-- ENHANCED DUPLICATE DETECTION QUERIES
-- ==============================================

-- Query 4: Complete duplicate analysis (All databases)
WITH duplicate_analysis AS (
    SELECT id,
           name,
           category,
           created_at,
           amount,
           ROW_NUMBER() OVER (PARTITION BY id, name, category, created_at, amount) AS row_num,
           COUNT(*) OVER (PARTITION BY id, name, category, created_at, amount) AS duplicate_count
    FROM sample_data
)
SELECT *,
       CASE
           WHEN duplicate_count > 1 THEN 'Duplicate'
           ELSE 'Unique'
       END AS duplicate_status
FROM duplicate_analysis
ORDER BY id, row_num;

-- Query 5: Category-wise analysis with window functions
SELECT id,
       name,
       category,
       amount,
       -- Ranking within category
       ROW_NUMBER() OVER (PARTITION BY category ORDER BY amount DESC) AS cat_rank,
       RANK() OVER (PARTITION BY category ORDER BY amount DESC) AS cat_rank_with_ties,
       DENSE_RANK() OVER (PARTITION BY category ORDER BY amount DESC) AS cat_dense_rank,
       -- Running totals within category
       SUM(amount) OVER (PARTITION BY category ORDER BY created_at ROWS UNBOUNDED PRECEDING) AS running_total,
       -- Average within category
       AVG(amount) OVER (PARTITION BY category) AS category_avg,
       -- Compare to category average
       amount - AVG(amount) OVER (PARTITION BY category) AS diff_from_avg
FROM sample_data
ORDER BY category, amount DESC;

-- ==============================================
-- ADVANCED WINDOW FUNCTION EXAMPLES
-- ==============================================

-- Query 6: Time-series analysis with LAG/LEAD
SELECT id,
       name,
       category,
       created_at,
       amount,
       -- Previous and next values
       LAG(amount) OVER (ORDER BY created_at) AS prev_amount,
       LEAD(amount) OVER (ORDER BY created_at) AS next_amount,
       -- Difference from previous
       amount - LAG(amount) OVER (ORDER BY created_at) AS amount_change,
       -- Moving average (3-row window)
       AVG(amount) OVER (ORDER BY created_at ROWS 2 PRECEDING) AS moving_avg_3
FROM sample_data
ORDER BY created_at;

-- Query 7: Percentile and distribution analysis
SELECT id,
       name,
       category,
       amount,
       -- Overall percentiles
       PERCENT_RANK() OVER (ORDER BY amount) AS overall_percentile,
       CUME_DIST() OVER (ORDER BY amount) AS cumulative_distribution,
       NTILE(4) OVER (ORDER BY amount) AS quartile,
       -- Category percentiles
       PERCENT_RANK() OVER (PARTITION BY category ORDER BY amount) AS category_percentile,
       NTILE(3) OVER (PARTITION BY category ORDER BY amount) AS category_tertile
FROM sample_data
ORDER BY amount DESC;

-- ==============================================
-- DATABASE-SPECIFIC OPTIMIZATIONS
-- ==============================================

-- Index recommendations (All databases)
CREATE INDEX idx_sample_category_amount ON sample_data(category, amount DESC);
CREATE INDEX idx_sample_created_at ON sample_data(created_at);
CREATE INDEX idx_sample_duplicate_check ON sample_data(id, name, category, created_at, amount);

-- ==============================================
-- PERFORMANCE COMPARISON QUERIES
-- ==============================================

-- Traditional GROUP BY approach (for comparison)
SELECT category,
       COUNT(*) AS record_count,
       SUM(amount) AS total_amount,
       AVG(amount) AS avg_amount,
       MIN(amount) AS min_amount,
       MAX(amount) AS max_amount
FROM sample_data
GROUP BY category
ORDER BY category;

-- Window function approach (preserves detail)
SELECT id,
       name,
       category,
       amount,
       COUNT(*) OVER (PARTITION BY category) AS category_count,
       SUM(amount) OVER (PARTITION BY category) AS category_total,
       AVG(amount) OVER (PARTITION BY category) AS category_avg,
       MIN(amount) OVER (PARTITION BY category) AS category_min,
       MAX(amount) OVER (PARTITION BY category) AS category_max,
       -- Show percentage of category total
       ROUND(amount * 100.0 / SUM(amount) OVER (PARTITION BY category), 2) AS pct_of_category
FROM sample_data
ORDER BY category, amount DESC;
 */

create table genders(
    id int primary key auto_increment,
    gender varchar(1)
);

insert into genders(gender) values  ('F');

SELECT * from genders;
select * , row_number() over (partition by genders.gender) as alternate from genders order by alternate;
with cte as (select * , row_number() over (partition by genders.gender) as alternate from genders )
    select * from cte order by alternate;

-- datetime---------------------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS datetime_playground;

CREATE TABLE datetime_playground (
                                     id               INT AUTO_INCREMENT PRIMARY KEY,
                                     only_date        DATE,                 -- 1000-01-01..9999-12-31 [1][5]
                                     only_time_6      TIME(6),              -- -838:59:59..838:59:59 with microseconds [1][5]
                                     dt_no_tz_6       DATETIME(6),          -- no TZ conversion, microseconds [1][12]
                                     ts_utc_6         TIMESTAMP(6),         -- UTC stored, TZ conversion on read/write [1][12][6]
                                     only_year        YEAR,                 -- typically 1901..2155 [1][5]
                                     created_ts       TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,              -- auto-init [19]
                                     updated_ts       TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP -- auto-update [19]
) ENGINE=InnoDB;

-- Typical row
INSERT INTO datetime_playground
(only_date, only_time_6, dt_no_tz_6, ts_utc_6, only_year)
VALUES
    ('2025-08-09', '23:59:59.123456', '2025-08-09 23:59:59.123456', '2025-08-09 23:59:59.123456', 2025);

-- DATE extremes
INSERT INTO datetime_playground
(only_date, only_time_6, dt_no_tz_6, ts_utc_6, only_year)
VALUES
    ('1000-01-01', '00:00:00.000000', '1000-01-01 00:00:00.000000', '1970-01-01 00:00:01.000000', 1901),
    ('9999-12-31', '23:59:59.999999', '9999-12-31 23:59:59.999999', '2038-01-19 03:14:07.999999', 2155);

-- TIME extremes (supports durations)
INSERT INTO datetime_playground
(only_date, only_time_6, dt_no_tz_6, ts_utc_6, only_year)
VALUES
    ('2024-01-01', '-838:59:59.000000', '2024-01-01 00:00:00.000000', '2024-01-01 00:00:00.000000', 2024),
    ('2024-01-02',  '838:59:59.999999', '2024-01-02 00:00:00.000000', '2024-01-02 00:00:00.000000', 2024);

-- DATETIME extremes (wide range) and microseconds
INSERT INTO datetime_playground
(only_date, only_time_6, dt_no_tz_6, ts_utc_6, only_year)
VALUES
    ('1000-01-01', '12:00:00.000001', '1000-01-01 12:00:00.000001', '1973-04-05 06:07:08.000001', 2000),
    ('9999-12-31', '12:00:00.999999', '9999-12-31 12:00:00.999999', '2030-12-31 23:59:59.999999', 2099);

-- TIMESTAMP boundary examples (range is 1970-01-01..2038-01-19)
INSERT INTO datetime_playground
(only_date, only_time_6, dt_no_tz_6, ts_utc_6, only_year)
VALUES
    ('1970-01-01', '00:00:01.000000', '1970-01-01 00:00:01.000000', '1970-01-01 00:00:01.000000', 1970),
    ('2038-01-19', '03:14:07.999999', '2038-01-19 03:14:07.999999', '2038-01-19 03:14:07.999999', 2038);

-- Offset literals (8.0.19+): DATETIME stores as-is; TIMESTAMP converts to UTC
-- Example: IST +05:30 and Pacific -07:00
INSERT INTO datetime_playground
(only_date, only_time_6, dt_no_tz_6, ts_utc_6, only_year)
VALUES
    ('2025-08-09', '05:30:00.000000',
     '2025-08-09 10:00:00+05:30',  -- stored as local value; no conversion
     '2025-08-09 10:00:00+05:30',  -- converted to UTC on storage/retrieval
     2025),
    ('2025-08-09', '07:00:00.000000',
     '2025-08-09 10:00:00-07:00',
     '2025-08-09 10:00:00-07:00',
     2025);

select * from datetime_playground;

select now() as abhi,
       curdate() as aaj,
       curtime() as rn,
       current_date as aajj,
       current_time rnn,
       current_timestamp() as justnow,
       current_timestamp(6) as justnow6;

select extract(year from now()) as rn,
       month(now()) as mahina,
       year(curdate()) as aaj,
       second(current_timestamp()) as jusnow,
       date_format(now(),'%Y-%M-%D %H:%i:%S') AS form;

select date_add(now(),interval 78 day) as add_days,
       date_add(now(),interval 4677755 second) as addsec,
       date_sub(now(),interval 89 day) as diffdays,
       timestampdiff(second,'2025-09-07',curdate()) as stampdiff,
       timestampadd(second,3600*24,now()) as add1dayy;

select str_to_date('10/08/2025 10:39:34','%d/%m/%Y %H:%i:%s') as strdate,
       date_format('2027-09-09 10:09:45','%a %b %d %Y %r') as pretty; -- 'Y' AND 'H' should be capital;

SELECT
    DATE_FORMAT(dt_no_tz_6, '%Y-%m-%d %H:00:00') AS hour_bucket, COUNT(*) AS cnt
FROM datetime_playground
GROUP BY DATE_FORMAT(dt_no_tz_6, '%Y-%m-%d %H:00:00')
ORDER BY hour_bucket;

SELECT
    DATE(ts_utc_6) AS day_bucket, COUNT(*) AS cnt
FROM datetime_playground
GROUP BY DATE(ts_utc_6)
ORDER BY day_bucket;

select @@time_zone as session_tz;
/*SELECT @@time_zone, @@system_time_zone;
select '2027-09-09 10:09:45' as input_literal,
        cast('2027-09-09 10:09:45+05:30' as datetime(6)) as datetime_used,
        cast(convert_tz('2027-09-09 10:09:45+05:30',@@session.time_zone) as timestamp()) as timestamp_used;

select version();

SELECT '2027-09-09 10:09:45' AS input_literal,
       CAST('2027-09-09 10:09:45' AS DATETIME(6)) AS datetime_used,
       CAST(convert_tz('2027-09-09 10:09:45',@@session.time_zone) AS TIMESTAMP(6)) AS timestamp_used;*/

