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
SELECT q'[They've responded, "We found this tutorial helpful"]' FROM dual;

-- Case-insensitive search options
SELECT * FROM AI_MODELS WHERE UPPER(NAME) LIKE UPPER('%n%');
-- Or use REGEXP_LIKE for more complex patterns
SELECT * FROM AI_MODELS WHERE REGEXP_LIKE(NAME, 'n', 'i'); '

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