select datname from pg_database where datistemplate = false;


-- ✅ Create table
CREATE TABLE trail (
    name VARCHAR(20),
    id INTEGER
);

-- ✅ Insert data
INSERT INTO trail (name, id)
VALUES 
    ('awwru', 101),
    ('mitch', 2);

-- ✅ View table contents
SELECT * FROM trail;

-- ✅ Add new column
ALTER TABLE trail
ADD COLUMN city VARCHAR(10);

-- ✅ Modify column type
ALTER TABLE trail
ALTER COLUMN city TYPE TEXT;

-- ✅ Rename column
ALTER TABLE trail
RENAME COLUMN city TO shaher;

-- ✅ Modify renamed column to text
ALTER TABLE trail
ALTER COLUMN shaher TYPE TEXT;

-- ✅ Rename table
ALTER TABLE trail
RENAME TO detrail;

-- ✅ Drop column
ALTER TABLE detrail
DROP COLUMN shaher;

-- ✅ Truncate table
TRUNCATE TABLE detrail;

-- ✅ Drop table
DROP TABLE detrail;

-- ✅ Drop database (run from another database, not inside the one being dropped)
-- DROP DATABASE your_database_name;

-- ✅ Show all databases
SELECT datname FROM pg_database WHERE datistemplate = false;

-- ✅ Show all tables in current DB
SELECT table_name FROM information_schema.tables
WHERE table_schema = 'public';

Here are only the **valid commands you executed and their successful outputs**, **without errors** or incomplete blocks:

---

### ✅ Connect to database

```sql
\connect prac;
```

**Output:**

```
You are now connected to database "prac" as user "postgres114".
```

---

### ✅ Create table `trail`

```sql
CREATE TABLE trail (
    name VARCHAR(20),
    id INTEGER
);
```

**Output:**

```
CREATE TABLE
```

---

### ✅ Insert data into `trail`

```sql
INSERT INTO trail (name, id)
VALUES 
    ('awwru', 101),
    ('mitch', 2);
```

**Output:**

```
INSERT 0 2
```

---

### ✅ View contents of `trail`

```sql
SELECT * FROM trail;
```

**Output:**

```
 name  | id  
-------+-----
 awwru | 101
 mitch |   2
```

---

### ✅ Add column `city`

```sql
ALTER TABLE trail
ADD COLUMN city VARCHAR(10);
```

**Output:**

```
ALTER TABLE
```

---

### ✅ Change `city` column type to `TEXT`

```sql
ALTER TABLE trail
ALTER COLUMN city TYPE TEXT;
```

**Output:**

```
ALTER TABLE
```

---

### ✅ Rename column `city` to `shaher`

```sql
ALTER TABLE trail
RENAME COLUMN city TO shaher;
```

**Output:**

```
ALTER TABLE
```

---

### ✅ Rename table `trail` to `detrail`

```sql
ALTER TABLE trail
RENAME TO detrail;
```

**Output:**

```
ALTER TABLE
```

---

### ✅ Truncate table

```sql
TRUNCATE TABLE detrail;
```

**Output:**

```
TRUNCATE TABLE
```

---

### ✅ Drop table

```sql
DROP TABLE detrail;
```

**Output:**

```
DROP TABLE
```

---

### ✅ View list of databases

```sql
SELECT datname FROM pg_database WHERE datistemplate = false;
```

**Output:**

```
  datname   
------------
 postgres
 mydatabase
 ai
 prac
```

---

### ✅ Show all tables in current DB

```sql
SELECT table_name FROM information_schema.tables
WHERE table_schema = 'public';
```

**Output (after re-creating table):**

```
 table_name 
------------
 tt
 trail
```

---

### ✅ Create indexes

```sql
CREATE INDEX indx ON detrail(id);
CREATE UNIQUE INDEX u_indx ON detrail(city);
CREATE INDEX indxs ON detrail(name, id, city);
```

**Output:**

```
CREATE INDEX
CREATE INDEX
CREATE INDEX
```

---

### ✅ Create a view

```sql
CREATE VIEW obs AS
SELECT name, id, city FROM detrail WHERE id != 0;
```

**Output:**

```
CREATE VIEW
```

---

### ✅ Select from the view

```sql
SELECT * FROM obs;
```

**Output:**

```
 name  | id  | city 
-------+-----+------
 awwru | 101 | 
 mitch |   2 | 
 awwru | 101 | 
 mitch |   2 | 
```

---

### ✅ Drop and re-create schema

```sql
CREATE SCHEMA us;
DROP SCHEMA us CASCADE;
CREATE SCHEMA us;
```

**Output:**

```
CREATE SCHEMA
DROP SCHEMA
CREATE SCHEMA
```

---

### ✅ Add comment on column

```sql
COMMENT ON COLUMN detrail.id IS 'usr id';
```

**Output:**

```
COMMENT
```

---

### ✅ Create sequence and table using sequence

```sql
CREATE SEQUENCE id_seq START 10;

CREATE TABLE test_int (
    id INT PRIMARY KEY DEFAULT nextval('id_seq'),
    active SMALLINT NOT NULL,
    ageid SMALLINT DEFAULT 0,
    days INTEGER,
    rankk BIGINT
);
```

**Output:**

```
CREATE SEQUENCE
CREATE TABLE
```

---

### ✅ Insert data into `test_int`

```sql
INSERT INTO test_int (active, ageid, rankk) VALUES
(1, 10, 1001), (0, 11, 1002), (1, 12, 1003), (0, 13, 1004),
(1, 14, 1005), (1, 15, 1006), (0, 16, 1007), (1, 17, 1008),
(0, 18, 1009), (1, 19, 1010), (1, 20, 1011), (0, 21, 1012),
(1, 22, 1013), (0, 23, 1014), (1, 24, 1015), (1, 25, 1016),
(0, 26, 1017), (1, 27, 1018), (0, 28, 1019), (1, 29, 1020);
```

**Output:**

```
INSERT 0 20
```

---

### ✅ Update using `CASE`

```sql
UPDATE test_int
SET days = CASE 
    WHEN id = 10 THEN ageid * 365
    WHEN id = 11 THEN ageid * 365
    WHEN id = 12 THEN ageid * 365
    WHEN id = 13 THEN ageid * 365
    ELSE days
END;
```

**Output:**

```
UPDATE 20
```

---

### ✅ Update using DO block and loop

```sql
DO $$
BEGIN
FOR i IN 14..20 LOOP
    UPDATE test_int SET days = ageid * 365 WHERE id = i;
END LOOP;
END $$;
```

**Output:**

```
DO
```

---

### ✅ Insert valid test rows with big integers

```sql
INSERT INTO test_int (active, ageid, days, rankk)
VALUES 
(0, 199, 3680, 1001),
(0, 19, 36875, 1065756578541);
```

**Output:**

```
INSERT 0 1
INSERT 0 1
```

---

### ✅ Delete rows using DO block

```sql
DO $$
BEGIN 
    FOR i IN 11..30 LOOP
        DELETE FROM test_int WHERE id = i;
    END LOOP;
END $$;
```

**Output:**

```
DO
```

---

### ✅ Final table content check

```sql
SELECT * FROM test_int;
```

**Output:**

```
 id | active | ageid | days  |     rankk     
----+--------+-------+-------+---------------
 10 |      1 |    10 |  3650 |          1001
 31 |      0 |    19 | 36875 | 1065756578541
```

---

Let me know if you want a cleaned `.sql` script of all these correct commands.


-- Basic queries (case-sensitive table/column names if created with quotes)
SELECT * FROM ai_models;  -- or "AI_models" if created with mixed case
SELECT * FROM ai_models WHERE name LIKE '%n%';
SELECT * FROM ai_models WHERE desp LIKE '%less%';
SELECT * FROM ai_models WHERE desp LIKE '%more%';
SELECT * FROM ai_models WHERE desp LIKE 'Meta%';

-- String literals and escaping
SELECT 'test', '"test"', '""test""', 'te''st';
SELECT 'They''ve found this tutorial to be helpful';
SELECT 'They''ve responded, "We found this tutorial helpful"';

-- PostgreSQL alternative: use $$ for complex strings
SELECT $$They've responded, "We found this tutorial helpful"$$;

-- Case-insensitive search option
SELECT * FROM ai_models WHERE name ILIKE '%n%';

postgres=# select $$They've responded ,in a good's "hahaa way"$$;
                  ?column?                  
--------------------------------------------
 They've responded ,in a good's "hahaa way"
(1 row)
