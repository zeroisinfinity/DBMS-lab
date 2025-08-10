# SQL Date & Time Data Types and Functions in MySQL, SQL Server (MSSQL), and PostgreSQL

Below is a practical, side-by-side guide to date/time data types, how they're stored and used in real systems, and the most important built-in functions for each database engine.

## MySQL

### Core data types
- **DATE**: Calendar date only; range 1000-01-01 to 9999-12-31.[1][2][3]
- **TIME**: Time of day or elapsed time; supports fractional seconds.[4][1]
- **DATETIME(fsp)**: Date+time; range 1000-01-01 00:00:00 to 9999-12-31 23:59:59, supports fractional seconds up to 6 digits via fsp.[2][3][1]
- **TIMESTAMP(fsp)**: Date+time stored in UTC and converted to session time zone; range roughly 1970-01-01 to 2038-01-19; supports fractional seconds.[5][1][2]
- **YEAR**: 4-digit year; legacy, specific use cases.[1]

**Key differences:**
- DATETIME stores the value "as-is" (no time zone conversion), while TIMESTAMP stores in UTC and converts on retrieval, making TIMESTAMP preferable for audit columns across time zones.[5][1]
- Fractional seconds supported for TIME/DATETIME/TIMESTAMP up to microseconds with fsp 0–6.[1]

**Real-world patterns:**
- Use TIMESTAMP DEFAULT CURRENT_TIMESTAMP and ON UPDATE CURRENT_TIMESTAMP for created_at/updated_at auditing; use DATETIME for business dates that must not shift with time zones (e.g., event schedules).[6][5][1]

### Essential functions
- **CURRENT_DATE, CURRENT_TIME, CURRENT_TIMESTAMP / NOW**: current date/time.[6]
- **DATE(), TIME()**: extract date or time part.[6]
- **DATE_ADD/DATE_SUB, ADDDATE/SUBDATE**: arithmetic with INTERVALs (e.g., DAY, MONTH).[6]
- **TIMESTAMPDIFF, TIMESTAMPADD**: difference or addition in specific units.[6]
- **EXTRACT(unit FROM ts), YEAR(), MONTH(), DAY(), HOUR(), MINUTE(), SECOND()**: field extraction.[6]
- **STR_TO_DATE, DATE_FORMAT, TIME_FORMAT**: parsing and formatting.[6]

**Notes:**
- MySQL supports several literal formats and automatic initialization/updating for TIMESTAMP/DATETIME columns; understand the zero date behavior when strict SQL mode is off.[2][1][6]
- Fractional seconds must be enabled via column definition fsp to preserve microseconds.[1][6]

References:[3][7][4][2][5][1][6]

## SQL Server (Microsoft SQL Server / T‑SQL)

### Core data types
- **DATE**: Date only; 0001-01-01 to 9999-12-31.[8][9]
- **TIME(p)**: Time-only with 0–7 fractional seconds; 00:00:00.0000000 to 23:59:59.9999999.[9]
- **DATETIME**: Legacy; 1753-01-01 to 9999-12-31 with .000, .003, .007 ms rounding; avoid for new work.[8]
- **DATETIME2(p)**: Preferred modern date-time; 0001-01-01 through 9999-12-31 with 0–7 fractional seconds.[9][8]
- **DATETIMEOFFSET(p)**: DATETIME2 with time zone offset; ideal for cross-time-zone apps.[8][9]
- **SMALLDATETIME**: Legacy; minute precision, limited range; avoid for high-precision needs.[8]

**Real-world patterns:**
- Prefer DATETIME2 for most precise timestamping; use DATETIMEOFFSET for multi-time-zone apps and APIs.[9][8]
- Use DATE for business-effective dates; TIME for schedules or opening hours.[8]

### Essential functions
- **SYSDATETIME(), SYSUTCDATETIME(), GETDATE(), GETUTCDATE()**: current times; SYSDATETIME/SYSUTCDATETIME offer higher precision than GETDATE/GETUTCDATE.[8]
- **DATEADD, DATEDIFF, DATEDIFF_BIG, DATENAME, DATEPART**: arithmetic and extraction.[8]
- **SWITCHOFFSET, TODATETIMEOFFSET**: convert between offsets for DATETIMEOFFSET.[8]
- **CONVERT/CAST** with style codes; and ISO 8601 parsing "yyyy-mm-ddThh:mm:ss.nnnnnn" recommended.[9]

**Notes:**
- Use ISO 8601 formats to avoid ambiguity; beware regional dateformat settings when parsing strings.[9]
- DATETIME rounding may surprise; prefer DATETIME2 for accuracy.[8]

References:[9][8]

## PostgreSQL

### Core data types
- **DATE**: Calendar date; very wide range; stored in 4 bytes.[10][11][12]
- **TIME [WITHOUT TIME ZONE]** and **TIME WITH TIME ZONE**: Time of day; microsecond resolution.[11][10]
- **TIMESTAMP WITHOUT TIME ZONE**: Date+time without time zone semantics.[10][11]
- **TIMESTAMP WITH TIME ZONE (TIMESTAMPTZ)**: Date+time with time zone rules; stored internally in UTC but displayed in client's time zone.[10]
- **INTERVAL**: Duration type; supports months/years down to microseconds.[11][10]

**Key differences:**
- TIMESTAMPTZ is the standard choice for event logs and cross-region systems, since storage is UTC and presentation follows client timezone; TIMESTAMP (without time zone) is for "wall clock" times where no conversion should occur.[10]
- Special literals like epoch, infinity, -infinity, and now are supported and extremely useful in modeling.[10]

**Real-world patterns:**
- Use TIMESTAMPTZ for audit, ingestion, job scheduling across time zones; DATE for business-effective dates; INTERVAL for SLAs and durations; TIME for opening hours.[10]
- Npgsql/.NET mapping: UTC DateTime maps to timestamptz; local/unspecified DateTime maps to timestamp by default, important for application code correctness.[13]

### Essential functions and operators
- **NOW(), CURRENT_DATE, CURRENT_TIME, CURRENT_TIMESTAMP, LOCALTIMESTAMP**.[10]
- **AGE(ts[, ts2])**: human-friendly interval difference; **JUSTIFY_INTERVAL**: normalize intervals.[10]
- **date + interval, timestamp ± interval**: arithmetic using INTERVALs.[10]
- **EXTRACT(field FROM source), DATE_TRUNC('unit', ts)**: extraction and floor to unit.[10]
- **AT TIME ZONE**: convert between timestamp types and time zones.[10]

**Notes:**
- PostgreSQL accepts diverse ISO-like literals and supports microsecond resolution broadly.[10]
- TIMESTAMPTZ does not store the original time zone, only UTC value; display depends on client setting.[10]

References:[12][13][11][10]

## Choosing the right type (cross-DB guidance)

### Audit columns and cross-time-zone logs:
- **MySQL**: TIMESTAMP (watch 2038 limit) or DATETIME with explicit UTC discipline; TIMESTAMP auto-UTC conversion helps.[5][1]
- **SQL Server**: DATETIMEOFFSET for explicit offsets; or DATETIME2 with application-level UTC convention.[9][8]
- **PostgreSQL**: TIMESTAMPTZ as default choice.[10]

### Business dates that must not shift (holidays, rate-effective dates, event local start time):
Use DATE or TIMESTAMP/DATETIME without time zone semantics:
- **MySQL**: DATE or DATETIME.[2][1]
- **SQL Server**: DATE or DATETIME2.[9][8]
- **PostgreSQL**: DATE or TIMESTAMP (without time zone).[10]

### Durations and SLAs:
- **PostgreSQL**: INTERVAL is first-class.[11][10]
- **MySQL/SQL Server**: represent durations with INT/NUMERIC seconds or TIME where suitable; do arithmetic in queries or application.

### High precision:
- **MySQL**: define fsp up to 6 on TIME/DATETIME/TIMESTAMP.[1][6]
- **SQL Server**: DATETIME2/TIME with scale up to 7; prefer SYSDATETIME().[9][8]
- **PostgreSQL**: microsecond resolution across types.[10]

## "Gotchas" and best practices

### MySQL:
- TIMESTAMP range ends in 2038 for 32-bit-epoch-based storage; for far-future timestamps prefer DATETIME.[2][5]
- Be explicit with fsp if microseconds matter; default may drop precision.[1][6]
- TIMESTAMP uses session time_zone on insert/select; standardize time_zone in connections for consistency.[5][1]

### SQL Server:
- Avoid DATETIME for new designs due to limited precision and rounding; prefer DATETIME2/DATETIMEOFFSET.[8]
- Always feed ISO 8601 strings to avoid ambiguous dates; regional settings can alter interpretation of "numeric" formats.[9]

### PostgreSQL:
- Understand TIMESTAMP vs TIMESTAMPTZ semantics; TIMESTAMPTZ stores UTC but does not retain original zone name/offset.[10]
- Use DATE_TRUNC for bucketing; AGE vs simple subtraction return different interval semantics (calendar-aware vs exact).[10]

## Quick examples

### MySQL: Created/Updated audit with time zone safety
```sql
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
```

### SQL Server: High-precision created UTC and local view
```sql
created_at DATETIME2(7) DEFAULT SYSUTCDATETIME()
-- Present to users by converting to local time zone as needed with AT TIME ZONE/SWITCHOFFSET
```

### PostgreSQL: Event stored in UTC, grouped by hour
```sql
created_at TIMESTAMPTZ DEFAULT now();
SELECT date_trunc('hour', created_at) AS hour_bucket, count(*) 
FROM events 
GROUP BY 1;
```

---

# SQL Server date/time types: definitive table, inserts, and function usage

Below is a practical, self-contained T‑SQL walkthrough for Microsoft SQL Server that you can paste into SSMS: it creates a demo table covering every date/time type, inserts representative rows (including edge cases), and then runs queries demonstrating the most important functions and behaviors.

All facts about ranges, precision, and recommendations are cited inline.

## 1) Create a solid demo table covering all SQL Server date/time types

Types and ranges:
- **DATE** stores only the calendar date; range 0001‑01‑01 to 9999‑12‑31.[1]
- **TIME(p)** stores only time with 0–7 fractional seconds; range 00:00:00.0000000–23:59:59.9999999.[2][3]
- **DATETIME** is legacy; range 1753‑01‑01 to 9999‑12‑31, rounds to .000, .003, or .007ms; avoid for new work.[4][5][1]
- **DATETIME2(p)** is the modern replacement; range 0001‑01‑01 to 9999‑12‑31 with 0–7 fractional seconds, 100ns accuracy.[3][2]
- **DATETIMEOFFSET(p)** adds an explicit time zone offset to DATETIME2.[1]
- **SMALLDATETIME** is legacy, minute precision, smaller range and precision.[1]

```sql
-- Clean slate
IF OBJECT_ID('dbo.DateTimePlayground', 'U') IS NOT NULL
    DROP TABLE dbo.DateTimePlayground;
GO

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
GO
```

## 2) Insert representative data (valids, edge cases, and precision tests)

- **DATETIME** rounds to .000/.003/.007; **DATETIME2** preserves precision up to 7 fractional digits.[5][3][4]
- **DATETIMEOFFSET** stores the offset together with the timestamp.[1]
- **TIME** supports up to 7 fractional seconds.[2][3]

```sql
-- Insert a "typical" row
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
INSERT INTO dbo.DateTimePlayground
(only_date, only_time_7, legacy_datetime, modern_dt2_7, with_offset_7, small_dt)
VALUES
('0001-01-01', '12:00:00', '2000-01-01T12:00:00', '0001-01-01T12:00:00.0000000', '2000-01-01T12:00:00.0000000 -14:00', '2000-01-01T12:00'),
('9999-12-31', '12:00:00', '2020-06-15T08:30:00.123', '9999-12-31T12:00:00.9999999', '2020-06-15T08:30:00.1230000 +14:00', '2020-06-15T08:30');
GO

SELECT * FROM dbo.DateTimePlayground ORDER BY id;
```

## 3) Essential date/time functions in action (with patterns)

- **Current time functions**: SYSDATETIME/SYSUTCDATETIME (high precision), GETDATE/GETUTCDATE (lower precision).[6]
- **Arithmetic/extraction**: DATEADD, DATEDIFF, DATEDIFF_BIG, DATEPART, DATENAME, EOMONTH.[7][8][6]
- **Offset conversion**: SWITCHOFFSET, TODATETIMEOFFSET.[6]
- **Parsing/formatting**: CAST/CONVERT; prefer ISO 8601 strings to avoid ambiguity.[4][2][6]

```sql
-- 3.1 Current date/time (note precision differences)
SELECT
    GETDATE()          AS getdate_low_precision,      -- legacy datetime precision [12][3]
    GETUTCDATE()       AS getutcdate_low_precision,   -- UTC, legacy precision [12]
    SYSDATETIME()      AS sysdatetime_high_precision, -- datetime2 precision [12]
    SYSUTCDATETIME()   AS sysutcdatetime_high_precision; -- UTC, datetime2 precision [12]
GO

-- 3.2 Extract parts and human-friendly names
DECLARE @d2 datetime2(7) = '2025-08-09T22:36:45.9876543';
SELECT
    DATEPART(year,  @d2)    AS part_year,     -- integer part [12][7]
    DATEPART(month, @d2)    AS part_month,
    DATEPART(day,   @d2)    AS part_day,
    DATEPART(hour,  @d2)    AS part_hour,
    DATEPART(minute,@d2)    AS part_minute,
    DATEPART(second,@d2)    AS part_second,
    DATENAME(weekday,@d2)   AS name_weekday,  -- textual name [12][7]
    DATENAME(month,  @d2)   AS name_month;
GO

-- 3.3 Date math: add/subtract and differences
DECLARE @start datetime2(7) = '2025-01-01T00:00:00';
DECLARE @end   datetime2(7) = '2025-08-09T22:36:45.9876543';

SELECT
    DATEADD(day, 7, @start)                       AS plus_7_days,          -- add 7 days [12][7]
    DATEADD(minute, -90, @end)                    AS minus_90_minutes,     -- subtract 90 minutes [12][7]
    DATEDIFF(day, @start, @end)                   AS diff_days,            -- whole days difference [12][7]
    DATEDIFF_BIG(second, @start, @end)            AS diff_seconds_big;     -- bigint seconds [12][7]
GO

-- 3.4 Month bucketing and month-end
DECLARE @any date = '2025-08-09';
SELECT
    EOMONTH(@any)          AS end_of_this_month,                -- end of month [12][7]
    EOMONTH(@any, -1)      AS end_of_previous_month,            -- month offset [12][7]
    DATEFROMPARTS(2025, 8, 1) AS first_of_month_by_parts;       -- construct date from parts [12]
GO

-- 3.5 ISO 8601 parsing (recommended to avoid regional ambiguity)
-- Use unambiguous ISO strings: 'YYYY-MM-DDTHH:MM:SS[.fffffff][Z|{+|-}HH:MM]'
SELECT
    CAST('2025-08-09T22:36:45.9876543' AS datetime2(7)) AS parsed_dt2,      -- precise [3][12]
    CAST('2025-08-09T22:36:45+05:30'   AS datetimeoffset(7)) AS parsed_dto; -- with offset [12]
GO

-- 3.6 Working with time zones: convert offsets and attach an offset
DECLARE @utc_dt2 datetime2(7) = SYSUTCDATETIME();               -- UTC now [12]
-- Attach an offset (assume @utc_dt2 represents UTC time) to get a datetimeoffset value
SELECT TODATETIMEOFFSET(@utc_dt2, '+00:00')       AS utc_as_offset,        -- attach offset [12]
       SWITCHOFFSET(TODATETIMEOFFSET(@utc_dt2, '+00:00'), '+05:30') AS in_india_offset; -- convert [12]
GO

-- 3.7 Legacy behaviors and recommendations
-- DATETIME rounds fractions; DATETIME2 preserves precision
DECLARE @rd datetime      = '2024-08-06 18:34:10.233';           -- 3-digit precision, rounds 0/3/7 ms [3][13]
DECLARE @r2 datetime2(7)  = '2024-08-06 18:34:10.2333333';       -- 7-digit precision [10]
SELECT @rd AS legacy_datetime_rounded, @r2 AS dt2_precise;

-- DATETIME supports adding integers; DATETIME2 does not (use DATEADD)
DECLARE @dt  datetime     = GETDATE();
DECLARE @dt2 datetime2(7) = SYSDATETIME();
SELECT @dt  + 1 AS dt_plus_one_day;                               -- works for DATETIME (legacy) [8][3]
-- SELECT @dt2 + 1; -- would error: use DATEADD instead
SELECT DATEADD(day, 1, @dt2) AS dt2_plus_one_day;                 -- preferred modern pattern [12]
GO
```

## 4) Query examples over the demo table for real-world tasks

- **Use DATE for business-effective dates; TIME for schedules/opening hours.**[1]
- **Prefer DATETIME2 for precise timestamping; DATETIMEOFFSET for multi‑time‑zone apps/APIs.**[2][1]

```sql
-- 4.1 Daily buckets of rows (DATE is ideal for grouping by business day)
SELECT only_date, COUNT(*) AS rows_per_day
FROM dbo.DateTimePlayground
GROUP BY only_date
ORDER BY only_date;
-- DATE groups business-effective days cleanly [1]

-- 4.2 Build schedule strings from TIME (presentation)
SELECT id,
       only_time_7,
       DATENAME(hour,  only_time_7)   AS hour_name,
       DATENAME(minute,only_time_7)   AS minute_name
FROM dbo.DateTimePlayground
ORDER BY id;
-- TIME for schedules/opening-hour scenarios [1]

-- 4.3 Hourly buckets using DATETIME2 and EOMONTH/DATEADD
SELECT
  CAST(DATEADD(hour, DATEDIFF(hour, '20000101', modern_dt2_7), '20000101') AS datetime2(0)) AS hour_bucket,
  COUNT(*) AS rows_per_hour
FROM dbo.DateTimePlayground
GROUP BY CAST(DATEADD(hour, DATEDIFF(hour, '20000101', modern_dt2_7), '20000101') AS datetime2(0))
ORDER BY hour_bucket;
-- DATEADD/DATEDIFF bucketing; DATETIME2 recommended for precision [12][10][3]

-- 4.4 Convert stored UTC (assume offset 0) to a viewing offset
SELECT id,
       with_offset_7                                         AS stored_value,            -- contains explicit offset [1]
       SWITCHOFFSET(with_offset_7, '+01:00')                 AS as_cet_plus1,            -- view in +01:00 [12]
       SWITCHOFFSET(with_offset_7, '+05:30')                 AS as_ist_plus530           -- view in +05:30 [12]
FROM dbo.DateTimePlayground
ORDER BY id;

-- 4.5 Find rows that fall in the last full calendar month
DECLARE @today date = CAST(SYSDATETIME() AS date);
DECLARE @start_last_month date = DATEADD(month, DATEDIFF(month, 0, @today) - 1, 0);
DECLARE @end_last_month   date = EOMONTH(@start_last_month);

SELECT *
FROM dbo.DateTimePlayground
WHERE only_date >= @start_last_month
  AND only_date <= @end_last_month
ORDER BY only_date;
-- Uses DATEADD/DATEDIFF month trick and EOMONTH [12][7]
GO
```

## 5) Notes and best practices

- **Prefer ISO‑8601 date/time literals** (e.g., 2025‑08‑09T22:36:45.9876543 or with offsets) to avoid ambiguity from regional settings.[4][6][2]
- **Prefer DATETIME2 over DATETIME** for new work due to range, accuracy, and SQL standard alignment; DATETIME is maintained for compatibility and has rounding quirks.[3][5][4]
- **Use DATETIMEOFFSET** when the offset must be preserved for cross‑time‑zone use cases; otherwise standardize to UTC in DATETIME2 and apply offsets at the edge.[6][1]
- **TIME and DATE** are ideal for pure time‑of‑day and date‑only semantics, respectively.[1]

These recommendations and behaviors are documented by Microsoft Learn and trusted tutorials, including the function list and examples for DATEADD, DATEDIFF, EOMONTH, DATENAME/DATEPART, and the high‑precision system time functions.[8][7][4][6]

---

# MySQL date/time types: definitive table, inserts, and function usage

Below is a practical, paste‑ready MySQL 8 script that mirrors the SQL Server walkthrough: it creates a demo table covering all MySQL temporal types, inserts boundary/extreme values (including precision and time zone offset handling), and runs queries demonstrating core date/time functions and real‑world patterns.[1][2][3][4]

## 1) MySQL temporal data types at a glance

- **Types**: DATE, TIME, DATETIME(fsp), TIMESTAMP(fsp), YEAR.[5][1]
- **Key ranges and behaviors**:
  - **DATE**: 1000‑01‑01 to 9999‑12‑31.[6][1]
  - **TIME(fsp)**: supports durations and times; −838:59:59 to 838:59:59 with microseconds up to fsp 6.[1][6]
  - **DATETIME(fsp)**: 1000‑01‑01 00:00:00 to 9999‑12‑31 23:59:59.999999; no time zone conversion.[2][6][1]
  - **TIMESTAMP(fsp)**: 1970‑01‑01 00:00:01 UTC to 2038‑01‑19 03:14:07.999999; stored in UTC, converted to/from session time_zone.[7][8][2][6][1]
  - **YEAR**: 1901–2155 (and 0000); 4‑digit recommended.[6][1]

**Notes:**
- fsp (0–6) controls fractional seconds precision for TIME/DATETIME/TIMESTAMP.[1]
- TIMESTAMP/DATETIME can auto‑initialize/update to current timestamp via column DEFAULT/ON UPDATE definitions.[4][1]
- As of 8.0.19, inserting offsets like '…+05:30' is supported; TIMESTAMP applies time zone conversion, DATETIME does not.[2][6]

## 2) Create a solid demo table covering all MySQL temporal types

```sql
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
```

## 3) Insert representative data (valids, extremes, precision, offsets)

Demonstrates min/max boundaries, fsp=6, TIMESTAMP vs DATETIME behavior, and offset parsing.[2][6][1]

```sql
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
```

## 4) Core date/time functions in action

- **Retrieval**: NOW/CURRENT_TIMESTAMP, CURDATE, CURTIME.[3][9][10]
- **Arithmetic**: DATE_ADD/DATE_SUB, TIMESTAMPADD/TIMESTAMPDIFF, INTERVAL syntax.[11][3]
- **Extraction/truncation**: EXTRACT, YEAR/MONTH/DAY, DATE_FORMAT.[3][6]
- **Parsing/formatting**: STR_TO_DATE, DATE_FORMAT.[3][6]
- **Time zone/session**: TIMESTAMP shows conversion with time_zone; DATETIME does not.[7][6][2]

```sql
-- 4.1 Current date/time
SELECT
  NOW()                AS now_dt,           -- DATETIME value [17][10]
  CURRENT_TIMESTAMP(6) AS current_ts6,      -- with microseconds [17]
  CURDATE()            AS today_date,       -- DATE only [17][7]
  CURTIME(6)           AS now_time6;        -- TIME with microseconds [17][7]

-- 4.2 Extract parts and formatted output
SELECT
  EXTRACT(YEAR  FROM NOW())  AS y,          -- field extraction [17]
  EXTRACT(MONTH FROM NOW())  AS m,
  EXTRACT(DAY   FROM NOW())  AS d,
  EXTRACT(HOUR  FROM NOW())  AS hh,
  EXTRACT(MINUTE FROM NOW()) AS mi,
  EXTRACT(SECOND FROM NOW()) AS ss,
  DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i:%s') AS formatted; -- formatting [17][5]

-- 4.3 Date arithmetic
SELECT
  DATE_ADD(CURDATE(), INTERVAL 7 DAY)                 AS plus_7_days,       -- add [13][17]
  DATE_SUB(NOW(), INTERVAL 90 MINUTE)                 AS minus_90_minutes,  -- subtract [17]
  TIMESTAMPDIFF(DAY, '2025-01-01', CURDATE())         AS diff_days,         -- difference [17]
  TIMESTAMPADD(SECOND, 3600, '2025-08-09 10:00:00')   AS plus_1_hour;       -- add with unit [17]

-- 4.4 Parsing from strings
SELECT
  STR_TO_DATE('30/09/2027 23:06:51', '%d/%m/%Y %H:%i:%s') AS parsed_dt,     -- parse custom format [17][5]
  DATE_FORMAT('2027-09-30 23:06:51', '%a %d %b %Y %r')    AS pretty;        -- format output [17][5]

-- 4.5 Bucketing by hour/day (useful for reporting)
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

-- 4.6 TIMESTAMP vs DATETIME time zone behavior (session dependent)
-- Show session time_zone and impact on TIMESTAMP
SELECT @@time_zone AS session_tz;                                              -- session tz [12]
-- Compare how the same literal with offset lands in TIMESTAMP vs DATETIME
SELECT
  '2025-08-09 10:00:00+05:30'                        AS input_literal,
  CAST('2025-08-09 10:00:00+05:30' AS DATETIME(6))   AS dt_kept_as_is,        -- no conversion [12][5]
  CAST('2025-08-09 10:00:00+05:30' AS TIMESTAMP(6))  AS ts_converted;         -- converted to UTC [12][6]
```

## 5) Real‑world patterns and gotchas

**Choose types:**
- **Cross‑time‑zone audit/logging**: prefer TIMESTAMP(fsp) for auto UTC conversion; beware 2038 limit.[8][6][7][1][2]
- **Future schedules and "wall‑clock" times** that must not shift with TZ: use DATETIME(fsp).[8][6][2]
- **Pure date or time of day**: DATE or TIME(fsp).[6][1]
- **Year alone**: YEAR (4‑digit), but avoid for complex date logic.[1][6]

**Precision:**
- Use fsp up to 6 when microseconds matter across TIME/DATETIME/TIMESTAMP.[2][1]

**Offsets:**
- Insert offsets with leading zero hour, e.g., +05:30 or -04:00; supported since 8.0.19.[6][2]

**Auto columns:**
- TIMESTAMP and DATETIME can auto‑init/update via DEFAULT CURRENT_TIMESTAMP and ON UPDATE CURRENT_TIMESTAMP.[4][1]

**Time zone settings:**
- TIMESTAMP reads/writes use connection time_zone; set @@time_zone per connection for consistent results.[7][2][6]

## 6) Quick troubleshooting tips

- **"Incorrect datetime value"** often comes from invalid format or out‑of‑range values; prefer 'YYYY‑MM‑DD hh:mm:ss[.fraction][±HH:MM]' and respect each type's range.[1][2][6]
- **If an offset literal fails**, ensure zero‑padded hour and a colon in minutes (e.g., +05:30), and note version ≥8.0.19.[2][6]
- **If a value near 2038 fails for TIMESTAMP**, store it in DATETIME instead due to range limits.[8][6][1][2]

---

# PostgreSQL date/time types: definitive table, inserts, and function usage

Below is a practical, paste-ready PostgreSQL script (psql-compatible) that mirrors the SQL Server and MySQL walkthroughs: it creates a demo table covering the main temporal types, inserts boundary/extreme values (including precision and time zone handling), and runs queries demonstrating core date/time functions and real-world patterns.

## 1) PostgreSQL temporal data types at a glance

- **Types**: date, time[(p)] [without time zone], time with time zone, timestamp[(p)] without time zone, timestamp[(p)] with time zone (timestamptz), interval.[1]
- **Precision**: time, timestamp, and interval accept optional fractional seconds precision p; default microsecond resolution.[2][1]
- **Semantics**:
  - **timestamp without time zone**: no time zone semantics; stored value has no offset and is not converted on display.[1]
  - **timestamp with time zone (timestamptz)**: stored internally as UTC; displayed in the session time zone.[3][1]
  - **time with time zone (timetz)**: defined by SQL but of limited usefulness; often discouraged.[1]
  - **interval**: duration, supports fields from years to microseconds and field restriction syntax.[1]
- **Ranges**: timestamp/timestamptz cover very wide ranges; PostgreSQL stores timestamps as 64-bit microseconds since 2000-01-01 internally.[4]

## 2) Create a solid demo table covering key PostgreSQL temporal types

```sql
-- Clean slate
DROP TABLE IF EXISTS datetime_playground;

CREATE TABLE datetime_playground (
  id               bigserial PRIMARY KEY,
  only_date        date,                  -- calendar date[1]
  only_time_6      time(6),               -- time of day, microseconds[2][1]
  only_timetz_6    time(6) with time zone,-- time with time zone (rarely needed)[1]
  ts_no_tz_6       timestamp(6),          -- timestamp without time zone[1]
  ts_tz_6          timestamptz(6),        -- timestamp with time zone; stored UTC, displayed per session tz[3][1]
  dur_interval     interval               -- duration[1]
);

COMMENT ON COLUMN datetime_playground.only_timetz_6 IS 'Use with caution; SQL-defined type with limited usefulness in practice.';
```

## 3) Insert representative data (valids, extremes, precision, time zones)

```sql
-- Typical current values
INSERT INTO datetime_playground
(only_date, only_time_6, only_timetz_6, ts_no_tz_6, ts_tz_6, dur_interval)
VALUES
(CURRENT_DATE, CURRENT_TIME(6), CURRENT_TIME(6), CURRENT_TIMESTAMP(6)::timestamp, CURRENT_TIMESTAMP(6), INTERVAL '1 day 02:03:04.123456');

-- Explicit literals with microseconds
INSERT INTO datetime_playground
(only_date, only_time_6, only_timetz_6, ts_no_tz_6, ts_tz_6, dur_interval)
VALUES
('2025-08-10', '23:59:59.123456', '23:59:59.123456+05:30', '2025-08-10 23:59:59.123456', '2025-08-10 23:59:59.123456+05:30', INTERVAL '2 months 3 days 04:05:06.789012');

-- Boundary-style examples (wide ranges supported)
INSERT INTO datetime_playground
(only_date, only_time_6, only_timetz_6, ts_no_tz_6, ts_tz_6, dur_interval)
VALUES
('0001-01-01', '00:00:00.000001', '00:00:00.000001+00', '0001-01-01 00:00:00.000001', '0001-01-01 00:00:00.000001+00', INTERVAL '-10 years 5 days'),
('9999-12-31', '23:59:59.999999', '23:59:59.999999-12', '9999-12-31 23:59:59.999999', '9999-12-31 23:59:59.999999-12', INTERVAL '100 years');

-- Time zone behavior: timestamptz stores UTC, shows in session tz
INSERT INTO datetime_playground
(only_date, only_time_6, only_timetz_6, ts_no_tz_6, ts_tz_6, dur_interval)
VALUES
('2027-09-09', '10:09:45.000000', '10:09:45.000000+05:30', '2027-09-09 10:09:45.000000', '2027-09-09 10:09:45.000000+05:30', INTERVAL '90 minutes');

-- Inspect what we inserted
SELECT id, only_date, only_time_6, only_timetz_6, ts_no_tz_6, ts_tz_6, dur_interval
FROM datetime_playground
ORDER BY id;
```

**Notes:**
- timestamptz input with a zone or offset is converted to a UTC internal value, then displayed per the session's time zone.[3][1]
- timestamp (without time zone) is not converted; it is a pure wall-clock moment without zone semantics.[1]

## 4) Core date/time functions and operators in action

```sql
-- Session time zone introspection
SHOW TIME ZONE; -- session time zone; affects timestamptz display[4]
SELECT CURRENT_TIMESTAMP, NOW(), LOCALTIMESTAMP; -- NOW()/CURRENT_TIMESTAMP are timestamptz; LOCALTIMESTAMP is timestamp without time zone[5][1]

-- Extract parts and truncate
SELECT
  EXTRACT(YEAR  FROM CURRENT_TIMESTAMP)  AS year_part,     -- numeric extraction[5]
  EXTRACT(MONTH FROM CURRENT_TIMESTAMP)  AS month_part,
  EXTRACT(DAY   FROM CURRENT_TIMESTAMP)  AS day_part,
  EXTRACT(HOUR  FROM CURRENT_TIMESTAMP)  AS hour_part,
  EXTRACT(MINUTE FROM CURRENT_TIMESTAMP) AS minute_part,
  EXTRACT(SECOND FROM CURRENT_TIMESTAMP) AS second_part;

-- Truncate timestamps to common buckets
SELECT
  DATE_TRUNC('hour', CURRENT_TIMESTAMP)    AS hour_bucket,
  DATE_TRUNC('day', CURRENT_TIMESTAMP)     AS day_bucket,
  DATE_TRUNC('month', CURRENT_TIMESTAMP)   AS month_bucket;

-- Date/time arithmetic with intervals
SELECT
  CURRENT_DATE + INTERVAL '7 days'             AS plus_7_days,
  CURRENT_TIMESTAMP - INTERVAL '90 minutes'    AS minus_90_minutes,
  AGE(CURRENT_TIMESTAMP, CURRENT_TIMESTAMP - INTERVAL '3 months 10 days') AS human_age;

-- AT TIME ZONE conversions
-- 1) Convert timestamptz display to another zone
SELECT CURRENT_TIMESTAMP AT TIME ZONE 'Asia/Kolkata'    AS as_ist,
       CURRENT_TIMESTAMP AT TIME ZONE 'UTC'             AS as_utc;

-- 2) Attach a zone to a naive timestamp (assumes the local time is in given zone) then get timestamptz
SELECT
  (TIMESTAMP '2027-09-30 23:06:51.979687' AT TIME ZONE 'Asia/Kolkata') AS ts_localized;

-- Bucketing real rows by hour/day
SELECT DATE_TRUNC('hour', ts_tz_6)  AS hour_bucket, COUNT(*) AS cnt
FROM datetime_playground
GROUP BY 1
ORDER BY 1;

SELECT DATE_TRUNC('day', ts_no_tz_6) AS day_bucket, COUNT(*) AS cnt
FROM datetime_playground
GROUP BY 1
ORDER BY 1;

-- Formatting for presentation (client/UIs typically do this; shown here for completeness)
SELECT TO_CHAR(CURRENT_TIMESTAMP, 'YYYY-MM-DD"T"HH24:MI:SS.USOF') AS iso_like;
```

## 5) Real‑world patterns and best practices

**Choosing types:**
- **Cross‑time‑zone logging/audit**: prefer timestamptz so storage is UTC and display follows session time zone.[3][1]
- **Business "wall clock" times** that must not shift with zone: use timestamp without time zone or date/time as needed.[1]
- **Durations/SLA math**: use interval and arithmetic with +/– and AGE/DATE_TRUNC/EXTRACT.[8][5][1]

**Time zone handling:**
- timestamptz does not store the original time zone name or offset; it stores the instant in UTC and shows per session time zone.[11][3][1]
- To preserve the original zone (e.g., "Asia/Kolkata"), store it in an additional text column alongside timestamptz.[12][11]
- Adjust display or interpret naive timestamps using AT TIME ZONE.[10][1]

**Session behavior:**
- SHOW TIME ZONE and SET TIME ZONE to understand/affect how timestamptz is displayed; psql usually sets session zone to local unless configured.[4]

**Precision:**
- time/timestamp default to microsecond precision; specify (p) to control fractional seconds.[2][1]

## 6) Troubleshooting tips

- **"Invalid input syntax for type timestamp/timestamptz"**: verify the literal format is ISO-like, e.g., 'YYYY-MM-DD HH:MI:SS[.US]' optionally with zone for timestamptz, or use explicit casts TIMESTAMP '...' / TIMESTAMPTZ '...'.[5][1]
- **Unexpected hour offset on select**: check SHOW TIME ZONE; timestamptz displays in the session time zone even though stored as UTC.[3][1]
- **Need time zone aware bucketing**: use DATE_TRUNC together with AT TIME ZONE to control the zone you bucket in.[13][6][5]

---

# Understanding "format changes" in MSSQL and MySQL

Below is a concise, practical guide to controlling and changing date/time formats in Microsoft SQL Server (T‑SQL) and MySQL—both for input parsing and output presentation. This focuses on safe, unambiguous approaches for real systems.

## SQL Server (MSSQL)

### Safest input formats
- **Use ISO 8601 for parsing**:
  - Datetime without offset: 'YYYY-MM-DDTHH:MM:SS[.fffffff]'
  - With offset: 'YYYY-MM-DDTHH:MM:SS[.fffffff][±HH:MM]' or 'Z'
- **Examples**:
  - CAST('2027-09-30T23:06:51.9796876' AS datetime2(7))
  - CAST('2027-09-30T23:06:51+05:30' AS datetimeoffset(7))
- **Avoid ambiguous regional formats** like '30/09/2027 23:06:51'.

### Output formatting for display
- **Prefer FORMAT only for presentation layers**; it's CLR-based and slower—avoid in large queries.
- **Use CONVERT with style** for classic formatting, or DATENAME/DATEPART for custom pieces.

**Examples:**
- **ISO 8601 string**:
  ```sql
  SELECT CONVERT(varchar(33), SYSUTCDATETIME(), 126) AS iso8601;  -- 2025-08-09T18:27:31.1234567
  ```
- **Custom display with FORMAT** (UI-sized result sets):
  ```sql
  SELECT FORMAT(SYSDATETIME(), 'yyyy-MM-dd HH:mm:ss.fffffff') AS pretty;
  ```
- **Build custom parts without FORMAT**:
  ```sql
  SELECT CONCAT(
        DATEPART(year, @d), '-',
        RIGHT('0' + CAST(DATEPART(month,@d) AS varchar(2)), 2), '-',
        RIGHT('0' + CAST(DATEPART(day,  @d) AS varchar(2)), 2), ' ',
        CONVERT(varchar(12), @d, 114)  -- HH:MM:SS:mmm(24h)
      ) AS ymd_hms;
  ```

**Common CONVERT styles (selected):**
- 112: 'YYYYMMDD'
- 120: 'YYYY-MM-DD HH:MI:SS' (24h)
- 121: 'YYYY-MM-DD HH:MI:SS.mmm' (ODBC canonical with ms)
- 126: 'YYYY-MM-DDTHH:MM:SS.mmm' (ISO8601; for datetime2 use SYSDATETIME then CONVERT)

### Time zone conversion (format plus offset)
- **Convert datetimeoffset between offsets**:
  ```sql
  SELECT SWITCHOFFSET(TODATETIMEOFFSET(SYSUTCDATETIME(), '+00:00'), '+05:30');
  ```
- **Attach offset to datetime2**:
  ```sql
  SELECT TODATETIMEOFFSET(@utc_dt2, '+00:00');
  ```

### Session-level display settings
- **SET DATEFORMAT** dmy | mdy | ymd affects parsing of non‑ISO strings; avoid relying on it—use ISO strings.
- **SET LANGUAGE** affects DATENAME outputs (month/weekday names).

**Quick checks:**
```sql
SELECT @@LANGUAGE, DB_NAME(), SYSDATETIME(), SYSUTCDATETIME();
```

## MySQL

### Safest input formats
- **Use 'YYYY-MM-DD HH:MM:SS[.ffffff]'** for DATETIME/TIMESTAMP.
- **Offsets (MySQL 8.0.19+)**: 'YYYY-MM-DD HH:MM:SS[.ffffff][±HH:MM]' are accepted by both DATETIME and TIMESTAMP.
  - DATETIME stores as given (no TZ conversion).
  - TIMESTAMP converts to/from session time_zone.

**Examples:**
- CAST('2027-09-30 23:06:51.979687' AS DATETIME(6));
- CAST('2027-09-30 23:06:51+05:30' AS TIMESTAMP(6));

### Output formatting for display
- **Use DATE_FORMAT** for custom strings.

**Examples:**
- ```sql
  SELECT DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i:%s') AS ymd_hms;
  ```
- ```sql
  SELECT DATE_FORMAT(NOW(6), '%Y-%m-%d %H:%i:%s.%f') AS ymd_hms_micro;
  ```
- **Select parts:**
  ```sql
  SELECT YEAR(NOW()), MONTH(NOW()), DAY(NOW()), HOUR(NOW()), MINUTE(NOW()), SECOND(NOW());
  ```

**Common DATE_FORMAT tokens:**
- %Y year(4), %m month(01-12), %d day(01-31), %H hour(00-23), %i minute, %s second, %f microseconds, %a short weekday, %b short month.

### Time zone conversion (TIMESTAMP vs DATETIME)
- **Check session time zone:**
  ```sql
  SELECT @@time_zone, @@system_time_zone;
  ```
- **TIMESTAMP conversion:**
  ```sql
  SET time_zone = '+05:30';
  INSERT INTO t(ts_col) VALUES ('2025-08-09 10:00:00+00:00');  -- stored as UTC, shown in +05:30 on select
  ```
- **DATETIME is not converted** by time_zone—stores exactly what was provided.

### Parsing custom formats
- **Use STR_TO_DATE** for ingesting non-ISO strings:
  ```sql
  SELECT STR_TO_DATE('30/09/2027 23:06:51', '%d/%m/%Y %H:%i:%s');
  ```

## Practical patterns

**Storage versus display:**
- Store in strongly typed columns (DATE, TIME, DATETIME/TIMESTAMP) using ISO strings or parameterized queries.
- Format for display at the edge (application or final SELECT), not in the core data.

**Cross-time-zone apps:**
- **SQL Server**: store datetimeoffset where the original offset matters; otherwise store UTC in datetime2 and convert per user.
- **MySQL**: prefer TIMESTAMP for audit/logs (UTC conversion), DATETIME for future schedules that must not shift.

**Performance:**
- **SQL Server FORMAT** is convenient but slow—use CONVERT/DATEPART for large sets.
- **MySQL DATE_FORMAT** is optimized for server-side formatting but still better to avoid in heavy aggregations if not needed.

## Quick "format change" recipes

- **SQL Server: ISO to readable with milliseconds**
  ```sql
  SELECT CONVERT(varchar(23), SYSDATETIME(), 121) AS ymd_hms_ms;
  ```
- **SQL Server: datetime2 to dd/MM/yyyy HH:mm**
  ```sql
  SELECT FORMAT(@d, 'dd/MM/yyyy HH:mm') AS uk_style;  -- small result sets
  ```
- **MySQL: ISO to dd/MM/yyyy HH:mm**
  ```sql
  SELECT DATE_FORMAT(NOW(), '%d/%m/%Y %H:%i') AS uk_style;
  ```
- **MySQL: bucket by hour**
  ```sql
  SELECT DATE_FORMAT(dt_col, '%Y-%m-%d %H:00:00') AS hour_bucket, COUNT(*) FROM t GROUP BY hour_bucket;
  ```

---

## References

**Original Guide References:**  
[1] https://dev.mysql.com/doc/en/date-and-time-types.html  
[2] https://dev.mysql.com/doc/en/datetime.html  
[3] https://dev.mysql.com/doc/refman/8.4/en/date-and-time-type-syntax.html  
[4] https://dev.mysql.com/doc/refman/8.4/en/time.html  
[5] https://www.red-gate.com/simple-talk/?p=106629  
[6] https://dev.mysql.com/doc/en/date-and-time-functions.html  
[7] https://dev.mysql.com/doc/en/data-types.html  
[8] https://www.mssqltips.com/sqlservertip/7600/sql-data-types-date-datetime-datetime2-smalldatetime-datetimeoffset-time/  
[9] https://www.microfocus.com/documentation/enterprise-developer/30pu12/ED-VS2013/GUID-DC5B9C1F-353F-4C08-95DE-E1D825CD65C7.html  
[10] https://neon.com/docs/data-types/date-and-time  
[11] https://www.postgresql.org/docs/7.0/datatype1134.htm  
[12] https://neon.com/postgresql/postgresql-tutorial/postgresql-date  
[13] https://www.npgsql.org/doc/types/datetime.html  
[14] https://www.dbvis.com/thetable/a-guide-to-the-sql-date-data-types/  
[15] https://mariadb.com/docs/server/reference/data-types/date-and-time-data-types  
[16] https://www.w3schools.com/sql/sql_dates.asp  
[17] https://dev.mysql.com/doc/en/  
[18] https://www.w3schools.com/sql/sql_datatypes.asp  
[19] https://www.postgresql.org/docs/6.3/c0804.htm  
[20] https://www.w3schools.com/mysql/mysql_dates.asp

**SQL Server Guide References:**  
[1] https://www.mssqltips.com/sqlservertip/7600/sql-data-types-date-datetime-datetime2-smalldatetime-datetimeoffset-time/  
[2] https://www.microfocus.com/documentation/enterprise-developer/30pu12/ED-VS2013/GUID-DC5B9C1F-353F-4C08-95DE-E1D825CD65C7.html  
[3] https://learn.microsoft.com/en-us/sql/t-sql/data-types/datetime2-transact-sql?view=sql-server-ver17  
[4] https://learn.microsoft.com/en-us/sql/t-sql/data-types/datetime-transact-sql?view=sql-server-ver17  
[5] https://www.geeksforgeeks.org/sql-server/datetime2-vs-datetime-in-sql-server/  
[6] https://learn.microsoft.com/en-us/sql/t-sql/functions/date-and-time-data-types-and-functions-transact-sql?view=sql-server-ver17  
[7] https://www.mssqltips.com/sqlservertip/6866/sql-date-functions/  
[8] https://www.mssqltips.com/sqlservertip/5993/sql-server-date-and-time-functions-with-examples/  
[9] https://www.w3schools.com/sql/sql_dates.asp  
[10] https://www.w3schools.com/sql/sql_datatypes.asp  
[11] https://www.dbvis.com/thetable/a-guide-to-the-sql-date-data-types/  
[12] https://www.baeldung.com/sql/sql-server-datetime2-datetime-differences  
[13] https://www.dofactory.com/sql/datetime  
[14] https://www.sqlshack.com/an-overview-of-sql-server-data-types/  
[15] https://www.influxdata.com/blog/sql-date-functions-guide/  
[16] https://dev.to/karenpayneoregon/sql-server-exploration-of-datetime27-precision-c-2l54  
[17] https://www.sqlshack.com/sql-server-datetime-data-type-considerations-and-limitations/  
[18] https://www.w3schools.com/sql/sql_ref_sqlserver.asp  
[19] https://www.tutorialsteacher.com/articles/datetime-vs-datetime2-in-sqlserver  
[20] https://www.sqlservertutorial.net/sql-server-date-functions/

---
# Oracle Date/Time Types: Definitive Table, Inserts, and Function Usage

Below is a practical, self-contained guide for Oracle SQL that mirrors the SQL Server example. It creates a demo table with equivalent date/time types, inserts representative data, and demonstrates the most important functions.

## 1) Oracle Date/Time Data Types

- **DATE**: Stores date and time (year, month, day, hour, minute, second). No fractional seconds or time zone information.
- **TIMESTAMP(p)**: An extension of `DATE` that adds fractional seconds precision, where `p` is 0-9 (default 6).
- **TIMESTAMP(p) WITH TIME ZONE**: A `TIMESTAMP` that includes a time zone offset (e.g., `+05:30`) or region name (e.g., `America/New_York`). The time zone is stored with the value.
- **TIMESTAMP(p) WITH LOCAL TIME ZONE**: A `TIMESTAMP` that is stored in the database's time zone but is converted to the user's session time zone upon retrieval.
- **INTERVAL YEAR(p) TO MONTH**: Stores a duration of time in years and months.
- **INTERVAL DAY(p) TO SECOND(f)**: Stores a duration of time in days, hours, minutes, and seconds.

**Key Differences from SQL Server:**
- Oracle does not have a separate `TIME` type. The common practice is to use a `DATE` or `TIMESTAMP` and ignore the date portion, or use a `VARCHAR2` for storage.
- `DATETIME` and `SMALLDATETIME` from SQL Server are best mapped to Oracle's `DATE` or `TIMESTAMP` depending on precision needs.
- `DATETIMEOFFSET` in SQL Server maps directly to `TIMESTAMP WITH TIME ZONE` in Oracle.

```sql
-- NOTE: This section is intended to be run in a SQL client like SQL*Plus or SQL Developer.
-- To see DBMS_OUTPUT, you may need to run: SET SERVEROUTPUT ON;
```

## 2) Create a Solid Demo Table

This table maps the SQL Server types to their closest Oracle equivalents.

```sql
-- Clean slate: Drop table if it exists
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE DateTimePlayground_Ora';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

-- Create a single table that holds equivalent Oracle date/time types
CREATE TABLE DateTimePlayground_Ora
(
    id                NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    only_date         DATE,                           -- For SQL Server DATE
    only_time_7       TIMESTAMP(7),                   -- For SQL Server TIME(7). No direct TIME type in Oracle.
    legacy_datetime   TIMESTAMP(3),                   -- For SQL Server DATETIME (~3ms precision)
    modern_ts_7       TIMESTAMP(7),                   -- For SQL Server DATETIME2(7)
    with_offset_7     TIMESTAMP(7) WITH TIME ZONE,    -- For SQL Server DATETIMEOFFSET(7)
    small_dt          DATE                            -- For SQL Server SMALLDATETIME
);
```

## 3) Insert Representative Data

Oracle is stricter with string-to-date conversion. Always use explicit `TO_DATE`, `TO_TIMESTAMP`, and `TO_TIMESTAMP_TZ` with a format mask.

```sql
-- Insert a "typical" row
INSERT INTO DateTimePlayground_Ora (only_date, only_time_7, legacy_datetime, modern_ts_7, with_offset_7, small_dt) VALUES (
    TO_DATE('2024-12-31', 'YYYY-MM-DD'),
    TO_TIMESTAMP('1970-01-01 23:59:59.1234567', 'YYYY-MM-DD HH24:MI:SS.FF7'), -- Ignoring date part for time
    TO_TIMESTAMP('2024-12-31 23:59:59.997', 'YYYY-MM-DD HH24:MI:SS.FF3'),
    TO_TIMESTAMP('2024-12-31 23:59:59.1234567', 'YYYY-MM-DD HH24:MI:SS.FF7'),
    TO_TIMESTAMP_TZ('2024-12-31 23:59:59.1234567 +05:30', 'YYYY-MM-DD HH24:MI:SS.FF7 TZH:TZM'),
    TO_DATE('2024-12-31 23:59:00', 'YYYY-MM-DD HH24:MI:SS')
);

-- Precision check
INSERT INTO DateTimePlayground_Ora (only_date, only_time_7, legacy_datetime, modern_ts_7, with_offset_7, small_dt) VALUES (
    TO_DATE('2025-01-01', 'YYYY-MM-DD'),
    TO_TIMESTAMP('1970-01-01 00:00:00.0000001', 'YYYY-MM-DD HH24:MI:SS.FF7'),
    TO_TIMESTAMP('2025-01-01 00:00:00.001', 'YYYY-MM-DD HH24:MI:SS.FF3'),
    TO_TIMESTAMP('2025-01-01 00:00:00.0000001', 'YYYY-MM-DD HH24:MI:SS.FF7'),
    TO_TIMESTAMP_TZ('2025-01-01 00:00:00.0000001 +00:00', 'YYYY-MM-DD HH24:MI:SS.FF7 TZH:TZM'),
    TO_DATE('2025-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
);

-- Edge cases and offsets
INSERT ALL
    INTO DateTimePlayground_Ora (only_date, only_time_7, legacy_datetime, modern_ts_7, with_offset_7, small_dt) VALUES (
        TO_DATE('0001-01-01', 'YYYY-MM-DD'),
        TO_TIMESTAMP('1970-01-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        TO_TIMESTAMP('2000-01-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        TO_TIMESTAMP('0001-01-01 12:00:00.0000000', 'YYYY-MM-DD HH24:MI:SS.FF7'),
        TO_TIMESTAMP_TZ('2000-01-01 12:00:00.0000000 -14:00', 'YYYY-MM-DD HH24:MI:SS.FF7 TZH:TZM'),
        TO_DATE('2000-01-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS')
    )
    INTO DateTimePlayground_Ora (only_date, only_time_7, legacy_datetime, modern_ts_7, with_offset_7, small_dt) VALUES (
        TO_DATE('9999-12-31', 'YYYY-MM-DD'),
        TO_TIMESTAMP('1970-01-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        TO_TIMESTAMP('2020-06-15 08:30:00.123', 'YYYY-MM-DD HH24:MI:SS.FF3'),
        TO_TIMESTAMP('9999-12-31 12:00:00.9999999', 'YYYY-MM-DD HH24:MI:SS.FF7'),
        TO_TIMESTAMP_TZ('2020-06-15 08:30:00.1230000 +14:00', 'YYYY-MM-DD HH24:MI:SS.FF7 TZH:TZM'),
        TO_DATE('2020-06-15 08:30:00', 'YYYY-MM-DD HH24:MI:SS')
    )
SELECT 1 FROM DUAL;
```

## 3) Essential Date/Time Functions

- **Current Time**: `SYSDATE`, `SYSTIMESTAMP`, `CURRENT_TIMESTAMP`, `LOCALTIMESTAMP`, `SYS_EXTRACT_UTC`.
- **Arithmetic**: `+` / `-` with `INTERVAL` types, `ADD_MONTHS`.
- **Extraction**: `EXTRACT`, `TO_CHAR`.
- **Conversion**: `TO_DATE`, `TO_TIMESTAMP`, `TO_TIMESTAMP_TZ`, `CAST`.
- **Time Zone**: `FROM_TZ`, `AT TIME ZONE`.

```sql
-- Get current date/time
SELECT
    SYSDATE as oracle_date,
    SYSTIMESTAMP as oracle_systimestamp,
    CURRENT_TIMESTAMP as current_ts_with_tz,
    LOCALTIMESTAMP as local_ts_no_tz,
    SYS_EXTRACT_UTC(SYSTIMESTAMP) as sys_utc
FROM DUAL;

-- Extract parts from a timestamp
SELECT
    EXTRACT(YEAR FROM SYSTIMESTAMP) AS part_year,
    EXTRACT(MONTH FROM SYSTIMESTAMP) AS part_month,
    EXTRACT(DAY FROM SYSTIMESTAMP) AS part_day,
    TO_CHAR(SYSDATE, 'Day') AS name_weekday,
    TO_CHAR(SYSDATE, 'Month') AS name_month
FROM DUAL;

-- Date math
SELECT
    SYSDATE + 7 AS plus_7_days,
    SYSDATE - (90/1440) AS minus_90_minutes, -- 1440 minutes in a day
    ADD_MONTHS(SYSDATE, -1) AS minus_1_month,
    (SYSDATE - TO_DATE('2025-01-01', 'YYYY-MM-DD')) AS diff_days
FROM DUAL;

-- Month-end and date construction
SELECT
    LAST_DAY(SYSDATE) AS end_of_this_month,
    TRUNC(SYSDATE, 'MM') AS first_of_this_month,
    TO_DATE('2025-08-01', 'YYYY-MM-DD') AS date_from_parts
FROM DUAL;

-- ISO 8601 parsing
SELECT
    TO_TIMESTAMP('2025-08-09T22:36:45.9876543', 'YYYY-MM-DD"T"HH24:MI:SS.FF7') AS parsed_ts,
    TO_TIMESTAMP_TZ('2025-08-09T22:36:45+05:30', 'YYYY-MM-DD"T"HH24:MI:SS TZH:TZM') AS parsed_tstz
FROM DUAL;

-- Time zone conversions
SELECT
    FROM_TZ(CAST(SYSDATE AS TIMESTAMP), 'UTC') AS utc_as_offset,
    FROM_TZ(CAST(SYSDATE AS TIMESTAMP), 'UTC') AT TIME ZONE 'Asia/Kolkata' AS in_india_offset
FROM DUAL;
```

## 4) Best Practices for Oracle

- **Be Explicit**: Always use `TO_DATE`, `TO_TIMESTAMP`, and `TO_TIMESTAMP_TZ` with format models to avoid ambiguity related to `NLS_DATE_FORMAT` settings.
- **Choose the Right Type**:
    - Use `TIMESTAMP WITH TIME ZONE` for events that occur across different regions to correctly record the instant in time.
    - Use `DATE` for business dates (e.g., `hire_date`) where the exact time or fractional seconds are less important.
    - Use `TIMESTAMP` for high-precision, time-zone-agnostic logging (e.g., scientific measurements).
- **Use `INTERVAL` for Arithmetic**: For clear and readable date math, add or subtract `INTERVAL` types (e.g., `my_date + INTERVAL '5' DAY`). Use `ADD_MONTHS` for month calculations to correctly handle varying month lengths.
- **`TRUNC` is for Bucketing**: Use `TRUNC(my_date, 'DD')` or `TRUNC(my_date, 'HH')` to easily group data by day or hour.
