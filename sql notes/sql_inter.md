Here’s a polished **README-style guide** drafted in Markdown that integrates your `test_int`, `test_float`, `test_text`, and related SQL code examples and also highlights how to handle **double quotes (`"`)**, **single quotes (`'`)**, and **escaping** within your SQL statements.

---

# README.md — SQL Sample Guide

## Overview

This guide demonstrates key SQL operations using sample tables—`test_int`, `test_float`, `test_text`, and others. It also explores quoting techniques (`"`, `'`) and escaping special characters clearly and concisely.

---

## 1. Table Definitions & Sample Inserts

```sql
-- Integer-based table with various numeric types
CREATE TABLE test_int (
  id INT PRIMARY KEY AUTO_INCREMENT,
  active TINYINT NOT NULL,
  ageid SMALLINT ZEROFILL DEFAULT 0,
  days MEDIUMINT,
  rankk BIGINT
) AUTO_INCREMENT = 10;

SET @auto_increment_increment = 1;
```

You can then populate and manipulate the data:

```sql
DESC test_int;
INSERT INTO test_int (active, ageid, rankk) VALUES (1, 10, 1001), (0, 11, 1002), … ;
SELECT * FROM test_int;

-- Conditionally calculate days for specific rows:
UPDATE test_int
  SET days = CASE
    WHEN id BETWEEN 10 AND 13 THEN ageid * 365
    ELSE days
  END
  WHERE id < 14;

UPDATE test_int
  SET days = ageid * 365
  WHERE id BETWEEN 14 AND 29;
```

---

## 2. Handling Out-of-Range Inserts

```sql
-- Works fine with valid values:
INSERT INTO test_int (active, ageid, days, rankk) VALUES (0, 199, 3680, 1001);

-- Fails due to TINYINT overflow:
-- INSERT INTO test_int (… ) VALUES (0896, 199, 3680, 1001);

-- BIGINT overflow can also cause a truncation error:
-- … 10657565785756875741 … causes error

-- Fine within range:
INSERT INTO test_int (active, ageid, days, rankk) VALUES (0, 19, 36875, 1065756578541);
```

---

## 3. Working with Floating-Point Types

```sql
CREATE TABLE test_float (
  id INT PRIMARY KEY AUTO_INCREMENT,
  salary DECIMAL(7,4) NOT NULL,
  litre FLOAT(5),
  pi DOUBLE
) AUTO_INCREMENT = 10;

ALTER TABLE test_float MODIFY salary DECIMAL(10,4);

INSERT INTO test_float (salary, litre, pi) VALUES
  (1234.5678, 10.5, 3.14159265),
  (2345.6789, 20.2, 3.14),
  …,
  (10123.4567, 13.8, 3.15);
```

IMPORTANT: Inserts like the following succeed but **get truncated**:

```sql
INSERT INTO test_float (salary, litre, pi)
VALUES (123.4567, 12.3, 3.141592653589793238462643383279);
```

---

## 4. Text and Large Object Types

```sql
CREATE TABLE test_text (
  id INT PRIMARY KEY,
  desp TINYTEXT,
  name VARCHAR(120),
  article TEXT,
  synopsys MEDIUMTEXT,
  book LONGTEXT
);

INSERT INTO test_text (…) VALUES (
  4,
  REPEAT('A', 255),
  'Example Book',
  REPEAT('B', 65535),
  REPEAT('C', 16777215),
  REPEAT('D', 1000000)
);
SELECT * FROM test_text;
```

---

## 5. Quotes & Escaping Techniques

Demonstrating string literals with quotes and correct escaping:

```sql
-- Simple string with double quotes
SELECT 'He said, "Hello, world!"';

-- Single quotes inside double-quoted string
SELECT "It's a bright day";

-- Double quotes escaped in double-quoted string
SELECT "She replied, ""Indeed it is!""";

-- Single quotes escaped by doubling
SELECT 'O''Reilly';

-- Backslash used for complex mix of quotes
SELECT 'They\'ve responded, "We found this tutorial helpful"';

-- Complex example combining both escapes:
SELECT 'Code said: "That''s not what she meant," he explained';
```

### Why Doubling Works

The common and reliable way to escape single quotes is to **double them** (`''`), which is supported across MySQL, PostgreSQL, Oracle, and SQL Server. For example:

```sql
INSERT INTO customer (customer_name) VALUES ('Lay''s');
```

This ensures that the embedded single quote is interpreted correctly as part of the string. ([LearnSQL][1], [GeeksforGeeks][2])

---

## 6. Summary Table — Quoting Strategies

| Scenario                           | Example                  |
| ---------------------------------- | ------------------------ |
| Double quotes inside single-quoted | `'He said, "Hello!"'`    |
| Single quote inside double-quoted  | `"It's sunny"`           |
| Escaping single quote              | `'O''Reilly'`            |
| Escaping double quotes in double   | `"She replied, ""Yes"""` |
| Mixed quoting with backslash       | `'They\'ve said "Hi"'`   |

---


You're working with MySQL here, and it's absolutely crucial to understand the difference between **straight ASCII apostrophes (`'`, U+0027)** and **curly (typographic) apostrophes (`’`, U+2019)**—especially when performing queries like `LIKE`. They are **not the same** in MySQL, so `'Meta's%'` won’t match text containing `’` unless you correctly normalize your data or query.

---

### Why This Matters

Certain editors or copy–paste actions (from Word, for example) introduce curly apostrophes. If your database stores `desp` values with `’`, but your query uses `'`, like patterns won't match because the characters differ at the byte level.

---

### Techniques You Can Use

1. **Use `REPLACE()` in the query** to replace curly apostrophes before applying pattern matching:

   ```sql
   SELECT * FROM AI_models
   WHERE REPLACE(desp, '’', '''') LIKE '%Meta''s%';
   ```

2. MySQL handles backslash escape sequences too, so this variant also works:

   ```sql
   SELECT * FROM AI_models
   WHERE REPLACE(desp, '’', '''') LIKE '%Meta\'s%';
   ```

   These approaches ensure `’` is treated as `'` during comparison.

3. **Consider normalizing data at insert/update**, either by converting curly to straight apostrophes or adding a computed column for searchable data. This helps with performance and avoids costly `REPLACE()` evaluations in every query.([Database Administrators Stack Exchange][1])

4. **When dealing with smart quotes or other typographic punctuation**, tools exist to convert them. For instance, you can update text columns in MySQL by replacing UTF-8 hex codes with straight equivalents:

   ```sql
   UPDATE t SET c = REPLACE(c, 0xE28099, "'");
   ```

   This is particularly useful when dealing with UTF-8 encoded curly quotes.([Toao][2])

---

### Summary Table

| Situation                 | Solution                                                                                |
| ------------------------- | --------------------------------------------------------------------------------------- |
| Curly apostrophe in data  | Use `REPLACE(desp, '’', '''')` in queries or normalize data upon insertion/update       |
| Performance concerns      | Normalize once (or computed indexed column), avoid `REPLACE()` in every query           |
| Multiple smart characters | Use mass replacements targeting their UTF-8 or Windows-1252 codes in MySQL or app layer |

---

Let me know if you'd like an example implementation of data normalization or indexing strategies for better performance!

[1]: https://dba.stackexchange.com/questions/150899/matching-left-and-right-single-quotes-used-as-apostophes?utm_source=chatgpt.com "Matching left and right single-quotes used as apostophes"
[2]: https://toao.net/Software_Dev/replacing-smart-quotes-and-em-dashes-in-mysql.html?utm_source=chatgpt.com "Replacing smart quotes, em-dashes, and ellipses with MySQL or PHP"
