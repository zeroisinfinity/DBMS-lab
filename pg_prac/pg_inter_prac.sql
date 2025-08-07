-- temp col ------------------------------------------------------------------------------------------------------------------------------------------
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
select  ID*10 as idd from NumericReachTest; -- option 1 mysql type 

alter table NumericReachTest
	add column idd int; --- case insensitive attributes(col header name) in POSTGRES SQL
	
/*
In PostgreSQL, column names (identifiers) are case-insensitive by default,
unless you quote them using double quotes (").

-------------------------------
✅ By default (unquoted identifiers):

CREATE TABLE example (
    Name TEXT,
    Age INT
);

-- The column names are actually stored as: name, age (lowercase internally)
SELECT name, age FROM example;       -- ✅ Works
SELECT NAME, AGE FROM example;       -- ✅ Works
SELECT NaMe, AgE FROM example;       -- ✅ Works

PostgreSQL folds unquoted identifiers to lowercase internally, so all variations above are treated the same.

-------------------------------
⚠️ If you use double quotes (quoted identifiers):

CREATE TABLE example2 (
    "Name" TEXT,
    "Age" INT
);

SELECT "Name", "Age" FROM example2;   -- ✅ Works
SELECT name, age FROM example2;       -- ❌ ERROR: column "name" does not exist
SELECT NAME, AGE FROM example2;       -- ❌ ERROR

Quoted identifiers are case-sensitive, and must be referred to exactly as defined.

-------------------------------
🔁 TL;DR:
In PostgreSQL, column names are case-insensitive unless enclosed in double quotes,
which makes them case-sensitive and must be referred to exactly as written.
*/

	
select * from NumericReachTest;

do $$
begin
	for i in 1..10 loop
		update NumericReachTest set idd = ID+500 ;
	end loop ;
	
end $$;


alter table NumericReachTest
    add test int;
select test from NumericReachTest;


UPDATE NumericReachTest set test = ID where ID between 1 and 10;
select * from NumericReachTest;



alter table NumericReachTest rename to numr;




















