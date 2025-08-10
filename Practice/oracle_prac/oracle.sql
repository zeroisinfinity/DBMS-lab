```sql
SELECT name FROM v$database;           -- Shows DB name  
SELECT username FROM all_users;       -- Lists all schemas

SELECT table_name FROM user_tables;

ALTER SESSION SET CURRENT_SCHEMA = x; --no diff database only 1 per instance u shift between shchemas

CREATE TABLE trail (
    name VARCHAR2(20),
    id NUMBER
);

INSERT INTO trail (name, id)
VALUES ('awwru', 101), ('mitch', 2);

SELECT * FROM trail;

ALTER TABLE trail
ADD city VARCHAR2(10);

SELECT * FROM trail;

ALTER TABLE trail
MODIFY city CLOB;

SELECT * FROM trail;

ALTER TABLE trail
RENAME COLUMN city TO shaher;

ALTER TABLE trail
MODIFY shaher CLOB;

SELECT * FROM trail;

ALTER TABLE trail RENAME TO detrail;

DROP TABLE trail;

DROP USER db_user CASCADE;

ALTER TABLE table_name DROP COLUMN column_name;

CREATE INDEX indx ON detrail(id);
CREATE UNIQUE INDEX u_indx ON detrail(city);
CREATE INDEX indxs ON detrail(name, id, city);

CREATE VIEW obs AS
SELECT name, id, city FROM detrail WHERE id != 0;

SELECT * FROM obs;

CREATE OR REPLACE VIEW obs AS
SELECT name FROM detrail WHERE id = 101;

SELECT * FROM obs;
-- MySQL

-- Oracle
CREATE USER sales IDENTIFIED BY password;
-- Then: (grant usage/privileges)
GRANT CONNECT, RESOURCE TO sales;

CREATE TABLE test_int (
    id NUMBER PRIMARY KEY,
    active NUMBER(3) NOT NULL,
    ageid NUMBER(5) DEFAULT 0,
    days NUMBER(5),
    rankk NUMBER(19)
);

-- Sequence for auto-increment
CREATE SEQUENCE test_int_seq START WITH 10 INCREMENT BY 1;

-- Trigger for auto-increment behavior
CREATE OR REPLACE TRIGGER trg_test_int
BEFORE INSERT ON test_int
FOR EACH ROW
BEGIN
    SELECT test_int_seq.NEXTVAL INTO :new.id FROM dual;
END;
/

-- Describe table
DESC test_int;

BEGIN
  INSERT INTO test_int (active, ageid, rankk) VALUES (1, 10, 1001);
  INSERT INTO test_int (active, ageid, rankk) VALUES (0, 11, 1002);
  INSERT INTO test_int (active, ageid, rankk) VALUES (1, 12, 1003);
  INSERT INTO test_int (active, ageid, rankk) VALUES (0, 13, 1004);
  INSERT INTO test_int (active, ageid, rankk) VALUES (1, 14, 1005);
  INSERT INTO test_int (active, ageid, rankk) VALUES (1, 15, 1006);
  INSERT INTO test_int (active, ageid, rankk) VALUES (0, 16, 1007);
  INSERT INTO test_int (active, ageid, rankk) VALUES (1, 17, 1008);
  INSERT INTO test_int (active, ageid, rankk) VALUES (0, 18, 1009);
  INSERT INTO test_int (active, ageid, rankk) VALUES (1, 19, 1010);
  INSERT INTO test_int (active, ageid, rankk) VALUES (1, 20, 1011);
  INSERT INTO test_int (active, ageid, rankk) VALUES (0, 21, 1012);
  INSERT INTO test_int (active, ageid, rankk) VALUES (1, 22, 1013);
  INSERT INTO test_int (active, ageid, rankk) VALUES (0, 23, 1014);
  INSERT INTO test_int (active, ageid, rankk) VALUES (1, 24, 1015);
  INSERT INTO test_int (active, ageid, rankk) VALUES (1, 25, 1016);
  INSERT INTO test_int (active, ageid, rankk) VALUES (0, 26, 1017);
  INSERT INTO test_int (active, ageid, rankk) VALUES (1, 27, 1018);
  INSERT INTO test_int (active, ageid, rankk) VALUES (0, 28, 1019);
  INSERT INTO test_int (active, ageid, rankk) VALUES (1, 29, 1020);
END;


UPDATE test_int
SET days = CASE 
    WHEN id = 10 THEN ageid * 365
    WHEN id = 11 THEN ageid * 365
    WHEN id = 12 THEN ageid * 365
    WHEN id = 13 THEN ageid * 365
    ELSE days
END;

UPDATE test_int
SET days = ageid * 365
WHERE id BETWEEN 14 AND 20;


-- Basic queries (Oracle converts unquoted identifiers to uppercase)
SELECT * FROM AI_MODELS;  -- or "ai_models" if created lowercase
SELECT * FROM AI_MODELS WHERE NAME LIKE '%n%';
SELECT * FROM AI_MODELS WHERE DESP LIKE '%less%';
SELECT * FROM AI_MODELS WHERE DESP LIKE '%more%';
SELECT * FROM AI_MODELS WHERE DESP LIKE 'Meta%';

-- String literals and escaping
SELECT 'test', ''test'', ''''test'''', 'te''st' FROM dual;
SELECT 'They''ve found this tutorial to be helpful' FROM dual;
SELECT 'They''ve responded, "We found this tutorial helpful"' FROM dual;

-- Oracle alternative: use q-quote for complex strings
SELECT q'[They''ve responded, "We found this tutorial helpful"]' FROM dual;

-- Case-insensitive search options
SELECT * FROM AI_MODELS WHERE UPPER(NAME) LIKE UPPER('%n%');
-- Or use REGEXP_LIKE for more complex patterns
SELECT * FROM AI_MODELS WHERE REGEXP_LIKE(NAME, 'n', 'i'); 

-- Temporary computed columns
SELECT ai_id, name, parameters, parameters*1000 AS param FROM AI_models;
SELECT parameters*1000 AS param, ai_id-350 AS sr_no, name AS AI FROM AI_models;

-- Earnings: use SYSDATE and subtracting dates gives days
SELECT (SYSDATE - release_date)*33120 AS dailyK_earning_of_AI FROM AI_models;
SELECT (days_since_release - 5)*33120 AS finalearnings FROM AI_models;

-- Persistent column and update
ALTER TABLE AI_models ADD (dailyK_earning_of_AI NUMBER);
UPDATE AI_models SET dailyK_earning_of_AI = (SYSDATE - release_date)*33120;

-- Oracle (12c and later):
SELECT id
FROM test_float
FETCH FIRST 3 ROWS ONLY;

-- Oracle (12c and later):
SELECT id
FROM test_float
FETCH FIRST 3 ROWS ONLY;

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
-- select id from test_float limit 3; -- MYSQL
select id from test_float fetch first 3 rows only; -- ORACLE

-- order clause ---------------------------------------------------------------------------------------------------------------------------------------------

-- Table
CREATE TABLE people (
                        id INT PRIMARY KEY,
                        first_name VARCHAR(100) NOT NULL,
                        last_name VARCHAR(100) NOT NULL,
                        age INT,
                        price NUMBER(10,2),
                        quantity INT,
                        status VARCHAR(20),
                        category VARCHAR(20),
                        created_at TIMESTAMP NOT NULL
);

-- Data (22 rows)
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (1,'Alice','Zimmer',30,19.99,2,'normal','A',TO_TIMESTAMP('2024-01-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (2,'alice','zimmer',22,19.99,5,'high','A',TO_TIMESTAMP('2024-01-02 10:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (3,'Álvaro','Núñez',35,5.00,20,'urgent','B',TO_TIMESTAMP('2024-01-03 11:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (4,'Bob','Anderson',40,NULL,NULL,NULL,'B',TO_TIMESTAMP('2024-01-04 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (5,'BOB','anderson',NULL,29.95,1,'normal','B',TO_TIMESTAMP('2024-01-05 13:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (6,'Chloé','Brontë',28,10.00,10,'high','C',TO_TIMESTAMP('2024-01-06 14:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (7,'Chloe','Bronte',28,10.00,10,'urgent','C',TO_TIMESTAMP('2024-01-07 15:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (8,'Dmitri','Ivanov',31,100.00,0,'normal','C',TO_TIMESTAMP('2024-01-08 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (9,'Émile','Zola',52,1.00,100,'high','D',TO_TIMESTAMP('2024-01-09 17:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (10,'Emile','Zola',52,1.00,90,'normal','D',TO_TIMESTAMP('2024-01-10 18:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (11,'Fatima','al-Zahra',26,7.77,13,'urgent','D',TO_TIMESTAMP('2024-01-11 19:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (12,'George','O’Malley',33,15.50,3,NULL,'E',TO_TIMESTAMP('2024-01-12 20:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (13,'Hélène','D’Arcy',NULL,50.00,2,'high','E',TO_TIMESTAMP('2024-01-13 21:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (14,'Helene','DArcy',29,50.00,2,'normal','E',TO_TIMESTAMP('2024-01-14 22:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (15,'Ivan','Petrov',41,99.99,1,'urgent','F',TO_TIMESTAMP('2024-01-15 23:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (16,'Ivy','petrov',41,0.00,100,'normal','F',TO_TIMESTAMP('2024-01-16 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (17,'José','García',34,12.34,4,'high','F',TO_TIMESTAMP('2024-01-17 09:30:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (18,'Jose','Garcia',34,12.34,4,NULL,'G',TO_TIMESTAMP('2024-01-18 10:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (19,'Lars','Ångström',NULL,8.88,11,'normal','G',TO_TIMESTAMP('2024-01-19 11:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (20,'Márta','Németh',25,3.33,NULL,'urgent','G',TO_TIMESTAMP('2024-01-20 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (21,'Marta','Nemeth',25,3.33,1,'high','H',TO_TIMESTAMP('2024-01-21 13:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (22,'Zoë','Quinn',19,200.00,1,'normal','H',TO_TIMESTAMP('2024-01-22 14:00:00', 'YYYY-MM-DD HH24:MI:SS'));


select * from people;
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (1001,'Alice','Zimmer',NULL,25.00, NULL,'high','B',TO_TIMESTAMP('2024-02-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (1002,'alice','zimmer',27, NULL, 3, NULL, 'C',TO_TIMESTAMP('2024-02-02 10:10:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (1003,'Álvaro','Núñez',NULL,7.50, 5, 'normal','A',TO_TIMESTAMP('2024-02-03 11:20:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (1004,'Bob','Anderson',38, 12.00, NULL,'urgent','C',TO_TIMESTAMP('2024-02-04 12:30:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (1005,'BOB','anderson',42, NULL, 2, 'high', 'D',TO_TIMESTAMP('2024-02-05 13:40:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (1006,'Chloé','Brontë',NULL, 9.99, 1, 'normal','E',TO_TIMESTAMP('2024-02-06 14:50:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (1007,'Chloe','Bronte',31, NULL, NULL,'high', 'E',TO_TIMESTAMP('2024-02-07 15:55:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (1008,'Dmitri','Ivanov',NULL,120.00,2, NULL, 'F',TO_TIMESTAMP('2024-02-08 16:05:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (1009,'Émile','Zola', 50, NULL, 80, 'urgent','A',TO_TIMESTAMP('2024-02-09 17:15:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (1010,'Emile','Zola', NULL, 2.00, NULL,'high', 'B',TO_TIMESTAMP('2024-02-10 18:25:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (1011,'Fatima','al-Zahra',NULL,6.66, 10, 'normal','G',TO_TIMESTAMP('2024-02-11 19:35:00', 'YYYY-MM-DD HH24:I:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (1012,'George','O’Malley',35, NULL, 4, 'urgent','H',TO_TIMESTAMP('2024-02-12 20:45:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (1013,'Hélène','D’Arcy',27, NULL, NULL,'normal','A',TO_TIMESTAMP('2024-02-13 21:55:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (1014,'Helene','DArcy', NULL, 55.00, 3, NULL, 'C',TO_TIMESTAMP('2024-02-14 22:05:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (1015,'Ivan','Petrov', 39, NULL, 2, 'high', 'D',TO_TIMESTAMP('2024-02-15 23:15:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (1016,'Ivy','petrov', NULL, 1.00, NULL,'urgent','E',TO_TIMESTAMP('2024-02-16 09:05:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (1017,'José','García', NULL, 14.00, 6, NULL, 'F',TO_TIMESTAMP('2024-02-17 09:35:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (1018,'Jose','Garcia', 36, NULL, 5, 'normal','G',TO_TIMESTAMP('2024-02-18 10:10:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (1019,'Lars','Ångström',35, 9.99, NULL,'high', 'H',TO_TIMESTAMP('2024-02-19 11:20:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (1020,'Márta','Németh', NULL, NULL, 2, 'normal','A',TO_TIMESTAMP('2024-02-20 12:30:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (1021,'Marta','Nemeth', 26, 4.44, NULL,'urgent','B',TO_TIMESTAMP('2024-02-21 13:40:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO people (id, first_name, last_name, age, price, quantity, status, category, created_at) VALUES (1022,'Zoë','Quinn', NULL, 150.00,2, NULL, 'C',TO_TIMESTAMP('2024-02-22 14:50:00', 'YYYY-MM-DD HH24:MI:SS'));
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


select price , quantity from people order by quantity nulls first, quantity desc;
select price , quantity from people order by quantity nulls last, quantity desc;

/* You’re using boolean expressions in ORDER BY to control where NULLs go. In SQL Server:

The expression quantity IS NULL returns 1 (true) when quantity is NULL, and 0 (false) otherwise.

When you sort ASC (the default), 0 comes before 1. When you sort DESC, 1 comes before 0.

So:

select price, quantity from people order by quantity is null, quantity desc;

Interpreted as:

ORDER BY (quantity IS NULL) ASC, quantity DESC */

-- For Oracle, you can use NULLS FIRST/NULLS LAST
select price, quantity from people order by quantity nulls first, quantity desc;


-- SHOW COLLATION; -- MySQL specific
-- select people.first_name from people order by people.first_name collate utf8mb4_general_ci; -- MySQL specific

-- To achieve case-insensitive and accent-insensitive sort in Oracle:
-- ALTER SESSION SET NLS_SORT = BINARY_AI;
-- ALTER SESSION SET NLS_COMP = LINGUISTIC;
-- SELECT first_name FROM people ORDER BY first_name;

-- SHOW VARIABLES LIKE 'collation_server'; -- MySQL specific
-- SHOW VARIABLES LIKE 'character_set_server'; -- MySQL specific

-- select people.first_name from people order by people.first_name collate utf8mb4_bin; -- MySQL specific

select * from
             ( select price , first_name from people
               order by price nulls first,
               price desc fetch first 6 rows only)
as top_prod order by first_name;

SELECT id, first_name
FROM people
ORDER BY first_name desc
OFFSET 5 ROWS FETCH NEXT 10 ROWS ONLY;

SELECT id, first_name
FROM people
ORDER BY first_name desc
FETCH FIRST 20 ROWS ONLY;

/* KEYSET PAGINATION IF OFFSET >> 100
2. Keyset Pagination (Seek Method)
SELECT id, name
FROM products
WHERE name > 'Zebra-1000000'  -- last name from previous page
ORDER BY name ASC
FETCH FIRST 10 ROWS ONLY; */


select * from people order by dbms_random.value;

select first_name , last_name ,status from people
    order by case status
    when 'urgent' then 1
    when 'high' then 2
    when 'normal' then 3
    else 4
end;

select first_name , last_name ,status from people
order by case status
             when 'urgent' then 11
             when 'high' then 22
             when 'normal' then 33
             else 44
             end ,
    3 desc;

select people.status,people.first_name,people.last_name
    from people order by DECODE(status,'urgent',1,'high',2,'normal',3); -- null first


select people.status,people.first_name,people.last_name
from people order by DECODE(status,'urgent',1,'high',2,'normal',3) nulls last;

select people.status,people.first_name,people.last_name
from people order by DECODE(status,'urgent',1,'high',2,'normal',3) nulls first;

-- group by ---------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE employees (
    employee_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    first_name VARCHAR2(50 CHAR),
    last_name VARCHAR2(50 CHAR),
    department VARCHAR2(50 CHAR),
    role VARCHAR2(50 CHAR),
    location VARCHAR2(50 CHAR),
    salary NUMBER(10,2),
    hire_date DATE
);

INSERT ALL
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Alice', 'Johnson', 'Sales', 'Manager', 'New York', 90000.00, TO_DATE('2018-05-20', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Bob', 'Smith', 'Sales', 'Executive', 'New York', 60000.00, TO_DATE('2020-03-14', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Carol', 'Davis', 'Sales', 'Executive', 'London', 58000.00, TO_DATE('2019-11-03', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('David', 'Brown', 'Sales', 'Analyst', 'London', 50000.00, TO_DATE('2021-07-12', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Eve', 'Miller', 'IT', 'Developer', 'New York', 75000.00, TO_DATE('2017-02-08', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Frank', 'Wilson', 'IT', 'Developer', 'London', 72000.00, TO_DATE('2019-09-25', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Grace', 'Moore', 'IT', 'Manager', 'New York', 95000.00, TO_DATE('2016-08-18', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Hank', 'Taylor', 'IT', 'Analyst', 'London', 68000.00, TO_DATE('2021-01-05', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Ivy', 'Anderson', 'HR', 'Manager', 'London', 88000.00, TO_DATE('2015-04-11', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Jack', 'Thomas', 'HR', 'Executive', 'New York', 55000.00, TO_DATE('2022-06-30', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Karen', 'Jackson', 'HR', 'Analyst', 'London', 53000.00, TO_DATE('2020-08-09', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Leo', 'White', 'Finance', 'Manager', 'New York', 98000.00, TO_DATE('2017-10-02', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Mia', 'Harris', 'Finance', 'Executive', 'London', 64000.00, TO_DATE('2019-12-17', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Nina', 'Martin', 'Finance', 'Analyst', 'New York', 62000.00, TO_DATE('2021-04-20', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Oscar', 'Garcia', 'Finance', 'Analyst', 'London', 61000.00, TO_DATE('2022-01-15', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Paul', 'Martinez', 'IT', 'Developer', 'New York', 78000.00, TO_DATE('2018-09-27', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Quinn', 'Robinson', 'Sales', 'Manager', 'London', 91000.00, TO_DATE('2016-06-06', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Ruth', 'Clark', 'Sales', 'Executive', 'London', 59000.00, TO_DATE('2020-10-18', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Sam', 'Rodriguez', 'Finance', 'Executive', 'New York', 65000.00, TO_DATE('2019-07-13', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Tina', 'Lewis', 'HR', 'Executive', 'London', 54000.00, TO_DATE('2021-11-04', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Uma', 'Lee', 'Finance', 'Manager', 'London', 97000.00, TO_DATE('2015-12-29', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Victor', 'Walker', 'IT', 'Analyst', 'New York', 70000.00, TO_DATE('2019-01-21', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Wendy', 'Hall', 'Sales', 'Analyst', 'New York', 52000.00, TO_DATE('2020-09-10', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Xavier', 'Allen', 'IT', 'Developer', 'London', 76000.00, TO_DATE('2021-06-19', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Yara', 'Young', 'Finance', 'Executive', 'New York', 66000.00, TO_DATE('2018-03-15', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Zane', 'King', 'HR', 'Analyst', 'New York', 51000.00, TO_DATE('2022-04-25', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Adam', 'Scott', 'Finance', 'Manager', 'New York', 99000.00, TO_DATE('2016-07-22', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Bella', 'Green', 'IT', 'Manager', 'London', 94000.00, TO_DATE('2017-05-11', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Chris', 'Adams', 'Sales', 'Executive', 'New York', 61000.00, TO_DATE('2019-02-28', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Alice', 'Ford', 'Engineering', 'Developer', 'Seattle', 78000.00, TO_DATE('2021-03-15', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Brian', 'Chase', 'Engineering', 'Developer', 'Seattle', 81000.00, TO_DATE('2020-07-21', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Cindy', 'Liu', 'Engineering', 'Manager', 'Seattle', 95000.00, TO_DATE('2019-11-04', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('David', 'Kim', 'Marketing', 'Specialist', 'Seattle', 62000.00, TO_DATE('2022-05-18', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Evelyn', 'Ross', 'Engineering', 'Developer', 'Miami', 72000.00, TO_DATE('2021-08-09', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Frank', 'Hall', 'Engineering', 'QA Engineer', 'Miami', 65000.00, TO_DATE('2020-12-02', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Grace', 'Patel', 'HR', 'Recruiter', 'Miami', 59000.00, TO_DATE('2023-01-10', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Henry', 'Adams', 'Finance', 'Analyst', 'Miami', 69000.00, TO_DATE('2020-04-25', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Isabel', 'Grant', 'Finance', 'Analyst', 'Austin', 71000.00, TO_DATE('2019-06-17', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Jack', 'Ward', 'Finance', 'Manager', 'Austin', 95000.00, TO_DATE('2021-02-28', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Karen', 'Webb', 'Engineering', 'Developer', 'Austin', 78000.00, TO_DATE('2022-09-14', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Leo', 'Turner', 'Marketing', 'Specialist', 'Austin', 63000.00, TO_DATE('2023-04-07', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Mia', 'Scott', 'Marketing', 'Manager', 'Boston', 87000.00, TO_DATE('2018-10-12', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Nathan', 'Brooks', 'Engineering', 'Developer', 'Boston', 75000.00, TO_DATE('2020-06-19', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Olivia', 'Price', 'Engineering', 'QA Engineer', 'Boston', 64000.00, TO_DATE('2021-12-05', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Peter', 'Long', 'HR', 'Manager', 'Boston', 85000.00, TO_DATE('2019-03-30', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Quincy', 'James', 'Engineering', 'Developer', 'Denver', 77000.00, TO_DATE('2021-05-22', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Rachel', 'West', 'Finance', 'Analyst', 'Denver', 70000.00, TO_DATE('2022-08-15', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Samuel', 'Clark', 'Finance', 'Manager', 'Denver', 94000.00, TO_DATE('2020-01-09', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Tina', 'Edwards', 'Marketing', 'Specialist', 'Denver', 65000.00, TO_DATE('2023-06-03', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Uma', 'Khan', 'Engineering', 'Developer', 'Chicago', 79000.00, TO_DATE('2020-09-27', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Victor', 'Bell', 'Engineering', 'Manager', 'Chicago', 96000.00, TO_DATE('2019-02-14', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Wendy', 'Young', 'Finance', 'Analyst', 'Chicago', 72000.00, TO_DATE('2021-11-11', 'YYYY-MM-DD'))
    INTO employees (first_name, last_name, department, role, location, salary, hire_date) VALUES ('Xavier', 'Ross', 'HR', 'Recruiter', 'Chicago', 60000.00, TO_DATE('2022-07-20', 'YYYY-MM-DD'))
SELECT 1 FROM DUAL;

select * from employees;

select department ,
    count(department) as total_dept
    from employees
    group by department;

select role ,
    count(role) as total_roles
    from employees
GROUP BY role;

select department ,
       count(department) as total_dept,
       role ,
       count(role) as total_roles
from employees
group by department , role;

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

select EXTRACT(YEAR FROM hire_date) as joining_year ,
    count(*) as hire_count
    from employees
    group by EXTRACT(YEAR FROM hire_date)
    order by joining_year;

select department , role , sum(salary) as salarypool
    from employees
    group by ROLLUP(department , role);

-- Simulating GROUPING SETS in MySQL (Original)
-- SELECT department, role, SUM(salary) AS salarypool FROM employees GROUP BY department, role
-- UNION ALL
-- SELECT department, NULL AS roles, SUM(salary) AS salarypool FROM employees GROUP BY department
-- UNION ALL
-- SELECT NULL AS department, NULL AS roles, SUM(salary) AS salarypool FROM employees;

-- Oracle GROUPING SETS
select department , role , sum(salary) as salarypool
    from employees
    group by grouping sets(
    (department , role),
    (department),
    ()
    );

-- Oracle CUBE
select department , role, sum(salary) as salarypool
    from employees
    group by cube (department , role);

-- DISTINCT VS GROUP BY
SELECT count(DISTINCT department) as distict_dept FROM employees;

select count(*) as dept from (select 1 from employees group by department);

-- JOINS --------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE emp (
    emp_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name VARCHAR2(100 CHAR) NOT NULL,
    email VARCHAR2(100 CHAR) UNIQUE,
    mgr_id NUMBER,
    dept_id NUMBER,
    salary NUMBER(10,2),
    hire_dt DATE,
    FOREIGN KEY (mgr_id) REFERENCES emp(emp_id)
);

INSERT ALL
    INTO emp (name, email, mgr_id, dept_id, salary, hire_dt) VALUES ('John Smith', 'john.smith@company.com', NULL, 1, 95000.00, TO_DATE('2020-01-15', 'YYYY-MM-DD'))
    INTO emp (name, email, mgr_id, dept_id, salary, hire_dt) VALUES ('Sarah Johnson', 'sarah.johnson@company.com', 1, 1, 75000.00, TO_DATE('2020-03-20', 'YYYY-MM-DD'))
    INTO emp (name, email, mgr_id, dept_id, salary, hire_dt) VALUES ('Mike Davis', 'mike.davis@company.com', 1, 1, 70000.00, TO_DATE('2021-05-10', 'YYYY-MM-DD'))
    INTO emp (name, email, mgr_id, dept_id, salary, hire_dt) VALUES ('Emma Wilson', 'emma.wilson@company.com', NULL, 2, 80000.00, TO_DATE('2019-08-12', 'YYYY-MM-DD'))
    INTO emp (name, email, mgr_id, dept_id, salary, hire_dt) VALUES ('David Brown', 'david.brown@company.com', 4, 2, 65000.00, TO_DATE('2021-02-18', 'YYYY-MM-DD'))
    INTO emp (name, email, mgr_id, dept_id, salary, hire_dt) VALUES ('Lisa Garcia', 'lisa.garcia@company.com', 4, 2, 62000.00, TO_DATE('2022-01-05', 'YYYY-MM-DD'))
    INTO emp (name, email, mgr_id, dept_id, salary, hire_dt) VALUES ('Robert Taylor', 'robert.taylor@company.com', NULL, 3, 85000.00, TO_DATE('2020-11-30', 'YYYY-MM-DD'))
    INTO emp (name, email, mgr_id, dept_id, salary, hire_dt) VALUES ('Jennifer Lee', 'jennifer.lee@company.com', 7, 3, 58000.00, TO_DATE('2021-09-15', 'YYYY-MM-DD'))
    INTO emp (name, email, mgr_id, dept_id, salary, hire_dt) VALUES ('Michael Wang', 'michael.wang@company.com', NULL, 4, 90000.00, TO_DATE('2018-06-01', 'YYYY-MM-DD'))
    INTO emp (name, email, mgr_id, dept_id, salary, hire_dt) VALUES ('Amanda Clark', 'amanda.clark@company.com', 9, 4, 55000.00, TO_DATE('2022-03-10', 'YYYY-MM-DD'))
SELECT 1 FROM DUAL;


CREATE TABLE departments (
    department_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    department_name VARCHAR2(100 CHAR) NOT NULL,
    location VARCHAR2(100 CHAR),
    budget NUMBER(12,2)
);


INSERT ALL
    INTO departments (department_name, location, budget) VALUES ('Engineering', 'New York', 500000.00)
    INTO departments (department_name, location, budget) VALUES ('Sales', 'Chicago', 300000.00)
    INTO departments (department_name, location, budget) VALUES ('Marketing', 'Los Angeles', 200000.00)
    INTO departments (department_name, location, budget) VALUES ('HR', 'New York', 150000.00)
    INTO departments (department_name, location, budget) VALUES ('Finance', 'Boston', 250000.00)
    INTO departments (department_name, location, budget) VALUES ('IT Support', 'Austin', 180000.00)
    INTO departments (department_name, location, budget) VALUES ('Operations', 'Seattle', 220000.00)
    INTO departments (department_name, location, budget) VALUES ('Research', 'San Francisco', 400000.00)
    INTO departments (department_name, location, budget) VALUES ('Customer Service', 'Miami', 120000.00)
    INTO departments (department_name, location, budget) VALUES ('Legal', 'Washington DC', 180000.00)
SELECT 1 FROM DUAL;


CREATE TABLE customers (
    customer_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    customer_name VARCHAR2(100 CHAR) NOT NULL,
    email VARCHAR2(100 CHAR) UNIQUE,
    phone VARCHAR2(20 CHAR),
    city VARCHAR2(50 CHAR),
    registration_date DATE
);

INSERT ALL
    INTO customers (customer_name, email, phone, city, registration_date) VALUES ('Alice Cooper', 'alice.cooper@email.com', '555-0101', 'New York', TO_DATE('2023-01-15', 'YYYY-MM-DD'))
    INTO customers (customer_name, email, phone, city, registration_date) VALUES ('Bob Martinez', 'bob.martinez@email.com', '555-0102', 'Los Angeles', TO_DATE('2023-02-20', 'YYYY-MM-DD'))
    INTO customers (customer_name, email, phone, city, registration_date) VALUES ('Carol White', 'carol.white@email.com', '555-0103', 'Chicago', TO_DATE('2023-03-10', 'YYYY-MM-DD'))
    INTO customers (customer_name, email, phone, city, registration_date) VALUES ('Daniel Kim', 'daniel.kim@email.com', '555-0104', 'Houston', TO_DATE('2023-04-05', 'YYYY-MM-DD'))
    INTO customers (customer_name, email, phone, city, registration_date) VALUES ('Eva Rodriguez', 'eva.rodriguez@email.com', '555-0105', 'Phoenix', TO_DATE('2023-05-12', 'YYYY-MM-DD'))
    INTO customers (customer_name, email, phone, city, registration_date) VALUES ('Frank Thompson', 'frank.thompson@email.com', '555-0106', 'Philadelphia', TO_DATE('2023-06-18', 'YYYY-MM-DD'))
    INTO customers (customer_name, email, phone, city, registration_date) VALUES ('Grace Chen', 'grace.chen@email.com', '555-0107', 'San Antonio', TO_DATE('2023-07-22', 'YYYY-MM-DD'))
    INTO customers (customer_name, email, phone, city, registration_date) VALUES ('Henry Johnson', 'henry.johnson@email.com', '555-0108', 'San Diego', TO_DATE('2023-08-30', 'YYYY-MM-DD'))
    INTO customers (customer_name, email, phone, city, registration_date) VALUES ('Iris Patel', 'iris.patel@email.com', '555-0109', 'Dallas', TO_DATE('2023-09-14', 'YYYY-MM-DD'))
    INTO customers (customer_name, email, phone, city, registration_date) VALUES ('Jack Wilson', 'jack.wilson@email.com', '555-0110', 'Austin', TO_DATE('2023-10-25', 'YYYY-MM-DD'))
SELECT 1 FROM DUAL;


CREATE TABLE products (
    product_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    product_name VARCHAR2(100 CHAR) NOT NULL,
    category VARCHAR2(50 CHAR),
    price NUMBER(10,2),
    stock_quantity NUMBER DEFAULT 0
);

INSERT ALL
    INTO products (product_name, category, price, stock_quantity) VALUES ('Laptop Pro 15"', 'Electronics', 1299.99, 50)
    INTO products (product_name, category, price, stock_quantity) VALUES ('Wireless Mouse', 'Electronics', 29.99, 200)
    INTO products (product_name, category, price, stock_quantity) VALUES ('Office Chair', 'Furniture', 199.99, 30)
    INTO products (product_name, category, price, stock_quantity) VALUES ('Standing Desk', 'Furniture', 399.99, 15)
    INTO products (product_name, category, price, stock_quantity) VALUES ('Coffee Mug', 'Office Supplies', 12.99, 100)
    INTO products (product_name, category, price, stock_quantity) VALUES ('Notebook Set', 'Office Supplies', 8.99, 150)
    INTO products (product_name, category, price, stock_quantity) VALUES ('Smartphone', 'Electronics', 699.99, 75)
    INTO products (product_name, category, price, stock_quantity) VALUES ('Tablet 10"', 'Electronics', 329.99, 60)
    INTO products (product_name, category, price, stock_quantity) VALUES ('Desk Lamp', 'Furniture', 45.99, 40)
    INTO products (product_name, category, price, stock_quantity) VALUES ('Pen Set', 'Office Supplies', 15.99, 120)
SELECT 1 FROM DUAL;



CREATE TABLE orders (
    order_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    customer_id NUMBER,
    product_id NUMBER,
    employee_id NUMBER,
    quantity NUMBER DEFAULT 1,
    order_date DATE,
    total_amount NUMBER(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (employee_id) REFERENCES emp(emp_id)
);

INSERT ALL
    INTO orders (customer_id, product_id, employee_id, quantity, order_date, total_amount) VALUES (1, 1, 5, 1, TO_DATE('2024-01-10', 'YYYY-MM-DD'), 1299.99)
    INTO orders (customer_id, product_id, employee_id, quantity, order_date, total_amount) VALUES (2, 7, 6, 1, TO_DATE('2024-01-15', 'YYYY-MM-DD'), 699.99)
    INTO orders (customer_id, product_id, employee_id, quantity, order_date, total_amount) VALUES (3, 3, 5, 2, TO_DATE('2024-01-20', 'YYYY-MM-DD'), 399.98)
    INTO orders (customer_id, product_id, employee_id, quantity, order_date, total_amount) VALUES (1, 2, 6, 3, TO_DATE('2024-02-01', 'YYYY-MM-DD'), 89.97)
    INTO orders (customer_id, product_id, employee_id, quantity, order_date, total_amount) VALUES (4, 4, 5, 1, TO_DATE('2024-02-05', 'YYYY-MM-DD'), 399.99)
    INTO orders (customer_id, product_id, employee_id, quantity, order_date, total_amount) VALUES (5, 5, 6, 5, TO_DATE('2024-02-10', 'YYYY-MM-DD'), 64.95)
    INTO orders (customer_id, product_id, employee_id, quantity, order_date, total_amount) VALUES (2, 8, 5, 1, TO_DATE('2024-02-15', 'YYYY-MM-DD'), 329.99)
    INTO orders (customer_id, product_id, employee_id, quantity, order_date, total_amount) VALUES (6, 6, 6, 10, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 89.90)
    INTO orders (customer_id, product_id, employee_id, quantity, order_date, total_amount) VALUES (7, 9, 5, 2, TO_DATE('2024-03-10', 'YYYY-MM-DD'), 91.98)
    INTO orders (customer_id, product_id, employee_id, quantity, order_date, total_amount) VALUES (3, 10, 6, 4, TO_DATE('2024-03-15', 'YYYY-MM-DD'), 63.96)
SELECT 1 FROM DUAL;


select name , department_name
    from emp inner join departments on
    emp.dept_id = departments.department_id;
select * from emp;
select * from departments; -- INNER JOIN

select d.department_name , e.name
    from departments d left join emp e
    on d.department_id = e.dept_id; -- LEFT JOIN

select o.order_date , o.total_amount, c.customer_id , c.customer_name , c.city
    from orders o right join customers c
    on c.customer_id = o.customer_id; -- RIGHT JOIN

-- Oracle supports FULL OUTER JOIN directly
select e.emp_id , e.name , e.dept_id , o.order_id , o.order_date
    from emp e full outer join orders o
    on e.emp_id = o.employee_id;

-- CROSS JOIN in Oracle does not use an ON clause
select e.emp_id , e.name, o.order_id , o.order_date
from emp e cross join orders o;

-- SELF JOIN
select a.emp_id , a.name as employee_name, b.name as manager_name
from emp a
    inner join emp b on a.mgr_id = b.emp_id; -- INNER

select a.emp_id , a.name as employee_name, b.name as manager_name
from emp a
    left join emp b on a.mgr_id = b.emp_id; -- LEFT

-- Implicit join syntax (works in Oracle)
select a.emp_id , a.name , b.name
    from emp a , emp b
    where a.mgr_id = b.emp_id;

-- Create student_games table
CREATE TABLE student_games (
                               student_id NUMBER,
                               game_id NUMBER
);

-- Insert sample data
INSERT ALL
    INTO student_games (student_id, game_id) VALUES (101, 1)
    INTO student_games (student_id, game_id) VALUES (102, 2)
    INTO student_games (student_id, game_id) VALUES (103, 3)
    INTO student_games (student_id, game_id) VALUES (201, 1)
    INTO student_games (student_id, game_id) VALUES (201, 2)
    INTO student_games (student_id, game_id) VALUES (202, 2)
    INTO student_games (student_id, game_id) VALUES (202, 3)
    INTO student_games (student_id, game_id) VALUES (301, 1)
    INTO student_games (student_id, game_id) VALUES (301, 2)
    INTO student_games (student_id, game_id) VALUES (301, 3)
    INTO student_games (student_id, game_id) VALUES (301, 4)
    INTO student_games (student_id, game_id) VALUES (302, 1)
    INTO student_games (student_id, game_id) VALUES (302, 2)
    INTO student_games (student_id, game_id) VALUES (302, 3)
    INTO student_games (student_id, game_id) VALUES (302, 4)
    INTO student_games (student_id, game_id) VALUES (302, 5)
    INTO student_games (student_id, game_id) VALUES (401, NULL)
    INTO student_games (student_id, game_id) VALUES (402, NULL)
SELECT 1 FROM DUAL;

-- View all data
SELECT * FROM student_games ORDER BY student_id, game_id;

select student_id
from student_games
group by student_id
having count(game_id) < 3;

-- Using window functions (ROW_NUMBER)
SELECT student_id
FROM (
    SELECT student_id,
           ROW_NUMBER() OVER (PARTITION BY student_id ORDER BY game_id) as rn
    FROM student_games
)
GROUP BY student_id
HAVING MAX(rn) < 3;

-- Using subquery with COUNT
SELECT DISTINCT s1.student_id
FROM student_games s1
WHERE (
    SELECT COUNT(s2.game_id)
    FROM student_games s2
    WHERE s2.student_id = s1.student_id
) < 3
ORDER BY s1.student_id;

-- Chained LEFT JOINs
select p.product_id , o.order_id , e.emp_id
    from products p
    left join orders o on o.product_id = p.product_id
    left join emp e on o.employee_id = e.emp_id;

select p.product_id , o.order_id , e.emp_id
    from products p
    right join orders o on o.product_id = p.product_id
    left join emp e on o.employee_id = e.emp_id;

-- ranks -------------------------------------------------------------------------------------------------------------------------------------------------

-- Oracle
CREATE TABLE sales_data (
    sale_id NUMBER PRIMARY KEY,
    sale_date DATE NOT NULL,
    salesperson_id NUMBER,
    product_category VARCHAR2(50),
    sale_amount NUMBER(10,2) NOT NULL,
    quantity_sold NUMBER,
    region VARCHAR2(50)
);

CREATE SEQUENCE sales_data_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER sales_data_trigger
BEFORE INSERT ON sales_data
FOR EACH ROW
BEGIN
    SELECT sales_data_seq.NEXTVAL INTO :new.sale_id FROM dual;
END;


CREATE TABLE student_grades (
    student_id NUMBER PRIMARY KEY,
    student_name VARCHAR2(100) NOT NULL,
    subject VARCHAR2(50) NOT NULL,
    grade NUMBER(5,2) NOT NULL,
    exam_date DATE NOT NULL,
    semester VARCHAR2(20),
    credit_hours NUMBER
);

INSERT ALL
    INTO sales_data (sale_date, salesperson_id, product_category, sale_amount, quantity_sold, region) VALUES (TO_DATE('2024-01-15', 'YYYY-MM-DD'), 1, 'Electronics', 25000.00, 50, 'North')
    INTO sales_data (sale_date, salesperson_id, product_category, sale_amount, quantity_sold, region) VALUES (TO_DATE('2024-01-16', 'YYYY-MM-DD'), 2, 'Clothing', 18000.00, 120, 'South')
    INTO sales_data (sale_date, salesperson_id, product_category, sale_amount, quantity_sold, region) VALUES (TO_DATE('2024-01-17', 'YYYY-MM-DD'), 3, 'Electronics', 32000.00, 40, 'East')
    INTO sales_data (sale_date, salesperson_id, product_category, sale_amount, quantity_sold, region) VALUES (TO_DATE('2024-01-18', 'YYYY-MM-DD'), 1, 'Books', 8000.00, 200, 'North')
    INTO sales_data (sale_date, salesperson_id, product_category, sale_amount, quantity_sold, region) VALUES (TO_DATE('2024-01-19', 'YYYY-MM-DD'), 4, 'Electronics', 45000.00, 75, 'West')
    INTO sales_data (sale_date, salesperson_id, product_category, sale_amount, quantity_sold, region) VALUES (TO_DATE('2024-01-20', 'YYYY-MM-DD'), 2, 'Clothing', 22000.00, 80, 'South')
    INTO sales_data (sale_date, salesperson_id, product_category, sale_amount, quantity_sold, region) VALUES (TO_DATE('2024-01-21', 'YYYY-MM-DD'), 5, 'Books', 12000.00, 150, 'East')
    INTO sales_data (sale_date, salesperson_id, product_category, sale_amount, quantity_sold, region) VALUES (TO_DATE('2024-01-22', 'YYYY-MM-DD'), 3, 'Electronics', 38000.00, 60, 'East')
    INTO sales_data (sale_date, salesperson_id, product_category, sale_amount, quantity_sold, region) VALUES (TO_DATE('2024-01-23', 'YYYY-MM-DD'), 1, 'Clothing', 16000.00, 90, 'North')
    INTO sales_data (sale_date, salesperson_id, product_category, sale_amount, quantity_sold, region) VALUES (TO_DATE('2024-01-24', 'YYYY-MM-DD'), 6, 'Books', 9000.00, 180, 'West')
    INTO sales_data (sale_date, salesperson_id, product_category, sale_amount, quantity_sold, region) VALUES (TO_DATE('2024-01-25', 'YYYY-MM-DD'), 4, 'Electronics', 41000.00, 65, 'West')
    INTO sales_data (sale_date, salesperson_id, product_category, sale_amount, quantity_sold, region) VALUES (TO_DATE('2024-01-26', 'YYYY-MM-DD'), 2, 'Clothing', 24000.00, 100, 'South')
    INTO sales_data (sale_date, salesperson_id, product_category, sale_amount, quantity_sold, region) VALUES (TO_DATE('2024-01-27', 'YYYY-MM-DD'), 5, 'Books', 11000.00, 220, 'East')
    INTO sales_data (sale_date, salesperson_id, product_category, sale_amount, quantity_sold, region) VALUES (TO_DATE('2024-01-28', 'YYYY-MM-DD'), 7, 'Electronics', 29000.00, 45, 'North')
    INTO sales_data (sale_date, salesperson_id, product_category, sale_amount, quantity_sold, region) VALUES (TO_DATE('2024-01-29', 'YYYY-MM-DD'), 3, 'Clothing', 19000.00, 75, 'East')
    INTO sales_data (sale_date, salesperson_id, product_category, sale_amount, quantity_sold, region) VALUES (TO_DATE('2024-01-30', 'YYYY-MM-DD'), 6, 'Books', 13000.00, 160, 'West')
    INTO sales_data (sale_date, salesperson_id, product_category, sale_amount, quantity_sold, region) VALUES (TO_DATE('2024-01-31', 'YYYY-MM-DD'), 1, 'Electronics', 35000.00, 55, 'North')
    INTO sales_data (sale_date, salesperson_id, product_category, sale_amount, quantity_sold, region) VALUES (TO_DATE('2024-02-01', 'YYYY-MM-DD'), 4, 'Clothing', 21000.00, 85, 'West')
    INTO sales_data (sale_date, salesperson_id, product_category, sale_amount, quantity_sold, region) VALUES (TO_DATE('2024-02-02', 'YYYY-MM-DD'), 7, 'Books', 10000.00, 190, 'North')
    INTO sales_data (sale_date, salesperson_id, product_category, sale_amount, quantity_sold, region) VALUES (TO_DATE('2024-02-03', 'YYYY-MM-DD'), 2, 'Electronics', 39000.00, 70, 'South')
SELECT 1 FROM DUAL;

INSERT ALL
    INTO student_grades (student_id, student_name, subject, grade, exam_date, semester, credit_hours) VALUES (1, 'Emma Wilson', 'Mathematics', 92.5, TO_DATE('2024-05-15', 'YYYY-MM-DD'), 'Spring 2024', 3)
    INTO student_grades (student_id, student_name, subject, grade, exam_date, semester, credit_hours) VALUES (2, 'Liam Chen', 'Mathematics', 88.0, TO_DATE('2024-05-15', 'YYYY-MM-DD'), 'Spring 2024', 3)
    INTO student_grades (student_id, student_name, subject, grade, exam_date, semester, credit_hours) VALUES (3, 'Sophie Rodriguez', 'Physics', 95.0, TO_DATE('2024-05-20', 'YYYY-MM-DD'), 'Spring 2024', 4)
    INTO student_grades (student_id, student_name, subject, grade, exam_date, semester, credit_hours) VALUES (4, 'Mason Kim', 'Chemistry', 87.5, TO_DATE('2024-05-18', 'YYYY-MM-DD'), 'Spring 2024', 3)
    INTO student_grades (student_id, student_name, subject, grade, exam_date, semester, credit_hours) VALUES (5, 'Ava Patel', 'Mathematics', 91.0, TO_DATE('2024-05-15', 'YYYY-MM-DD'), 'Spring 2024', 3)
    INTO student_grades (student_id, student_name, subject, grade, exam_date, semester, credit_hours) VALUES (6, 'Noah Johnson', 'Physics', 89.5, TO_DATE('2024-05-20', 'YYYY-MM-DD'), 'Spring 2024', 4)
    INTO student_grades (student_id, student_name, subject, grade, exam_date, semester, credit_hours) VALUES (7, 'Isabella Brown', 'Chemistry', 93.0, TO_DATE('2024-05-18', 'YYYY-MM-DD'), 'Spring 2024', 3)
    INTO student_grades (student_id, student_name, subject, grade, exam_date, semester, credit_hours) VALUES (8, 'Ethan Davis', 'Mathematics', 85.5, TO_DATE('2024-05-15', 'YYYY-MM-DD'), 'Spring 2024', 3)
    INTO student_grades (student_id, student_name, subject, grade, exam_date, semester, credit_hours) VALUES (9, 'Mia Garcia', 'Physics', 90.0, TO_DATE('2024-05-20', 'YYYY-MM-DD'), 'Spring 2024', 4)
    INTO student_grades (student_id, student_name, subject, grade, exam_date, semester, credit_hours) VALUES (10, 'James Martinez', 'Biology', 88.5, TO_DATE('2024-05-22', 'YYYY-MM-DD'), 'Spring 2024', 4)
    INTO student_grades (student_id, student_name, subject, grade, exam_date, semester, credit_hours) VALUES (11, 'Charlotte Lee', 'Chemistry', 94.5, TO_DATE('2024-05-18', 'YYYY-MM-DD'), 'Spring 2024', 3)
    INTO student_grades (student_id, student_name, subject, grade, exam_date, semester, credit_hours) VALUES (12, 'Benjamin Taylor', 'Mathematics', 86.0, TO_DATE('2024-05-15', 'YYYY-MM-DD'), 'Spring 2024', 3)
    INTO student_grades (student_id, student_name, subject, grade, exam_date, semester, credit_hours) VALUES (13, 'Amelia Anderson', 'Biology', 92.0, TO_DATE('2024-05-22', 'YYYY-MM-DD'), 'Spring 2024', 4)
    INTO student_grades (student_id, student_name, subject, grade, exam_date, semester, credit_hours) VALUES (14, 'Lucas Thompson', 'Physics', 87.0, TO_DATE('2024-05-20', 'YYYY-MM-DD'), 'Spring 2024', 4)
    INTO student_grades (student_id, student_name, subject, grade, exam_date, semester, credit_hours) VALUES (15, 'Harper White', 'Chemistry', 90.5, TO_DATE('2024-05-18', 'YYYY-MM-DD'), 'Spring 2024', 3)
    INTO student_grades (student_id, student_name, subject, grade, exam_date, semester, credit_hours) VALUES (16, 'Alexander Harris', 'Biology', 89.0, TO_DATE('2024-05-22', 'YYYY-MM-DD'), 'Spring 2024', 4)
    INTO student_grades (student_id, student_name, subject, grade, exam_date, semester, credit_hours) VALUES (17, 'Evelyn Clark', 'Mathematics', 93.5, TO_DATE('2024-05-15', 'YYYY-MM-DD'), 'Spring 2024', 3)
    INTO student_grades (student_id, student_name, subject, grade, exam_date, semester, credit_hours) VALUES (18, 'Michael Lewis', 'Physics', 91.5, TO_DATE('2024-05-20', 'YYYY-MM-DD'), 'Spring 2024', 4)
    INTO student_grades (student_id, student_name, subject, grade, exam_date, semester, credit_hours) VALUES (19, 'Abigail Walker', 'Biology', 87.5, TO_DATE('2024-05-22', 'YYYY-MM-DD'), 'Spring 2024', 4)
    INTO student_grades (student_id, student_name, subject, grade, exam_date, semester, credit_hours) VALUES (20, 'William Hall', 'Chemistry', 92.0, TO_DATE('2024-05-18', 'YYYY-MM-DD'), 'Spring 2024', 3)
SELECT 1 FROM DUAL;

select * from student_grades;
select * from sales_data;

select product_category , quantity_sold , sale_amount , row_number()
        over (order by quantity_sold desc) as sr_no from sales_data;

select  student_name, subject , grade , rank()
        over (order by grade desc) as sr_no from student_grades;


select  student_name, subject , grade , rank()
        over (partition by subject order by grade desc) as sr_no from student_grades;

select student_name , grade , subject,
    row_number() over (partition by subject order by grade desc,student_name) as sr_no,
    rank() over (partition by subject order by grade desc,student_name) as rankk,
    dense_rank() over (partition by subject order by grade desc,student_name) as dense
from student_grades;

with cte as (
    select name ,
           salary ,
           dept_id ,
           row_number() over (partition by dept_id order by salary desc) as dept_top3
    from emp
) select dept_id , name , salary from cte where dept_top3 <= 2;

select customer_id,total_amount from orders;

select customer_id , sum(total_amount) revenue,
       ntile(1) over (order by sum(total_amount) desc) as revenue_decile
from orders
group by customer_id
order by revenue desc;

select customer_id , sum(total_amount) revenue,
       ntile(2) over (order by sum(total_amount) desc) as revenue_decile
from orders
group by customer_id
order by revenue desc;

select customer_id , sum(total_amount) revenue,
       ntile(3) over (order by sum(total_amount) desc) as revenue_decile
from orders
group by customer_id
order by revenue desc;

select customer_id , sum(total_amount) revenue,
       ntile(7) over (order by sum(total_amount) desc) as revenue_decile
from orders
group by customer_id
order by revenue desc;

select customer_id , sum(total_amount) revenue,
       ntile(199) over (order by sum(total_amount) desc) as revenue_decile
from orders
group by customer_id
order by revenue desc;

select student_name , grade , subject,
       row_number() over (partition by subject order by grade desc) as sr_no,
       rank() over (partition by subject order by grade desc) as rankk,
       dense_rank() over (partition by subject order by grade desc) as dense,
       percent_rank() over (partition by subject order by grade)*100 as percentile,
       cume_dist() over (partition by subject order by grade desc) as c_dist
from student_grades
order by subject,sr_no;

-- partition by , window func-----------------------------------------------------------------------------------------------------------------------------

CREATE TABLE sample_data (
    id NUMBER,
    name VARCHAR2(100),
    category VARCHAR2(50),
    created_at DATE,
    amount NUMBER(10,2)
);

INSERT ALL
    INTO sample_data (id, name, category, created_at, amount) VALUES (7, 'Golf', 'A', DATE '2024-04-01', 45.00)
    INTO sample_data (id, name, category, created_at, amount) VALUES (8, 'Hotel', 'B', DATE '2024-04-10', 510.10)
    INTO sample_data (id, name, category, created_at, amount) VALUES (9, 'India', 'C', DATE '2024-04-22', 180.00)
    INTO sample_data (id, name, category, created_at, amount) VALUES (10, 'Juliet', 'A', DATE '2024-05-01', 270.30)
    INTO sample_data (id, name, category, created_at, amount) VALUES (1, 'Alpha', 'A', DATE '2024-01-10', 100.00)
    INTO sample_data (id, name, category, created_at, amount) VALUES (2, 'Bravo', 'A', DATE '2024-01-11', 150.50)
    INTO sample_data (id, name, category, created_at, amount) VALUES (3, 'Charlie', 'B', DATE '2024-02-01', 75.25)
    INTO sample_data (id, name, category, created_at, amount) VALUES (4, 'Delta', 'B', DATE '2024-02-15', 220.00)
    INTO sample_data (id, name, category, created_at, amount) VALUES (5, 'Echo', 'C', DATE '2024-03-05', 90.00)
    INTO sample_data (id, name, category, created_at, amount) VALUES (6, 'Foxtrot', 'C', DATE '2024-03-20', 310.75)
SELECT 1 FROM DUAL;

select * from sample_data order by id;

-- evaluating dup records using partition by -----------------------------------------------------------------------------------------------------------------
-- - Keep row detail while adding group-level metrics, unlike GROUP BY which collapses rows.
with cte as (
    select id , name, category, created_at, amount,
           row_number() over (partition by id,name,category,created_at,amount) as sr_no
    from sample_data
)
select id, name, category, created_at, amount, sr_no, count(sr_no) as no_of_enteries from cte group by id, name, category, created_at, amount, sr_no order by id;

select id ,
       row_number() over (partition by id,name,category,created_at,amount) as sr_no
from sample_data ;


with cte as (
    select id ,
           row_number() over (partition by id,name,category,created_at,amount) as sr_no
    from sample_data
)
select id , max(sr_no) as total_enteries from cte where cte.sr_no > 1 group by id;

-- #################################################################################################
-- #################################################################################################
-- Oracle Date/Time Types and Functions (Converted from SQL Server Example)
-- #################################################################################################
-- #################################################################################################

-- Clean slate
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE DateTimePlayground_Ora';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

-- Create a single table that holds equivalent Oracle date/time types
CREATE TABLE DateTimePlayground_Ora
(
    id                NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    only_date         DATE,                   -- SQL Server DATE
    only_time_7       TIMESTAMP(7),           -- SQL Server TIME(7). No direct TIME type in Oracle, so TIMESTAMP is used. The date part is ignored.
    legacy_datetime   TIMESTAMP(3),           -- SQL Server DATETIME (~3ms precision)
    modern_ts_7       TIMESTAMP(7),           -- SQL Server DATETIME2(7)
    with_offset_7     TIMESTAMP(7) WITH TIME ZONE, -- SQL Server DATETIMEOFFSET(7)
    small_dt          DATE                    -- SQL Server SMALLDATETIME (minute precision is covered by DATE)
);

-- Insert a "typical" row
INSERT INTO DateTimePlayground_Ora (only_date, only_time_7, legacy_datetime, modern_ts_7, with_offset_7, small_dt) VALUES (
    TO_DATE('2024-12-31', 'YYYY-MM-DD'),
    TO_TIMESTAMP('23:59:59.1234567', 'HH24:MI:SS.FF7'),
    TO_TIMESTAMP('2024-12-31 23:59:59.997', 'YYYY-MM-DD HH24:MI:SS.FF3'),
    TO_TIMESTAMP('2024-12-31 23:59:59.1234567', 'YYYY-MM-DD HH24:MI:SS.FF7'),
    TO_TIMESTAMP_TZ('2024-12-31 23:59:59.1234567 +05:30', 'YYYY-MM-DD HH24:MI:SS.FF7 TZH:TZM'),
    TO_DATE('2024-12-31 23:59', 'YYYY-MM-DD HH24:MI')
);

-- Precision check: TIMESTAMP preserves precision
INSERT INTO DateTimePlayground_Ora (only_date, only_time_7, legacy_datetime, modern_ts_7, with_offset_7, small_dt) VALUES (
    TO_DATE('2025-01-01', 'YYYY-MM-DD'),
    TO_TIMESTAMP('00:00:00.0000001', 'HH24:MI:SS.FF1'),
    TO_TIMESTAMP('2025-01-01 00:00:00.001', 'YYYY-MM-DD HH24:MI:SS.FF3'),
    TO_TIMESTAMP('2025-01-01 00:00:00.0000001', 'YYYY-MM-DD HH24:MI:SS.FF7'),
    TO_TIMESTAMP_TZ('2025-01-01 00:00:00.0000001 +00:00', 'YYYY-MM-DD HH24:MI:SS.FF7 TZH:TZM'),
    TO_DATE('2025-01-01 00:00', 'YYYY-MM-DD HH24:MI')
);

-- Edge/offsets
INSERT ALL
    INTO DateTimePlayground_Ora (only_date, only_time_7, legacy_datetime, modern_ts_7, with_offset_7, small_dt) VALUES (
        TO_DATE('0001-01-01', 'YYYY-MM-DD'),
        TO_TIMESTAMP('12:00:00', 'HH24:MI:SS'),
        TO_TIMESTAMP('2000-01-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        TO_TIMESTAMP('0001-01-01 12:00:00.0000000', 'YYYY-MM-DD HH24:MI:SS.FF7'),
        TO_TIMESTAMP_TZ('2000-01-01 12:00:00.0000000 -14:00', 'YYYY-MM-DD HH24:MI:SS.FF7 TZH:TZM'),
        TO_DATE('2000-01-01 12:00', 'YYYY-MM-DD HH24:MI')
    )
    INTO DateTimePlayground_Ora (only_date, only_time_7, legacy_datetime, modern_ts_7, with_offset_7, small_dt) VALUES (
        TO_DATE('9999-12-31', 'YYYY-MM-DD'),
        TO_TIMESTAMP('12:00:00', 'HH24:MI:SS'),
        TO_TIMESTAMP('2020-06-15 08:30:00.123', 'YYYY-MM-DD HH24:MI:SS.FF3'),
        TO_TIMESTAMP('9999-12-31 12:00:00.9999999', 'YYYY-MM-DD HH24:MI:SS.FF7'),
        TO_TIMESTAMP_TZ('2020-06-15 08:30:00.1230000 +14:00', 'YYYY-MM-DD HH24:MI:SS.FF7 TZH:TZM'),
        TO_DATE('2020-06-15 08:30', 'YYYY-MM-DD HH24:MI')
    )
SELECT 1 FROM DUAL;

SELECT * FROM DateTimePlayground_Ora ORDER BY id;

-- Current date/time functions
select 
    SYSDATE as gd,
    SYS_EXTRACT_UTC(SYSTIMESTAMP) as utc_ts,
    SYSTIMESTAMP as sysdt,
    LOCALTIMESTAMP as sysutc,
    CURRENT_TIMESTAMP as offs
from dual;

-- Extracting parts
DECLARE 
    v_dt TIMESTAMP(7) := TO_TIMESTAMP('2027-04-30 05:30:09.8974678', 'YYYY-MM-DD HH24:MI:SS.FF7');
BEGIN
    DBMS_OUTPUT.PUT_LINE('Year: ' || EXTRACT(YEAR FROM v_dt));
    DBMS_OUTPUT.PUT_LINE('Month: ' || EXTRACT(MONTH FROM v_dt));
    DBMS_OUTPUT.PUT_LINE('Day: ' || EXTRACT(DAY FROM v_dt));
    DBMS_OUTPUT.PUT_LINE('Hour: ' || EXTRACT(HOUR FROM v_dt));
    DBMS_OUTPUT.PUT_LINE('Minute: ' || EXTRACT(MINUTE FROM v_dt));
    DBMS_OUTPUT.PUT_LINE('Second: ' || EXTRACT(SECOND FROM v_dt));
END;


-- Date arithmetic
DECLARE 
    v_start TIMESTAMP(7) := TO_TIMESTAMP('2025-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS.FF7');
    v_end   TIMESTAMP(7) := TO_TIMESTAMP('2025-08-09 22:36:45.9876543', 'YYYY-MM-DD HH24:MI:SS.FF7');
BEGIN
    DBMS_OUTPUT.PUT_LINE('Add 67 days: ' || TO_CHAR(v_start + INTERVAL '67' DAY, 'YYYY-MM-DD HH24:MI:SS.FF7'));
    DBMS_OUTPUT.PUT_LINE('Add 55 months: ' || TO_CHAR(ADD_MONTHS(v_end, 55), 'YYYY-MM-DD HH24:MI:SS.FF7'));
    DBMS_OUTPUT.PUT_LINE('Add 9 years: ' || TO_CHAR(v_start + INTERVAL '9' YEAR, 'YYYY-MM-DD HH24:MI:SS.FF7'));
    DBMS_OUTPUT.PUT_LINE('Date difference in days: ' || (TRUNC(v_end) - TRUNC(v_start)));
    DBMS_OUTPUT.PUT_LINE('Timestamp difference in seconds: ' || 
        ((EXTRACT(DAY FROM (v_end - v_start)) * 86400) + 
         (EXTRACT(HOUR FROM (v_end - v_start)) * 3600) +
         (EXTRACT(MINUTE FROM (v_end - v_start)) * 60) +
         EXTRACT(SECOND FROM (v_end - v_start)))
    );
END;


-- Month-end and date construction
DECLARE
    v_any TIMESTAMP(7) := TO_TIMESTAMP('2028-09-07 08:23:56.9785679', 'YYYY-MM-DD HH24:MI:SS.FF7');
BEGIN
    DBMS_OUTPUT.PUT_LINE('End of month: ' || TO_CHAR(LAST_DAY(v_any), 'YYYY-MM-DD'));
    DBMS_OUTPUT.PUT_LINE('End of previous month: ' || TO_CHAR(LAST_DAY(ADD_MONTHS(v_any, -1)), 'YYYY-MM-DD'));
    DBMS_OUTPUT.PUT_LINE('Date from parts: ' || TO_CHAR(TO_DATE('2029-09-26', 'YYYY-MM-DD'), 'YYYY-MM-DD'));
END;


-- Casting from ISO 8601 strings
select 
    TO_TIMESTAMP('2027-09-30T23:06:51.9796876', 'YYYY-MM-DD"T"HH24:MI:SS.FF7') as casted,
    TO_TIMESTAMP_TZ('2027-09-30T23:06:51+05:30', 'YYYY-MM-DD"T"HH24:MI:SS TZH:TZM') as casted_offs
from dual;

-- Time zone conversions
DECLARE
    v_utc TIMESTAMP(7) := SYS_EXTRACT_UTC(SYSTIMESTAMP);
BEGIN
    DBMS_OUTPUT.PUT_LINE('UTC as offset: ' || TO_CHAR(FROM_TZ(v_utc, '+00:00'), 'YYYY-MM-DD HH24:MI:SS.FF7 TZH:TZM'));
    DBMS_OUTPUT.PUT_LINE('Indian time: ' || TO_CHAR(FROM_TZ(v_utc, '+00:00') AT TIME ZONE '+05:30', 'YYYY-MM-DD HH24:MI:SS.FF7 TZH:TZM'));
END;


-- Formatting to strings
select 
    TO_CHAR(TO_TIMESTAMP('2028-09-07 08:23:56.9785679', 'YYYY-MM-DD HH24:MI:SS.FF7'), 'DD Mon YYYY HH:MI:SS AM') as formatted_str
from dual;

-- STRING / SERVER FUNCTIONS - ORACLE COMPATIBLE
-- ==============================================

SELECT CONCAT('m', CONCAT(' ', CONCAT('y', CONCAT(' ', CONCAT('s', CONCAT(' ', CONCAT('q', CONCAT(' ', 'l')))))))) AS mysql,
       SUBSTR('mysql mssql postgres', 8, 4) AS idk,
       UPPER('i_feel_low') AS no_u_dont,
       LOWER('i''m high asf') AS nah,
       LENGTHB('not so entitled') AS lessee, -- byte length
       LENGTH('1234567 89') AS blank_space_myversion, -- character length
       TRIM(BOTH ' ' FROM '   claustrophobia   ') AS sry_not_sry,
       RTRIM('               i want some space  ') AS rightt,
       LTRIM('                   i want some space too           ') AS nah_left,
       RPAD(' hows the josh..high sir ', LENGTH(' hows the josh..high sir ') * 5, ' hows the josh..high sir ') AS hurrah,
       CAST('123' AS NUMBER) AS unsg,
       CAST(123 AS CHAR(3)) AS ch,
       TO_NUMBER('345') AS hmm,
       INSTR('where the tf are u?', 'u') AS here
FROM DUAL;

-- LENGTH vs LENGTHB examples
SELECT LENGTH('Hello World') AS char_length,              -- Result: 11 (characters)
       LENGTHB('Hello World') AS byte_length               -- Result: 11 (bytes)
FROM DUAL;

-- For multibyte characters - they differ significantly
SELECT LENGTH('Hello 世界') AS char_length,               -- Result: 8 (characters)
       LENGTHB('Hello 世界') AS byte_length                -- Result: 13 (bytes)
FROM DUAL;

-- More examples with different encodings
SELECT LENGTH('café') AS char_length,                     -- Result: 4 (characters)
       LENGTHB('café') AS byte_length                      -- Result: 5 (bytes - é takes 2 bytes in UTF-8)
FROM DUAL;

SELECT LENGTH('🚀📱💻') AS char_length,                   -- Result: 3 (characters)
       LENGTHB('🚀📱💻') AS byte_length                    -- Result: 12 (bytes - each emoji is 4 bytes)
FROM DUAL;

-- Using NVARCHAR2 for Unicode support in Oracle
SELECT LENGTH(N'Hello 世界') AS char_length,              -- Result: 8 (characters)
       LENGTHB(N'Hello 世界') AS byte_length               -- Result: 16 (bytes - Unicode uses 2 bytes per char)
FROM DUAL;

SELECT LENGTH(N'🚀📱💻') AS char_length,                  -- Result: 3 or 6 (depending on Unicode handling)
       LENGTHB(N'🚀📱💻') AS byte_length                   -- Result: 12 (bytes)
FROM DUAL;

-- LEFT and RIGHT functions equivalents in Oracle
SELECT SUBSTR('Hello World', 1, 3) AS left_equivalent,  -- Returns: 'Hel' (equivalent to LEFT)
       SUBSTR('Hello World', -5) AS right_equivalent     -- Returns: 'World' (equivalent to RIGHT)
FROM DUAL;

-- More RIGHT function examples using SUBSTR with negative position
SELECT SUBSTR('Hello World', -5, 5) AS right_5,         -- Returns: 'World'
       SUBSTR('Hello World', -3, 3) AS right_3          -- Returns: 'rld'
FROM DUAL;

-- Practical examples converted to Oracle

-- Extract area code from phone number
SELECT
    name,
    SUBSTR(phone, 1, 3) AS area_code,
    SUBSTR(phone, -4, 4) AS last_four
FROM customers
WHERE phone IS NOT NULL;

-- Get file extension
SELECT
    filename,
    SUBSTR(filename, -3, 3) AS extension
FROM documents
WHERE filename LIKE '%.%';

-- Extract initials
SELECT
    name,
    SUBSTR(first_name, 1, 1) || SUBSTR(last_name, 1, 1) AS initials
FROM employees;


-- Edge cases in Oracle
SELECT SUBSTR('Hi', 1, 10) AS left_long,   -- Returns: 'Hi' (doesn't error)
       SUBSTR('Hi', -10, 10) AS right_long  -- Returns: 'Hi' (doesn't error)
FROM DUAL;

-- Zero or negative length in Oracle
SELECT SUBSTR('Hello', 1, 0) AS zero_length,   -- Returns: NULL (empty in Oracle)
       SUBSTR('Hello', 1, -1) AS neg_length     -- Returns: NULL
FROM DUAL;

-- NULL handling in Oracle
SELECT SUBSTR(NULL, 1, 5) AS left_null,        -- Returns: NULL
       SUBSTR('Hello', NULL, 3) AS pos_null     -- Returns: NULL
FROM DUAL;

-- NULL HANDLING
-- =============
-- Oracle equivalent of ISNULL
-- SELECT name, NVL(column_name, 'no') FROM emp; -- handling null values

-- EXISTS/NOT EXISTS - CORRELATION
-- ===============================

-- Basic syntax remains same in Oracle
/*
SELECT columns
FROM table1 t1
WHERE condition AND EXISTS (
    SELECT columns
    FROM table2 t2
    WHERE t2.column = t1.column  -- This creates correlation
);
*/

SELECT orders.customer_id, order_date 
FROM orders
WHERE customer_id > 3 
  AND EXISTS (
        SELECT customer_id 
        FROM customers
        WHERE orders.customer_id = customers.customer_id
      );

SELECT orders.order_date 
FROM orders 
WHERE EXISTS (
    SELECT 1 
    FROM people 
    WHERE last_name = 'k'
);

SELECT emp_id, name, dept_id
FROM emp e
WHERE EXISTS (
    SELECT 1
    FROM departments d
    WHERE d.department_id = e.dept_id
);

SELECT emp_id, name, dept_id
FROM emp e
WHERE NOT EXISTS (
    SELECT 1
    FROM departments d
    WHERE d.department_id = e.dept_id
);

SELECT orders.order_date
FROM orders
WHERE NOT EXISTS (
    SELECT 1
    FROM people
    WHERE last_name = 'k'
);

-- Performance comparison examples (same in Oracle)
-- EXISTS (usually fastest for large datasets)
SELECT customer_id, customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id
);

-- IN (can be slower with large subquery results)
SELECT customer_id, customer_name
FROM customers c
WHERE customer_id IN (
    SELECT customer_id FROM orders WHERE customer_id IS NOT NULL
);

-- JOIN (good for retrieving additional columns)
SELECT DISTINCT c.customer_id, c.customer_name
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id;

-- Oracle Index creation syntax
CREATE INDEX idx_orders_customer_id ON orders(customer_id);
CREATE INDEX idx_employees_dept_id ON emp(dept_id);

-- Oracle covering index
CREATE INDEX idx_orders_cover ON orders(customer_id, order_date, total_amount);

SELECT * FROM emp;

-- Oracle DELETE with EXISTS
DELETE FROM emp e 
WHERE EXISTS (
    SELECT 1 
    FROM employees e2 
    WHERE EXTRACT(YEAR FROM e.hire_dt) < 2019
      AND e2.salary > e.salary
);

-- CONSTRAINTS - ORACLE COMPATIBLE
-- ==============================

-- TABLE 1 - Oracle equivalent
CREATE TABLE test_const(
    stud_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name NVARCHAR2(30) NOT NULL,
    email NVARCHAR2(320) UNIQUE NOT NULL,
    category NVARCHAR2(10) DEFAULT 'General'
);

-- VALID INSERTIONS for Oracle
-- Test 1: Basic valid insertion with all fields
INSERT INTO test_const (name, email, category)
VALUES ('John Doe', 'john.doe@example.com', 'Premium');

-- Test 2: Valid insertion using default category
INSERT INTO test_const (name, email)
VALUES ('Jane Smith', 'jane.smith@gmail.com');

-- Test 3: Valid insertion with maximum length name (30 characters)
INSERT INTO test_const (name, email, category)
VALUES ('Christopher Alexander John', 'chris.johnson@university.edu', 'Student');

-- Test 4: Valid insertion with long email (under 320 chars)
INSERT INTO test_const (name, email)
VALUES ('Bob Wilson', 'very.long.email.address.for.testing.maximum.length.constraints.in.database@example.com');

-- Test 5: Valid insertion with minimum length fields
INSERT INTO test_const (name, email)
VALUES ('A', 'a@b.co');

-- Test 6: Valid insertion with special characters in name
INSERT INTO test_const (name, email, category)
VALUES ('María José O''Connor-Smith', 'maria.jose@international.org', 'VIP');

-- Test 7: Valid insertion with plus sign in email
INSERT INTO test_const (name, email)
VALUES ('Test User', 'user+tag@example.com');

-- Test 8: Valid insertion with numbers in name
INSERT INTO test_const (name, email)
VALUES ('User123', 'user123@test.com');

-- Test 9: Valid insertion with category exactly 10 characters
INSERT INTO test_const (name, email, category)
VALUES ('Max Category', 'max.cat@test.com', 'Enterprise');

-- Test 10: Valid insertion with single character category
INSERT INTO test_const (name, email, category)
VALUES ('Min Category', 'min.cat@test.com', 'A');

-- Multiple records in Oracle
INSERT ALL
    INTO test_const (name, email, category) VALUES ('Batch User 1', 'batch1@test.com', 'Standard')
    INTO test_const (name, email, category) VALUES ('Batch User 2', 'batch2@test.com', 'Premium')
    INTO test_const (name, email, category) VALUES ('Batch User 3', 'batch3@test.com', 'Basic')
SELECT * FROM DUAL;

-- TABLE 2 - Composite Primary Key in Oracle
CREATE TABLE test_composite(
    stud_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    seat_no NUMBER,
    name VARCHAR2(30) NOT NULL,
    email VARCHAR2(320) UNIQUE NOT NULL,
    category VARCHAR2(10) DEFAULT 'General',
    CONSTRAINT pk_composite PRIMARY KEY (stud_id, seat_no)
);

-- TABLE 3 - Oracle equivalent with explicit constraint naming
CREATE TABLE test_explicit(
    stud_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    name VARCHAR2(30) NOT NULL,
    email VARCHAR2(320) UNIQUE NOT NULL,
    category VARCHAR2(10) DEFAULT 'General',
    CONSTRAINT pk_id PRIMARY KEY(stud_id)
);

-- Oracle equivalent to sp_help
-- Use USER_TABLES, USER_CONSTRAINTS, USER_CONS_COLUMNS for metadata
SELECT constraint_name, constraint_type, table_name
FROM user_constraints
WHERE table_name = 'TEST_EXPLICIT';

-- TABLE 4 - ALTER TABLE to add/drop constraints in Oracle
CREATE TABLE test_alterr(
    emp_id NUMBER
);

ALTER TABLE test_alterr ADD CONSTRAINT pk_id PRIMARY KEY(emp_id);

-- Check constraints in Oracle
SELECT constraint_name, constraint_type
FROM user_constraints
WHERE table_name = 'TEST_ALTERR' AND constraint_type = 'P';

ALTER TABLE test_alterr DROP CONSTRAINT pk_id;

-- TABLE 5 - Index organization in Oracle (different concept than SQL Server clustering)
CREATE TABLE test_indx(
    id NUMBER,
    prod_id NUMBER,
    CONSTRAINT pk PRIMARY KEY(id)
);

-- Oracle doesn't have clustered/non-clustered indexes like SQL Server
-- Instead, create regular indexes
CREATE INDEX idx_prod_id ON test_indx(prod_id);

CREATE TABLE test_cluster_equivalent(
    emp_id NUMBER,
    CONSTRAINT pk_emp_id PRIMARY KEY(emp_id)
);

-- FOREIGN KEYS in Oracle
-- ======================

-- Table 1: Harley Davidson bikes
CREATE TABLE harley_davidson(
    bike_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY
);

-- Table 2: Automobiles with bike reference
CREATE TABLE automobiles(
    car_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    bike_id NUMBER,
    CONSTRAINT fk_auto_bike FOREIGN KEY (bike_id) 
        REFERENCES harley_davidson(bike_id)
);

-- Table 3: Planes with car reference
CREATE TABLE planes(
    plane_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    CONSTRAINT p_id PRIMARY KEY(plane_id),
    car_id NUMBER,
    CONSTRAINT car FOREIGN KEY (car_id) 
        REFERENCES automobiles(car_id)
);

-- Table 4: Traffic with multiple references
CREATE TABLE traffic(
    plane_id NUMBER,
    car_id NUMBER,
    bike_id NUMBER,
    CONSTRAINT plane2 FOREIGN KEY (plane_id) 
        REFERENCES planes(plane_id),
    CONSTRAINT car2 FOREIGN KEY (car_id) 
        REFERENCES automobiles(car_id),
    CONSTRAINT bike2 FOREIGN KEY (bike_id) 
        REFERENCES harley_davidson(bike_id)
);

-- Table 5: Different cascade behaviors
CREATE TABLE del_null_update(
    plane_id NUMBER,
    car_id NUMBER,
    bike_id NUMBER,
    CONSTRAINT plane3 FOREIGN KEY (plane_id) 
        REFERENCES planes(plane_id)
        ON DELETE SET NULL,
    CONSTRAINT car3 FOREIGN KEY (car_id) 
        REFERENCES automobiles(car_id)
        ON DELETE CASCADE,  -- Oracle doesn't have NO ACTION, use CASCADE or SET NULL
    CONSTRAINT bike3 FOREIGN KEY (bike_id) 
        REFERENCES harley_davidson(bike_id)
        ON DELETE CASCADE
);

-- Table 6: Cascade with default
CREATE TABLE cascade_default(
    plane_id NUMBER,
    car_id NUMBER,
    bike_id NUMBER,
    CONSTRAINT plane23 FOREIGN KEY (plane_id) 
        REFERENCES planes(plane_id)
        ON DELETE CASCADE
);

-- CHECK CONSTRAINTS in Oracle
-- ===========================
CREATE TABLE employees_check (
    emp_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name NVARCHAR2(100),
    age NUMBER,
    salary NUMBER(10,2),
    gender CHAR(1),
    email NVARCHAR2(100),
    CONSTRAINT chk_age CHECK (age BETWEEN 18 AND 65),
    CONSTRAINT chk_salary CHECK (salary > 0),
    CONSTRAINT chk_gender CHECK (gender IN ('M', 'F', 'O')),
    CONSTRAINT chk_email CHECK (email LIKE '%@%.%')
);

-- Oracle regex check constraint for phone numbers
CREATE TABLE phone_numbers (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    phone NVARCHAR2(15),
    CONSTRAINT chk_phone_format 
        CHECK (REGEXP_LIKE(phone, '^[0-9]{3}-[0-9]{3}-[0-9]{4}$'))
);

-- UNIQUE CONSTRAINTS in Oracle
-- ============================

-- Single column unique
CREATE TABLE users_unique (
    user_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    username NVARCHAR2(50) UNIQUE,
    email NVARCHAR2(100) UNIQUE
);

-- Composite unique constraint
CREATE TABLE user_profiles (
    profile_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    user_id NUMBER,
    platform NVARCHAR2(50),
    profile_name NVARCHAR2(100),
    CONSTRAINT uk_user_platform UNIQUE (user_id, platform)
);

-- Unique constraint with function-based index (Oracle equivalent)
CREATE TABLE products_unique (
    product_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    sku NVARCHAR2(50),
    product_name NVARCHAR2(100),
    category_id NUMBER,
    CONSTRAINT uk_product_sku UNIQUE (sku)
);

-- Function-based unique index allowing NULLs (Oracle style)
CREATE TABLE employees_unique(
    emp_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    ssn NVARCHAR2(11),
    name NVARCHAR2(100)
);

-- Oracle function-based index to allow multiple NULLs but unique non-NULLs
CREATE UNIQUE INDEX uk_employees_ssn 
ON employees_unique(CASE WHEN ssn IS NOT NULL THEN ssn END);

-- Add/Drop unique constraints in Oracle
ALTER TABLE users_unique ADD CONSTRAINT uk_email_new UNIQUE (email);
ALTER TABLE users_unique DROP CONSTRAINT uk_email_new;

-- Oracle-specific constraint management
-- Enable/Disable constraints (Oracle equivalent to NOCHECK/CHECK)
ALTER TABLE employees_check DISABLE CONSTRAINT chk_age;
ALTER TABLE employees_check ENABLE CONSTRAINT chk_age;

-- Disable all constraints on a table
BEGIN
    FOR c IN (SELECT constraint_name FROM user_constraints WHERE table_name = 'EMPLOYEES_CHECK' AND constraint_type IN ('C','P','U','R')) LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE employees_check DISABLE CONSTRAINT ' || c.constraint_name;
    END LOOP;
END;


-- Enable all constraints on a table
BEGIN
    FOR c IN (SELECT constraint_name FROM user_constraints WHERE table_name = 'EMPLOYEES_CHECK' AND constraint_type IN ('C','P','U','R')) LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE employees_check ENABLE CONSTRAINT ' || c.constraint_name;
    END LOOP;
END;


-- Oracle sequence management (equivalent to IDENTITY concepts)
-- Create sequence manually if needed
CREATE SEQUENCE test_seq START WITH 1 INCREMENT BY 1;

-- Use in INSERT
INSERT INTO some_table (id, name) VALUES (test_seq.NEXTVAL, 'Test');

-- Get current value
SELECT test_seq.CURRVAL FROM DUAL;
```
