


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


-- JOIN --------------------------------------------------------------------------------------------------------------------------------------------

-- Create departments table first (referenced by emp table)
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    budget DECIMAL(12,2)
);

-- Insert departments data
INSERT INTO departments (department_name, location, budget) VALUES
('Engineering', 'New York', 500000.00),
('Sales', 'Chicago', 300000.00),
('Marketing', 'Los Angeles', 200000.00),
('HR', 'New York', 150000.00),
('Finance', 'Boston', 250000.00),
('IT Support', 'Austin', 180000.00),
('Operations', 'Seattle', 220000.00),
('Research', 'San Francisco', 400000.00),
('Customer Service', 'Miami', 120000.00),
('Legal', 'Washington DC', 180000.00);

-- Create emp table with self-referencing foreign key
CREATE TABLE emp (
    emp_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    mgr_id INTEGER,
    dept_id INTEGER,
    salary DECIMAL(10,2),
    hire_dt DATE,
    FOREIGN KEY (mgr_id) REFERENCES emp(emp_id),
    FOREIGN KEY (dept_id) REFERENCES departments(department_id)
);

-- Insert emp data
INSERT INTO emp (name, email, mgr_id, dept_id, salary, hire_dt) VALUES
('John Smith', 'john.smith@company.com', NULL, 1, 95000.00, '2020-01-15'),
('Sarah Johnson', 'sarah.johnson@company.com', 1, 1, 75000.00, '2020-03-20'),
('Mike Davis', 'mike.davis@company.com', 1, 1, 70000.00, '2021-05-10'),
('Emma Wilson', 'emma.wilson@company.com', NULL, 2, 80000.00, '2019-08-12'),
('David Brown', 'david.brown@company.com', 4, 2, 65000.00, '2021-02-18'),
('Lisa Garcia', 'lisa.garcia@company.com', 4, 2, 62000.00, '2022-01-05'),
('Robert Taylor', 'robert.taylor@company.com', NULL, 3, 85000.00, '2020-11-30'),
('Jennifer Lee', 'jennifer.lee@company.com', 7, 3, 58000.00, '2021-09-15'),
('Michael Wang', 'michael.wang@company.com', NULL, 4, 90000.00, '2018-06-01'),
('Amanda Clark', 'amanda.clark@company.com', 9, 4, 55000.00, '2022-03-10');

-- Create customers table
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    city VARCHAR(50),
    registration_date DATE
);

-- Insert customers data
INSERT INTO customers (customer_name, email, phone, city, registration_date) VALUES
('Alice Cooper', 'alice.cooper@email.com', '555-0101', 'New York', '2023-01-15'),
('Bob Martinez', 'bob.martinez@email.com', '555-0102', 'Los Angeles', '2023-02-20'),
('Carol White', 'carol.white@email.com', '555-0103', 'Chicago', '2023-03-10'),
('Daniel Kim', 'daniel.kim@email.com', '555-0104', 'Houston', '2023-04-05'),
('Eva Rodriguez', 'eva.rodriguez@email.com', '555-0105', 'Phoenix', '2023-05-12'),
('Frank Thompson', 'frank.thompson@email.com', '555-0106', 'Philadelphia', '2023-06-18'),
('Grace Chen', 'grace.chen@email.com', '555-0107', 'San Antonio', '2023-07-22'),
('Henry Johnson', 'henry.johnson@email.com', '555-0108', 'San Diego', '2023-08-30'),
('Iris Patel', 'iris.patel@email.com', '555-0109', 'Dallas', '2023-09-14'),
('Jack Wilson', 'jack.wilson@email.com', '555-0110', 'Austin', '2023-10-25');

-- Create products table
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock_quantity INTEGER DEFAULT 0
);

-- Insert products data
INSERT INTO products (product_name, category, price, stock_quantity) VALUES
('Laptop Pro 15"', 'Electronics', 1299.99, 50),
('Wireless Mouse', 'Electronics', 29.99, 200),
('Office Chair', 'Furniture', 199.99, 30),
('Standing Desk', 'Furniture', 399.99, 15),
('Coffee Mug', 'Office Supplies', 12.99, 100),
('Notebook Set', 'Office Supplies', 8.99, 150),
('Smartphone', 'Electronics', 699.99, 75),
('Tablet 10"', 'Electronics', 329.99, 60),
('Desk Lamp', 'Furniture', 45.99, 40),
('Pen Set', 'Office Supplies', 15.99, 120);

-- Create order_details table
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER,
    product_id INTEGER,
    employee_id INTEGER,
    quantity INTEGER DEFAULT 1,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (employee_id) REFERENCES emp(emp_id)
);

-- Insert orders data
INSERT INTO order_details (customer_id, product_id, employee_id, quantity, order_date, total_amount) VALUES
(1, 1, 5, 1, '2024-01-10', 1299.99),
(2, 7, 6, 1, '2024-01-15', 699.99),
(3, 3, 5, 2, '2024-01-20', 399.98),
(1, 2, 6, 3, '2024-02-01', 89.97),
(4, 4, 5, 1, '2024-02-05', 399.99),
(5, 5, 6, 5, '2024-02-10', 64.95),
(2, 8, 5, 1, '2024-02-15', 329.99),
(6, 6, 6, 10, '2024-03-01', 89.90),
(7, 9, 5, 2, '2024-03-10', 91.98),
(3, 10, 6, 4, '2024-03-15', 63.96);


-- FIXED QUERIES - Correcting table/column name mismatches

-- 1. Basic INNER JOIN (FIXED: Missing 'S' in SELECT)
SELECT name, department_name
FROM emp INNER JOIN departments ON
    emp.dept_id = departments.department_id;

SELECT * FROM emp;
SELECT * FROM departments;

-- 2. LEFT JOIN - departments with employees
SELECT departments.department_name, emp.name
FROM departments LEFT JOIN emp
    ON departments.department_id = emp.dept_id;

-- 3. RIGHT JOIN - customers with orders (FIXED: table name orders not order_details)
SELECT orders.order_date, orders.total_amount, customers.customer_id, customers.customer_name, customers.city
FROM orders RIGHT JOIN customers
    ON customers.customer_id = orders.customer_id;

-- 4. FULL OUTER JOIN - customers and orders (FIXED: table name and comment)
SELECT orders.order_date, orders.total_amount, customers.customer_id, customers.customer_name, customers.city
FROM orders FULL OUTER JOIN customers
    ON customers.customer_id = orders.customer_id; -- FULL OUTER JOIN (not RIGHT JOIN in comment)

-- 5. CROSS JOIN - all employees with all orders
SELECT emp_id, name, emp.dept_id, order_id, order_date
FROM emp CROSS JOIN orders;

-- 6. Self JOIN examples - employees and their managers
SELECT * FROM emp;

-- INNER self join - only employees WITH managers
SELECT a.emp_id, a.name, b.name AS manager_name
FROM emp AS a
    INNER JOIN emp AS b ON a.mgr_id = b.emp_id;

-- LEFT self join - ALL employees, managers where available
SELECT a.emp_id, a.name, b.name AS manager_name
FROM emp AS a
    LEFT JOIN emp AS b ON a.mgr_id = b.emp_id;

-- RIGHT self join - all potential managers and their direct reports
SELECT a.emp_id, a.name AS employee_name, b.name AS manager_name
FROM emp AS a
    RIGHT JOIN emp AS b ON a.mgr_id = b.emp_id;

-- FULL OUTER self join - all employee-manager relationships
SELECT a.emp_id, a.name AS employee_name, b.name AS manager_name
FROM emp AS a
    FULL OUTER JOIN emp AS b ON a.mgr_id = b.emp_id;

-- CROSS self join - every employee paired with every employee
SELECT a.emp_id, a.name AS employee_name, b.name AS other_employee
FROM emp AS a
    CROSS JOIN emp AS b;

-- 7. Alternative syntax (comma join) - equivalent to INNER JOIN
SELECT * FROM emp AS a, emp AS b
WHERE a.mgr_id = b.emp_id;

-- 8. Create student_games table
CREATE TABLE student_games (
    student_id INT,
    game_id INT
);

-- Insert sample data
-- Students playing only 1 game
INSERT INTO student_games (student_id, game_id) VALUES (101, 1);
INSERT INTO student_games (student_id, game_id) VALUES (102, 2);
INSERT INTO student_games (student_id, game_id) VALUES (103, 3);

-- Students playing exactly 2 games
INSERT INTO student_games (student_id, game_id) VALUES (201, 1);
INSERT INTO student_games (student_id, game_id) VALUES (201, 2);
INSERT INTO student_games (student_id, game_id) VALUES (202, 2);
INSERT INTO student_games (student_id, game_id) VALUES (202, 3);

-- Students playing more than 3 games
INSERT INTO student_games (student_id, game_id) VALUES (301, 1);
INSERT INTO student_games (student_id, game_id) VALUES (301, 2);
INSERT INTO student_games (student_id, game_id) VALUES (301, 3);
INSERT INTO student_games (student_id, game_id) VALUES (301, 4);
INSERT INTO student_games (student_id, game_id) VALUES (302, 1);
INSERT INTO student_games (student_id, game_id) VALUES (302, 2);
INSERT INTO student_games (student_id, game_id) VALUES (302, 3);
INSERT INTO student_games (student_id, game_id) VALUES (302, 4);
INSERT INTO student_games (student_id, game_id) VALUES (302, 5);

-- Students with NULL game_id (registered but not assigned games)
INSERT INTO student_games (student_id, game_id) VALUES (401, NULL);
INSERT INTO student_games (student_id, game_id) VALUES (402, NULL);

-- View all data
SELECT * FROM student_games ORDER BY student_id, game_id;

-- Basic GROUP BY + HAVING
SELECT student_games.student_id
FROM student_games
GROUP BY student_id
HAVING COUNT(*) < 3;

-- Check specific student
SELECT * FROM student_games WHERE student_games.student_id = 201 ORDER BY student_id, game_id;

-- STUDENT GAMES ANALYSIS QUERIES:

-- Original GROUP BY + HAVING solution
SELECT student_id
FROM student_games
GROUP BY student_id
HAVING COUNT(*) < 3;

-- 1. Count games per student
SELECT student_id, COUNT(game_id) AS games_count
FROM student_games
GROUP BY student_id
ORDER BY student_id;

-- 2. Students playing only 1 game
SELECT student_id, COUNT(game_id) AS games_count
FROM student_games
WHERE game_id IS NOT NULL
GROUP BY student_id
HAVING COUNT(game_id) = 1;

-- 3. Students playing exactly 2 games
SELECT student_id, COUNT(game_id) AS games_count
FROM student_games
WHERE game_id IS NOT NULL
GROUP BY student_id
HAVING COUNT(game_id) = 2;

-- 4. Students playing more than 3 games
SELECT student_id, COUNT(game_id) AS games_count
FROM student_games
WHERE game_id IS NOT NULL
GROUP BY student_id
HAVING COUNT(game_id) > 3;

-- 5. Students with NULL games (no games assigned)
SELECT student_id
FROM student_games
WHERE game_id IS NULL;

-- 6. Students with their game list (comma separated) - PostgreSQL version
SELECT student_id, STRING_AGG(game_id::TEXT, ', ' ORDER BY game_id) AS games_list
FROM student_games
WHERE game_id IS NOT NULL
GROUP BY student_id;

-- 7. Game participation summary
SELECT
    student_id,
    COUNT(game_id) AS total_games,
    CASE
        WHEN COUNT(game_id) = 0 THEN 'No Games'
        WHEN COUNT(game_id) = 1 THEN 'Single Game'
        WHEN COUNT(game_id) = 2 THEN 'Two Games'
        WHEN COUNT(game_id) > 3 THEN 'Multiple Games (3+)'
        ELSE 'Few Games'
    END AS participation_level
FROM student_games
GROUP BY student_id
ORDER BY total_games DESC, student_id;

-- 8. Most popular games
SELECT game_id, COUNT(student_id) AS student_count
FROM student_games
WHERE game_id IS NOT NULL
GROUP BY game_id
ORDER BY student_count DESC;

-- 9. Students playing specific game (example: game_id = 1)
SELECT DISTINCT student_id
FROM student_games
WHERE game_id = 1;

-- 10. Total unique students and games
SELECT
    COUNT(DISTINCT student_id) AS total_students,
    COUNT(DISTINCT game_id) AS total_games
FROM student_games;

-- PostgreSQL-SPECIFIC ENHANCEMENTS:

-- 11. Students with game arrays
SELECT student_id, ARRAY_AGG(game_id ORDER BY game_id) AS games_array
FROM student_games
WHERE game_id IS NOT NULL
GROUP BY student_id;

-- 12. Using FILTER clause
SELECT 
    student_id,
    COUNT(game_id) AS total_games,
    COUNT(game_id) FILTER (WHERE game_id <= 5) AS games_1_to_5,
    COUNT(game_id) FILTER (WHERE game_id > 5) AS games_above_5
FROM student_games
GROUP BY student_id
ORDER BY student_id;

-- 13. Window function - rank students by game count
SELECT 
    student_id,
    COUNT(game_id) AS games_count,
    RANK() OVER (ORDER BY COUNT(game_id) DESC) AS rank_by_games
FROM student_games
WHERE game_id IS NOT NULL
GROUP BY student_id
ORDER BY rank_by_games, student_id;

-- PRODUCTS-ORDERS-EMPLOYEES JOINS (FIXED: All using correct table name 'orders')

-- All products with their orders and employees
SELECT products.product_id, orders.order_id, emp.emp_id
FROM products 
    LEFT JOIN orders ON orders.product_id = products.product_id
    LEFT JOIN emp ON orders.employee_id = emp.emp_id;

-- All orders with their products and employees (using RIGHT JOIN then LEFT JOIN)
SELECT products.product_id, orders.order_id, emp.emp_id
FROM products 
    RIGHT JOIN orders ON orders.product_id = products.product_id
    LEFT JOIN emp ON orders.employee_id = emp.emp_id;

-- More readable equivalent - start from orders table
SELECT products.product_id, orders.order_id, emp.emp_id
FROM orders 
    LEFT JOIN products ON orders.product_id = products.product_id
    LEFT JOIN emp ON orders.employee_id = emp.emp_id;


-- ranks ------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- Universal table structure (works for all databases)
CREATE TABLE student_grades (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    subject VARCHAR(50) NOT NULL,
    grade DECIMAL(5,2) NOT NULL,
    exam_date DATE NOT NULL,
    semester VARCHAR(20),
    credit_hours INT
);

-- PostgreSQL
CREATE TABLE sales_data (
    sale_id SERIAL PRIMARY KEY,
    sale_date DATE NOT NULL,
    salesperson_id INT,
    product_category VARCHAR(50),
    sale_amount DECIMAL(10,2) NOT NULL,
    quantity_sold INT,
    region VARCHAR(50)
);

INSERT INTO sales_data (sale_date, salesperson_id, product_category, sale_amount, quantity_sold, region) VALUES
                                                                                                             ('2024-01-15', 1, 'Electronics', 25000.00, 50, 'North'),
                                                                                                             ('2024-01-16', 2, 'Clothing', 18000.00, 120, 'South'),
                                                                                                             ('2024-01-17', 3, 'Electronics', 32000.00, 40, 'East'),
                                                                                                             ('2024-01-18', 1, 'Books', 8000.00, 200, 'North'),
                                                                                                             ('2024-01-19', 4, 'Electronics', 45000.00, 75, 'West'),
                                                                                                             ('2024-01-20', 2, 'Clothing', 22000.00, 80, 'South'),
                                                                                                             ('2024-01-21', 5, 'Books', 12000.00, 150, 'East'),
                                                                                                             ('2024-01-22', 3, 'Electronics', 38000.00, 60, 'East'),
                                                                                                             ('2024-01-23', 1, 'Clothing', 16000.00, 90, 'North'),
                                                                                                             ('2024-01-24', 6, 'Books', 9000.00, 180, 'West'),
                                                                                                             ('2024-01-25', 4, 'Electronics', 41000.00, 65, 'West'),
                                                                                                             ('2024-01-26', 2, 'Clothing', 24000.00, 100, 'South'),
                                                                                                             ('2024-01-27', 5, 'Books', 11000.00, 220, 'East'),
                                                                                                             ('2024-01-28', 7, 'Electronics', 29000.00, 45, 'North'),
                                                                                                             ('2024-01-29', 3, 'Clothing', 19000.00, 75, 'East'),
                                                                                                             ('2024-01-30', 6, 'Books', 13000.00, 160, 'West'),
                                                                                                             ('2024-01-31', 1, 'Electronics', 35000.00, 55, 'North'),
                                                                                                             ('2024-02-01', 4, 'Clothing', 21000.00, 85, 'West'),
                                                                                                             ('2024-02-02', 7, 'Books', 10000.00, 190, 'North'),
                                                                                                             ('2024-02-03', 2, 'Electronics', 39000.00, 70, 'South');

INSERT INTO student_grades VALUES
                               (1, 'Emma Wilson', 'Mathematics', 92.5, '2024-05-15', 'Spring 2024', 3),
                               (2, 'Liam Chen', 'Mathematics', 88.0, '2024-05-15', 'Spring 2024', 3),
                               (3, 'Sophie Rodriguez', 'Physics', 95.0, '2024-05-20', 'Spring 2024', 4),
                               (4, 'Mason Kim', 'Chemistry', 87.5, '2024-05-18', 'Spring 2024', 3),
                               (5, 'Ava Patel', 'Mathematics', 91.0, '2024-05-15', 'Spring 2024', 3),
                               (6, 'Noah Johnson', 'Physics', 89.5, '2024-05-20', 'Spring 2024', 4),
                               (7, 'Isabella Brown', 'Chemistry', 93.0, '2024-05-18', 'Spring 2024', 3),
                               (8, 'Ethan Davis', 'Mathematics', 85.5, '2024-05-15', 'Spring 2024', 3),
                               (9, 'Mia Garcia', 'Physics', 90.0, '2024-05-20', 'Spring 2024', 4),
                               (10, 'James Martinez', 'Biology', 88.5, '2024-05-22', 'Spring 2024', 4),
                               (11, 'Charlotte Lee', 'Chemistry', 94.5, '2024-05-18', 'Spring 2024', 3),
                               (12, 'Benjamin Taylor', 'Mathematics', 86.0, '2024-05-15', 'Spring 2024', 3),
                               (13, 'Amelia Anderson', 'Biology', 92.0, '2024-05-22', 'Spring 2024', 4),
                               (14, 'Lucas Thompson', 'Physics', 87.0, '2024-05-20', 'Spring 2024', 4),
                               (15, 'Harper White', 'Chemistry', 90.5, '2024-05-18', 'Spring 2024', 3),
                               (16, 'Alexander Harris', 'Biology', 89.0, '2024-05-22', 'Spring 2024', 4),
                               (17, 'Evelyn Clark', 'Mathematics', 93.5, '2024-05-15', 'Spring 2024', 3),
                               (18, 'Michael Lewis', 'Physics', 91.5, '2024-05-20', 'Spring 2024', 4),
                               (19, 'Abigail Walker', 'Biology', 87.5, '2024-05-22', 'Spring 2024', 4),
                               (20, 'William Hall', 'Chemistry', 92.0, '2024-05-18', 'Spring 2024', 3);




select * from student_grades;
select * from sales_data;

select sales_data.product_category , quantity_sold , sales_data.sale_amount , row_number()
        over (order by quantity_sold desc) as sr_no from sales_data;

select  student_name, subject , grade , rank()
        over (order by grade desc) as sr_no from student_grades;


select  student_name, subject , grade , rank()
        over (partition by student_grades.subject order by grade desc) as sr_no from student_grades;

select student_grades.student_name , grade , student_grades.subject,
    row_number() over (partition by student_grades.subject order by grade desc,student_grades.student_name) as sr_no,
    rank() over (partition by student_grades.subject order by grade desc,student_grades.student_name) as rankk,
    dense_rank() over (partition by student_grades.subject order by grade desc,student_grades.student_name) as dense
from student_grades;

with cte as (
    select name ,
           salary ,
           emp.dept_id ,
           row_number() over (partition by dept_id order by salary desc) as dept_top3
    from emp
) select dept_id , name , salary from cte where dept_top3 <= 2;

-- First insert managers (no mgr_id reference)
INSERT INTO emp (name, email, mgr_id, dept_id, salary, hire_dt) VALUES
                                                                    ('John CEO', 'john.ceo@company.com', NULL, 1, 150000.00, '2015-01-01'),
                                                                    ('Sarah VP Eng', 'sarah.vp@company.com', 1, 1, 120000.00, '2016-03-15'),
                                                                    ('Mike VP Sales', 'mike.vp@company.com', 1, 2, 120000.00, '2016-06-20'),
                                                                    ('Lisa VP HR', 'lisa.vp@company.com', 1, 3, 115000.00, '2017-02-10'),
                                                                    ('David Dir Eng', 'david.dir@company.com', 2, 1, 95000.00, '2017-08-15'),
                                                                    ('Emma Dir Sales', 'emma.dir@company.com', 3, 2, 95000.00, '2018-01-20'),
                                                                    ('Robert Dir HR', 'robert.dir@company.com', 4, 3, 90000.00, '2018-05-10');

-- Then insert employees with manager references and LOTS of salary duplicates
INSERT INTO emp (name, email, mgr_id, dept_id, salary, hire_dt) VALUES
                                                                    ('Alice Johnson', 'alice.j@company.com', 5, 1, 85000.00, '2019-03-15'),
                                                                    ('Bob Smith', 'bob.s@company.com', 5, 1, 85000.00, '2019-07-22'),
                                                                    ('Carol Davis', 'carol.d@company.com', 6, 2, 75000.00, '2020-01-10'),
                                                                    ('Frank Miller', 'frank.m@company.com', 5, 1, 85000.00, '2019-11-30'),
                                                                    ('Grace Taylor', 'grace.t@company.com', 7, 3, 65000.00, '2020-08-12'),
                                                                    ('Henry Anderson', 'henry.a@company.com', 6, 2, 75000.00, '2021-06-18'),
                                                                    ('Ivy Thomas', 'ivy.t@company.com', 5, 1, 90000.00, '2018-04-03'),
                                                                    ('Jack Jackson', 'jack.j@company.com', 6, 2, 70000.00, '2020-12-01'),
                                                                    ('Karen White', 'karen.w@company.com', 6, 2, 75000.00, '2019-03-25'),
                                                                    ('Liam Harris', 'liam.h@company.com', 7, 3, 65000.00, '2021-09-07'),
                                                                    ('Mia Clark', 'mia.c@company.com', 5, 1, 85000.00, '2020-05-20'),
                                                                    ('Noah Lewis', 'noah.l@company.com', 6, 2, 70000.00, '2022-01-15'),
                                                                    ('Olivia Walker', 'olivia.w@company.com', 6, 2, 75000.00, '2019-10-08'),
                                                                    ('Paul Hall', 'paul.h@company.com', 5, 1, 90000.00, '2018-12-12'),
                                                                    ('Quinn Young', 'quinn.y@company.com', 7, 3, 60000.00, '2021-04-22'),
                                                                    ('Rachel King', 'rachel.k@company.com', 6, 2, 70000.00, '2020-07-14'),
                                                                    ('Sam Wright', 'sam.w@company.com', 6, 2, 70000.00, '2021-11-03'),
                                                                    ('Tina Lopez', 'tina.l@company.com', 5, 1, 85000.00, '2019-02-28'),
                                                                    ('Uma Patel', 'uma.p@company.com', 7, 3, 65000.00, '2020-11-05'),
                                                                    ('Victor Chen', 'victor.c@company.com', 5, 1, 90000.00, '2021-03-18'),
                                                                    ('Wendy Kim', 'wendy.k@company.com', 6, 2, 75000.00, '2021-08-22'),
                                                                    ('Xavier Brown', 'xavier.b@company.com', 7, 3, 60000.00, '2022-02-14'),
                                                                    ('Yuki Tanaka', 'yuki.t@company.com', 5, 1, 85000.00, '2022-05-30');

INSERT INTO sales_data (sale_date, salesperson_id, product_category, sale_amount, quantity_sold, region) VALUES
                                                                                                             ('2024-01-15', 1, 'Electronics', 25000.00, 100, 'North'),
                                                                                                             ('2024-01-16', 2, 'Clothing', 18000.00, 75, 'South'),
                                                                                                             ('2024-01-17', 3, 'Electronics', 32000.00, 100, 'East'),
                                                                                                             ('2024-01-18', 1, 'Books', 8000.00, 50, 'North'),
                                                                                                             ('2024-01-19', 4, 'Electronics', 45000.00, 150, 'West'),
                                                                                                             ('2024-01-20', 2, 'Clothing', 22000.00, 75, 'South'),
                                                                                                             ('2024-01-21', 5, 'Books', 12000.00, 50, 'East'),
                                                                                                             ('2024-01-22', 3, 'Electronics', 38000.00, 100, 'East'),
                                                                                                             ('2024-01-23', 1, 'Clothing', 16000.00, 75, 'North'),
                                                                                                             ('2024-01-24', 6, 'Books', 9000.00, 25, 'West'),
                                                                                                             ('2024-01-25', 4, 'Electronics', 41000.00, 150, 'West'),
                                                                                                             ('2024-01-26', 2, 'Clothing', 24000.00, 100, 'South'),
                                                                                                             ('2024-01-27', 5, 'Books', 11000.00, 50, 'East'),
                                                                                                             ('2024-01-28', 7, 'Electronics', 29000.00, 100, 'North'),
                                                                                                             ('2024-01-29', 3, 'Clothing', 19000.00, 75, 'East'),
                                                                                                             ('2024-01-30', 6, 'Books', 13000.00, 25, 'West'),
                                                                                                             ('2024-01-31', 1, 'Electronics', 35000.00, 150, 'North'),
                                                                                                             ('2024-02-01', 4, 'Clothing', 21000.00, 75, 'West'),
                                                                                                             ('2024-02-02', 7, 'Books', 10000.00, 25, 'North'),
                                                                                                             ('2024-02-03', 2, 'Electronics', 39000.00, 150, 'South'),
                                                                                                             ('2024-02-04', 5, 'Clothing', 20000.00, 100, 'East'),
                                                                                                             ('2024-02-05', 3, 'Books', 14000.00, 50, 'East'),
                                                                                                             ('2024-02-06', 6, 'Electronics', 33000.00, 100, 'West'),
                                                                                                             ('2024-02-07', 1, 'Clothing', 17000.00, 75, 'North'),
                                                                                                             ('2024-02-08', 4, 'Books', 12500.00, 25, 'West'),
                                                                                                             ('2024-02-09', 7, 'Electronics', 31000.00, 150, 'North'),
                                                                                                             ('2024-02-10', 2, 'Clothing', 23000.00, 100, 'South'),
                                                                                                             ('2024-02-11', 5, 'Books', 15000.00, 50, 'East'),
                                                                                                             ('2024-02-12', 3, 'Electronics', 37000.00, 150, 'East'),
                                                                                                             ('2024-02-13', 6, 'Clothing', 18500.00, 75, 'West');



INSERT INTO student_grades VALUES
-- Rows 21-50 (with explicit student_id starting from 21)
(21, 'Emma Wilson', 'Mathematics', 92.5, '2024-05-15', 'Spring 2024', 3),
(22, 'Liam Chen', 'Mathematics', 88.0, '2024-05-15', 'Spring 2024', 3),
(23, 'Sophie Rodriguez', 'Physics', 95.0, '2024-05-20', 'Spring 2024', 4),
(24, 'Mason Kim', 'Chemistry', 87.5, '2024-05-18', 'Spring 2024', 3),
(25, 'Ava Patel', 'Mathematics', 92.5, '2024-05-15', 'Spring 2024', 3),      -- Duplicate 92.5
(26, 'Noah Johnson', 'Physics', 89.5, '2024-05-20', 'Spring 2024', 4),
(27, 'Isabella Brown', 'Chemistry', 87.5, '2024-05-18', 'Spring 2024', 3),   -- Duplicate 87.5
(28, 'Ethan Davis', 'Mathematics', 88.0, '2024-05-15', 'Spring 2024', 3),    -- Duplicate 88.0
(29, 'Mia Garcia', 'Physics', 95.0, '2024-05-20', 'Spring 2024', 4),         -- Duplicate 95.0
(30, 'James Martinez', 'Biology', 90.0, '2024-05-22', 'Spring 2024', 4),
(31, 'Charlotte Lee', 'Chemistry', 87.5, '2024-05-18', 'Spring 2024', 3),    -- Duplicate 87.5
(32, 'Benjamin Taylor', 'Mathematics', 88.0, '2024-05-15', 'Spring 2024', 3),-- Duplicate 88.0
(33, 'Amelia Anderson', 'Biology', 90.0, '2024-05-22', 'Spring 2024', 4),    -- Duplicate 90.0
(34, 'Lucas Thompson', 'Physics', 89.5, '2024-05-20', 'Spring 2024', 4),     -- Duplicate 89.5
(35, 'Harper White', 'Chemistry', 93.0, '2024-05-18', 'Spring 2024', 3),
(36, 'Alexander Harris', 'Biology', 85.0, '2024-05-22', 'Spring 2024', 4),
(37, 'Evelyn Clark', 'Mathematics', 92.5, '2024-05-15', 'Spring 2024', 3),   -- Duplicate 92.5
(38, 'Michael Lewis', 'Physics', 95.0, '2024-05-20', 'Spring 2024', 4),      -- Duplicate 95.0
(39, 'Abigail Walker', 'Biology', 85.0, '2024-05-22', 'Spring 2024', 4),     -- Duplicate 85.0
(40, 'William Hall', 'Chemistry', 93.0, '2024-05-18', 'Spring 2024', 3),     -- Duplicate 93.0
(41, 'Grace Murphy', 'Mathematics', 88.0, '2024-05-15', 'Spring 2024', 3),   -- Duplicate 88.0
(42, 'Oliver Scott', 'Physics', 89.5, '2024-05-20', 'Spring 2024', 4),       -- Duplicate 89.5
(43, 'Lily Cooper', 'Chemistry', 87.5, '2024-05-18', 'Spring 2024', 3),      -- Duplicate 87.5
(44, 'Henry Reed', 'Biology', 90.0, '2024-05-22', 'Spring 2024', 4),         -- Duplicate 90.0
(45, 'Zoe Bailey', 'Mathematics', 92.5, '2024-05-15', 'Spring 2024', 3),     -- Duplicate 92.5
(46, 'Jack Foster', 'Physics', 95.0, '2024-05-20', 'Spring 2024', 4),        -- Duplicate 95.0
(47, 'Maya Hughes', 'Chemistry', 93.0, '2024-05-18', 'Spring 2024', 3),      -- Duplicate 93.0
(48, 'Ryan Powell', 'Biology', 85.0, '2024-05-22', 'Spring 2024', 4),        -- Duplicate 85.0
(49, 'Chloe Ward', 'Mathematics', 88.0, '2024-05-15', 'Spring 2024', 3),     -- Duplicate 88.0
(50, 'Luke Torres', 'Physics', 89.5, '2024-05-20', 'Spring 2024', 4),        -- Duplicate 89.5
-- Additional 20 rows to make it 50 total
(51, 'Aria Patel', 'Mathematics', 92.5, '2024-05-15', 'Spring 2024', 3),     -- Duplicate 92.5
(52, 'Kai Thompson', 'Physics', 95.0, '2024-05-20', 'Spring 2024', 4),       -- Duplicate 95.0
(53, 'Luna Martinez', 'Chemistry', 87.5, '2024-05-18', 'Spring 2024', 3),    -- Duplicate 87.5
(54, 'Ezra Johnson', 'Biology', 90.0, '2024-05-22', 'Spring 2024', 4),       -- Duplicate 90.0
(55, 'Nova Brown', 'Mathematics', 88.0, '2024-05-15', 'Spring 2024', 3),     -- Duplicate 88.0
(56, 'Phoenix Garcia', 'Physics', 89.5, '2024-05-20', 'Spring 2024', 4),     -- Duplicate 89.5
(57, 'River Lee', 'Chemistry', 93.0, '2024-05-18', 'Spring 2024', 3),        -- Duplicate 93.0
(58, 'Sage Wilson', 'Biology', 85.0, '2024-05-22', 'Spring 2024', 4),        -- Duplicate 85.0
(59, 'Atlas Davis', 'Mathematics', 92.5, '2024-05-15', 'Spring 2024', 3),    -- Duplicate 92.5
(60, 'Iris Chen', 'Physics', 95.0, '2024-05-20', 'Spring 2024', 4),          -- Duplicate 95.0
(61, 'Orion Kim', 'Chemistry', 87.5, '2024-05-18', 'Spring 2024', 3),        -- Duplicate 87.5
(62, 'Wren Anderson', 'Biology', 90.0, '2024-05-22', 'Spring 2024', 4),      -- Duplicate 90.0
(63, 'Felix Rodriguez', 'Mathematics', 88.0, '2024-05-15', 'Spring 2024', 3),-- Duplicate 88.0
(64, 'Stella Harris', 'Physics', 89.5, '2024-05-20', 'Spring 2024', 4),      -- Duplicate 89.5
(65, 'Jasper White', 'Chemistry', 93.0, '2024-05-18', 'Spring 2024', 3),     -- Duplicate 93.0
(66, 'Hazel Clark', 'Biology', 85.0, '2024-05-22', 'Spring 2024', 4),        -- Duplicate 85.0
(67, 'Leo Murphy', 'Mathematics', 92.5, '2024-05-15', 'Spring 2024', 3),     -- Duplicate 92.5
(68, 'Willow Scott', 'Physics', 95.0, '2024-05-20', 'Spring 2024', 4),       -- Duplicate 95.0
(69, 'Rowan Cooper', 'Chemistry', 87.5, '2024-05-18', 'Spring 2024', 3),     -- Duplicate 87.5
(70, 'Indigo Reed', 'Biology', 90.0, '2024-05-22', 'Spring 2024', 4);

select customer_id,total_amount from orders;

select orders.customer_id , sum(orders.total_amount) revenue,
       ntile(1) over (order by sum(orders.total_amount) desc) as revenue_decile
from orders
group by customer_id
order by revenue desc;

select orders.customer_id , sum(orders.total_amount) revenue,
       ntile(2) over (order by sum(orders.total_amount) desc) as revenue_decile
from orders
group by customer_id
order by revenue desc;

select orders.customer_id , sum(orders.total_amount) revenue,
       ntile(3) over (order by sum(orders.total_amount) desc) as revenue_decile
from orders
group by customer_id
order by revenue desc;

select orders.customer_id , sum(orders.total_amount) revenue,
       ntile(7) over (order by sum(orders.total_amount) desc) as revenue_decile
from orders
group by customer_id
order by revenue desc;

select orders.customer_id , sum(orders.total_amount) revenue,
       ntile(199) over (order by sum(orders.total_amount) desc) as revenue_decile
from orders
group by customer_id
order by revenue desc;

select student_grades.student_name , grade , student_grades.subject,
       row_number() over (partition by student_grades.subject order by grade desc) as sr_no,
       rank() over (partition by student_grades.subject order by grade desc) as rankk,
       dense_rank() over (partition by student_grades.subject order by grade desc) as dense,
       percent_rank() over (partition by subject order by grade)*100 as percentile,
       cume_dist() over (partition by subject order by grade desc) as c_dist
from student_grades
order by subject,sr_no;


-- partition by , window func-----------------------------------------------------------------------------------------------------------------------------

-- Create table (portable types)
CREATE TABLE sample_data (
                             id int,
                             name VARCHAR(100),
                             category VARCHAR(50),
                             created_at DATE,
                             amount DECIMAL(10,2)
);

INSERT INTO sample_data (id, name, category, created_at, amount) VALUES
                                                                     (7, 'Golf', 'A', DATE '2024-04-01', 45.00),
                                                                     (8, 'Hotel', 'B', DATE '2024-04-10', 510.10),
                                                                     (9, 'India', 'C', DATE '2024-04-22', 180.00),
                                                                     (10, 'Juliet', 'A', DATE '2024-05-01', 270.30),
                                                                     (1, 'Alpha', 'A', DATE '2024-01-10', 100.00),
                                                                     (2, 'Bravo', 'A', DATE '2024-01-11', 150.50),
                                                                     (3, 'Charlie', 'B', DATE '2024-02-01', 75.25),
                                                                     (4, 'Delta', 'B', DATE '2024-02-15', 220.00),
                                                                     (5, 'Echo', 'C', DATE '2024-03-05', 90.00),
                                                                     (6, 'Foxtrot', 'C', DATE '2024-03-20', 310.75);


select * from sample_data order by id;

-- evaluating dup records using partition by -----------------------------------------------------------------------------------------------------------------
-- - Keep row detail while adding group-level metrics, unlike GROUP BY which collapses rows.
WITH cte AS (
    SELECT id,
           name,
           category,
           created_at,
           amount,
           ROW_NUMBER() OVER (PARTITION BY id, name, category, created_at, amount) AS sr_no
    FROM sample_data
)
SELECT * FROM cte ORDER BY id, sr_no;

select id ,
       row_number() over (partition by id,name,category,created_at,amount) as sr_no
from sample_data ;


with cte as (
    select id ,
           row_number() over (partition by id,name,category,created_at,amount) as sr_no
    from sample_data
)
select id , max(sr_no) as total_enteries from cte where sr_no > 1 group by id;


-- datetime----------------------------------------------------------------------------------------------------------------------------------------------

-- Clean slate
DROP TABLE IF EXISTS datetime_playground;

CREATE TABLE datetime_playground (
id bigserial PRIMARY KEY,
only_date date, -- calendar date
only_time_6 time(6), -- time of day, microseconds
only_timetz_6 time(6) with time zone,-- time with time zone (rarely needed)
ts_no_tz_6 timestamp(6), -- timestamp without time zone
ts_tz_6 timestamptz(6), -- timestamp with time zone; stored UTC, displayed per session tz
dur_interval interval -- duration
);

COMMENT ON COLUMN datetime_playground.only_timetz_6 IS 'Use with caution; SQL-defined type with limited usefulness in practice.';


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
-- Note: timestamp types support very large ranges; shown here with reasonable values
INSERT INTO datetime_playground
(only_date, only_time_6, only_timetz_6, ts_no_tz_6, ts_tz_6, dur_interval)
VALUES
('0001-01-01', '00:00:00.000001', '00:00:00.000001+00', '0001-01-01 00:00:00.000001', '0001-01-01 00:00:00.000001+00', INTERVAL '-10 years 5 days'),
('9999-12-31', '23:59:59.999999', '23:59:59.999999-12', '9999-12-31 23:59:59.999999', '9999-12-31 23:59:59.999999-12', INTERVAL '100 years');

-- Time zone behavior: timestamptz stores UTC, shows in session tz
-- Here we set a literal with offset; value is normalized to UTC internally
INSERT INTO datetime_playground
(only_date, only_time_6, only_timetz_6, ts_no_tz_6, ts_tz_6, dur_interval)
VALUES
('2027-09-09', '10:09:45.000000', '10:09:45.000000+05:30', '2027-09-09 10:09:45.000000', '2027-09-09 10:09:45.000000+05:30', INTERVAL '90 minutes');

-- Inspect what we inserted
SELECT id, only_date, only_time_6, only_timetz_6, ts_no_tz_6, ts_tz_6, dur_interval
FROM datetime_playground

show timezone;
select current_setting('timezone') as sesstz;

select current_timestamp,
	now(),
	localtimestamp,
	current_date,
	current_time;


select extract(year from now()) as y,
	extract(month from now()) as m;

select date_trunc('microsecond' , current_timestamp) as mic,
      DATE_TRUNC('month', CURRENT_TIMESTAMP) AS month_bucket;


select current_date + interval '8 days' as plus8;
SELECT AGE(current_timestamp + interval '26 years 7000 days', current_timestamp - INTERVAL '34 years 4 months 3 days 7 hours 4 minutes 7 seconds 34 milliseconds 100 microseconds') AS agee;

select (timestamp '2027-09-30 23:06:51.979687' at time zone 'Asia/Kolkata') as tz,
		(timestamp '2027-09-30 23:06:51.979687' at time zone 'utc') as tzz,
		(timestamptz '2027-09-30 23:06:51.979687+05:30' at time zone 'utc') as tzzz;


select generate_series(
	   current_date - interval '45 years',
	   current_date,
	   interval '1 days'
) as srs;


-- Formatting for presentation
SELECT TO_CHAR(CURRENT_TIMESTAMP, 'YYYY-MM-DD"T"HH24:MI:SS.USOF') AS iso_8601,
      TO_CHAR(CURRENT_TIMESTAMP, 'Day, Month DD, YYYY at HH12:MI:SS AM') AS readable_format,
      TO_CHAR(CURRENT_TIMESTAMP, 'YYYY-MM-DD HH24:MI:SS') AS standard_format,
      TO_CHAR(CURRENT_TIMESTAMP, 'Mon DD, YYYY') AS short_date,
      TO_CHAR(CURRENT_TIMESTAMP, 'HH24:MI') AS time_only,
      TO_CHAR(CURRENT_TIMESTAMP, 'FMMonth FMDD, YYYY') AS no_padding;


SELECT TO_TIMESTAMP('2027-09-30 23:06:51', 'YYYY-MM-DD HH24:MI:SS') AS parsed_ts,
      TO_DATE('2027-09-30', 'YYYY-MM-DD') AS parsed_date,
      '2027-09-30 23:06:51'::TIMESTAMP AS cast_ts,
      '2027-09-30T23:06:51+05:30'::TIMESTAMPTZ AS cast_tstz;


select extract(epoch from current_timestamp) as tz,
	   to_timestamp(168764950) as ep,
	   to_timestamp(45655606.57486) as ep_micro;




