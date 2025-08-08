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
select * from information_schema.tables where table_schema = 'public';
 

-- null -------------------------------------------------------------------------------------------------------------------------

-- Add new column
ALTER TABLE numr
ADD nill INT;

-- Update nill to NULL for id between 351 and 357
UPDATE numr
SET nill = NULL
WHERE ID BETWEEN 1 AND 7;

-- Update nill to 77 for id > 357
UPDATE numr
SET nill = 77
WHERE id > 7;

-- Select records where nill IS NULL
SELECT * FROM numr WHERE nill is not NULL;


-- datalength change ----------------------------------------------------------------------------------------------------------------------------------------------


-- lets change namet to varchar(200)
alter table numr
    alter column region type varchar(200);

-- sql aggregate func-----------------------------------------------------------------------------------------
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

select id from test_int limit 3;


-- group by ----------------------------------------------------------------------------------------------------------------------------

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    role VARCHAR(50),
    location VARCHAR(50),
    salary NUMERIC(10,2),
    hire_date DATE
);
-- Use the same INSERT statements from MySQL without AUTO_INCREMENT mention

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

select extract(year from employees.hire_date) as joining_year ,
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
    group by rollup(department , role);

select sum(salarypool) as salarypool
    from (SELECT department, role, sum(salary) AS salarypool
    FROM employees
    GROUP BY department, role
    ORDER BY department, role) as role_salary
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

select department , role , sum(salary) as salarypool
	from employees
	group by cube(department , role)
	order by department , role , salarypool;

select department , role , sum(salary) as salarypool
	from employees
	group by grouping sets(
		(department,role),
		(department),
		()
	);

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

SELECT count(DISTINCT employees.department) as distict_dept FROM employees;
select sum(dept) as dept from (select count(*) as dept from employees group by employees.department) as total_dept ;








