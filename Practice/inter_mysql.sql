
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























