
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

