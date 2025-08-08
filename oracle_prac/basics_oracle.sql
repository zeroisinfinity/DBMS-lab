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
SELECT 'test', '"test"', '""test""', 'te''st' FROM dual;
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

