# Server Functions for MySQL, MSSQL, and PostgreSQL

## Database Server Functions Overview

Server functions in database contexts refer to both:
1. **Database stored procedures/functions** - Code that runs inside the database server
2. **Application server functions** - Backend code that interacts with databases

## MySQL Server Functions

### Built-in MySQL Functions

#### String Functions
```sql
-- Common string functions
SELECT CONCAT('Hello', ' ', 'World');           -- String concatenation
SELECT SUBSTRING('Hello World', 1, 5);         -- Extract substring
SELECT UPPER('hello world');                   -- Convert to uppercase
SELECT LOWER('HELLO WORLD');                   -- Convert to lowercase
SELECT LENGTH('Hello World');                  -- String length
SELECT TRIM('  Hello World  ');               -- Remove whitespace
SELECT REPLACE('Hello World', 'World', 'MySQL'); -- Replace substring
```

#### Date/Time Functions
```sql
-- Date and time operations
SELECT NOW();                                  -- Current datetime
SELECT CURDATE();                             -- Current date
SELECT CURTIME();                             -- Current time
SELECT DATE_ADD(NOW(), INTERVAL 30 DAY);      -- Add 30 days
SELECT DATEDIFF('2024-12-31', '2024-01-01');  -- Difference in days
SELECT DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i:%s'); -- Format date
```

#### Numeric Functions
```sql
-- Mathematical functions
SELECT ROUND(15.678, 2);                      -- Round to 2 decimals
SELECT CEIL(15.1);                            -- Round up
SELECT FLOOR(15.9);                           -- Round down
SELECT ABS(-15);                              -- Absolute value
SELECT RAND();                                -- Random number 0-1
SELECT GREATEST(10, 20, 5);                   -- Maximum value
```

### MySQL Stored Procedures
```sql
-- Creating a stored procedure
DELIMITER //
CREATE PROCEDURE GetUsersByAge(IN min_age INT)
BEGIN
    SELECT * FROM users WHERE age >= min_age;
END //
DELIMITER ;

-- Calling the procedure
CALL GetUsersByAge(18);

-- Procedure with OUT parameter
DELIMITER //
CREATE PROCEDURE GetUserCount(OUT user_count INT)
BEGIN
    SELECT COUNT(*) INTO user_count FROM users;
END //
DELIMITER ;

-- Call and get result
CALL GetUserCount(@count);
SELECT @count;
```

### MySQL User-Defined Functions
```sql
-- Creating a function
DELIMITER //
CREATE FUNCTION CalculateAge(birth_date DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN YEAR(CURDATE()) - YEAR(birth_date);
END //
DELIMITER ;

-- Using the function
SELECT name, CalculateAge(birth_date) as age FROM users;
```

## Microsoft SQL Server (MSSQL) Functions

### Built-in MSSQL Functions

#### String Functions
```sql
-- String manipulation
SELECT CONCAT('Hello', ' ', 'World');          -- Concatenation
SELECT SUBSTRING('Hello World', 1, 5);         -- Extract substring  
SELECT UPPER('hello world');                   -- Uppercase
SELECT LOWER('HELLO WORLD');                   -- Lowercase
SELECT LEN('Hello World');                     -- String length
SELECT LTRIM(RTRIM('  Hello World  '));       -- Trim spaces
SELECT REPLACE('Hello World', 'World', 'SQL'); -- Replace text
SELECT CHARINDEX('World', 'Hello World');      -- Find position
```

#### Date/Time Functions
```sql
-- Date operations
SELECT GETDATE();                              -- Current datetime
SELECT GETUTCDATE();                          -- UTC datetime
SELECT DATEADD(DAY, 30, GETDATE());          -- Add days
SELECT DATEDIFF(DAY, '2024-01-01', GETDATE()); -- Date difference
SELECT FORMAT(GETDATE(), 'yyyy-MM-dd HH:mm:ss'); -- Format date
SELECT YEAR(GETDATE()), MONTH(GETDATE()), DAY(GETDATE());
```

#### Aggregate Functions
```sql
-- Statistical functions
SELECT COUNT(*) FROM users;
SELECT AVG(salary) FROM employees;
SELECT SUM(amount) FROM orders;
SELECT MIN(price), MAX(price) FROM products;
SELECT STDEV(salary) FROM employees;           -- Standard deviation
```

### MSSQL Stored Procedures
```sql
-- Stored procedure with parameters
CREATE PROCEDURE GetEmployeesByDepartment
    @DepartmentId INT,
    @MinSalary DECIMAL(10,2) = 0
AS
BEGIN
    SELECT * FROM employees 
    WHERE department_id = @DepartmentId 
    AND salary >= @MinSalary;
END;

-- Execute procedure
EXEC GetEmployeesByDepartment @DepartmentId = 1, @MinSalary = 50000;

-- Procedure with output parameter
CREATE PROCEDURE GetEmployeeStats
    @DepartmentId INT,
    @TotalCount INT OUTPUT,
    @AvgSalary DECIMAL(10,2) OUTPUT
AS
BEGIN
    SELECT 
        @TotalCount = COUNT(*),
        @AvgSalary = AVG(salary)
    FROM employees 
    WHERE department_id = @DepartmentId;
END;
```

### MSSQL User-Defined Functions
```sql
-- Scalar function
CREATE FUNCTION dbo.GetFullName(@FirstName NVARCHAR(50), @LastName NVARCHAR(50))
RETURNS NVARCHAR(101)
AS
BEGIN
    RETURN @FirstName + ' ' + @LastName;
END;

-- Table-valued function
CREATE FUNCTION dbo.GetEmployeesByDept(@DeptId INT)
RETURNS TABLE
AS
RETURN
(
    SELECT * FROM employees WHERE department_id = @DeptId
);

-- Usage
SELECT dbo.GetFullName(first_name, last_name) as full_name FROM employees;
SELECT * FROM dbo.GetEmployeesByDept(1);
```

## PostgreSQL Server Functions

### Built-in PostgreSQL Functions

#### String Functions
```sql
-- String operations
SELECT CONCAT('Hello', ' ', 'World');          -- Concatenation
SELECT 'Hello' || ' ' || 'World';             -- PostgreSQL concatenation
SELECT SUBSTRING('Hello World' FROM 1 FOR 5);  -- Extract substring
SELECT UPPER('hello world');                   -- Uppercase
SELECT LOWER('HELLO WORLD');                   -- Lowercase
SELECT LENGTH('Hello World');                  -- String length
SELECT TRIM('  Hello World  ');               -- Remove whitespace
SELECT REPLACE('Hello World', 'World', 'PostgreSQL');
```

#### Date/Time Functions
```sql
-- Date operations
SELECT NOW();                                  -- Current timestamp
SELECT CURRENT_DATE;                          -- Current date
SELECT CURRENT_TIME;                          -- Current time
SELECT NOW() + INTERVAL '30 days';           -- Add interval
SELECT AGE(NOW(), '1990-01-01');             -- Age calculation
SELECT EXTRACT(YEAR FROM NOW());             -- Extract year
SELECT TO_CHAR(NOW(), 'YYYY-MM-DD HH24:MI:SS'); -- Format date
```

#### JSON Functions (PostgreSQL specialty)
```sql
-- JSON operations
SELECT '{"name": "John", "age": 30}'::json ->> 'name';  -- Extract text
SELECT '{"items": [1,2,3]}'::json -> 'items' ->> 0;    -- Array element
SELECT json_array_length('[1,2,3,4]'::json);           -- Array length
SELECT row_to_json(users) FROM users;                   -- Row to JSON
```

### PostgreSQL Functions (PL/pgSQL)
```sql
-- Basic function
CREATE OR REPLACE FUNCTION calculate_age(birth_date DATE)
RETURNS INTEGER AS $$
BEGIN
    RETURN EXTRACT(YEAR FROM AGE(NOW(), birth_date));
END;
$$ LANGUAGE plpgsql;

-- Function with multiple parameters and logic
CREATE OR REPLACE FUNCTION get_employee_grade(
    salary DECIMAL,
    experience INTEGER
)
RETURNS TEXT AS $$
DECLARE
    grade TEXT;
BEGIN
    IF salary > 100000 AND experience > 5 THEN
        grade := 'Senior';
    ELSIF salary > 60000 OR experience > 3 THEN
        grade := 'Mid-level';
    ELSE
        grade := 'Junior';
    END IF;
    
    RETURN grade;
END;
$$ LANGUAGE plpgsql;

-- Table-returning function
CREATE OR REPLACE FUNCTION get_high_earners(min_salary DECIMAL)
RETURNS TABLE(
    id INTEGER,
    name TEXT,
    salary DECIMAL,
    department TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT e.id, e.name, e.salary, d.name
    FROM employees e
    JOIN departments d ON e.dept_id = d.id
    WHERE e.salary >= min_salary;
END;
$$ LANGUAGE plpgsql;
```

### PostgreSQL Stored Procedures
```sql
-- Stored procedure (PostgreSQL 11+)
CREATE OR REPLACE PROCEDURE update_employee_salary(
    emp_id INTEGER,
    new_salary DECIMAL
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE employees 
    SET salary = new_salary, 
        updated_at = NOW()
    WHERE id = emp_id;
    
    -- Log the change
    INSERT INTO salary_history(employee_id, old_salary, new_salary, changed_at)
    SELECT id, salary, new_salary, NOW()
    FROM employees 
    WHERE id = emp_id;
    
    COMMIT;
END;
$$;

-- Call procedure
CALL update_employee_salary(123, 75000.00);
```

## Application Server Functions

### Node.js with Database Connections

#### MySQL Connection (using mysql2)
```javascript
const mysql = require('mysql2/promise');

// Connection pool
const pool = mysql.createPool({
  host: 'localhost',
  user: 'username',
  password: 'password',
  database: 'mydb',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

// Server function to get users
async function getUsers(minAge = 0) {
  try {
    const [rows] = await pool.execute(
      'SELECT * FROM users WHERE age >= ?',
      [minAge]
    );
    return rows;
  } catch (error) {
    throw new Error(`Database error: ${error.message}`);
  }
}

// Server function to create user
async function createUser(userData) {
  const { name, email, age } = userData;
  try {
    const [result] = await pool.execute(
      'INSERT INTO users (name, email, age) VALUES (?, ?, ?)',
      [name, email, age]
    );
    return { id: result.insertId, ...userData };
  } catch (error) {
    throw new Error(`Failed to create user: ${error.message}`);
  }
}
```

#### MSSQL Connection (using mssql)
```javascript
const sql = require('mssql');

// Configuration
const config = {
  user: 'username',
  password: 'password',
  server: 'localhost',
  database: 'mydb',
  options: {
    trustServerCertificate: true
  }
};

// Server function for MSSQL
async function getEmployees(departmentId) {
  try {
    await sql.connect(config);
    const request = new sql.Request();
    request.input('deptId', sql.Int, departmentId);
    
    const result = await request.query(`
      SELECT * FROM employees 
      WHERE department_id = @deptId
    `);
    
    return result.recordset;
  } catch (error) {
    throw new Error(`Database error: ${error.message}`);
  }
}

// Call stored procedure
async function callStoredProcedure(empId, newSalary) {
  try {
    const request = new sql.Request();
    request.input('EmployeeId', sql.Int, empId);
    request.input('NewSalary', sql.Decimal(10,2), newSalary);
    request.output('Result', sql.VarChar(50));
    
    await request.execute('UpdateEmployeeSalary');
    return request.parameters.Result.value;
  } catch (error) {
    throw new Error(`Procedure error: ${error.message}`);
  }
}
```

#### PostgreSQL Connection (using pg)
```javascript
const { Pool } = require('pg');

// Connection pool
const pool = new Pool({
  user: 'username',
  host: 'localhost',
  database: 'mydb',
  password: 'password',
  port: 5432,
});

// Server function with transaction
async function transferFunds(fromAccount, toAccount, amount) {
  const client = await pool.connect();
  
  try {
    await client.query('BEGIN');
    
    // Deduct from source account
    await client.query(
      'UPDATE accounts SET balance = balance - $1 WHERE id = $2',
      [amount, fromAccount]
    );
    
    // Add to destination account
    await client.query(
      'UPDATE accounts SET balance = balance + $1 WHERE id = $2',
      [amount, toAccount]
    );
    
    await client.query('COMMIT');
    return { success: true, message: 'Transfer completed' };
  } catch (error) {
    await client.query('ROLLBACK');
    throw new Error(`Transfer failed: ${error.message}`);
  } finally {
    client.release();
  }
}

// Using PostgreSQL function
async function getEmployeeGrades() {
  try {
    const result = await pool.query(`
      SELECT name, salary, get_employee_grade(salary, experience) as grade
      FROM employees
    `);
    return result.rows;
  } catch (error) {
    throw new Error(`Query error: ${error.message}`);
  }
}
```

## Performance and Best Practices

### Query Optimization
```sql
-- Use indexes
CREATE INDEX idx_users_age ON users(age);
CREATE INDEX idx_employees_dept ON employees(department_id);

-- Avoid SELECT *
SELECT name, email FROM users WHERE age > 18;

-- Use LIMIT/TOP for large datasets
-- MySQL/PostgreSQL
SELECT * FROM users ORDER BY created_at DESC LIMIT 10;

-- SQL Server
SELECT TOP 10 * FROM users ORDER BY created_at DESC;
```

### Connection Management
```javascript
// Use connection pooling
const poolConfig = {
  min: 2,
  max: 10,
  acquireTimeoutMillis: 30000,
  createTimeoutMillis: 3000,
  destroyTimeoutMillis: 5000,
  idleTimeoutMillis: 30000,
  reapIntervalMillis: 1000,
  createRetryIntervalMillis: 100,
  propagateCreateError: false
};
```

### Error Handling
```javascript
async function safeDBOperation(query, params) {
  try {
    const result = await db.query(query, params);
    return { success: true, data: result };
  } catch (error) {
    console.error('Database error:', error);
    return { 
      success: false, 
      error: process.env.NODE_ENV === 'production' 
        ? 'Database operation failed' 
        : error.message 
    };
  }
}
```

# 🔧 RIGHT and LEFT String Functions Across Databases!
## 📝 Function Syntax:
--- MySQL:
sql-- LEFT function
LEFT(string, length)

-- RIGHT function  
RIGHT(string, length)
SQL Server:
sql-- LEFT function
LEFT(string, length)

-- RIGHT function
RIGHT(string, length)
PostgreSQL:
sql-- LEFT function
LEFT(string, length)

-- RIGHT function
RIGHT(string, length)
🎯 All three databases support both functions with identical syntax!
💡 Practical Examples:
Extract first 3 characters:
sql-- All databases
SELECT LEFT('Hello World', 3);  -- Returns: 'Hel'
Extract last 5 characters:
sql-- All databases  
SELECT RIGHT('Hello World', 5);  -- Returns: 'World'
Real-world usage:
sql-- Extract area code from phone number
SELECT 
    name,
    LEFT(phone, 3) AS area_code,
    RIGHT(phone, 4) AS last_four
FROM customers
WHERE phone IS NOT NULL;

-- Get file extension
SELECT 
    filename,
    RIGHT(filename, 3) AS extension
FROM documents
WHERE filename LIKE '%.%';

-- Extract initials
SELECT 
    name,
    LEFT(first_name, 1) + LEFT(last_name, 1) AS initials
FROM employees;
🔧 Advanced Examples:
Truncate long text:
sql-- Show first 50 chars with ellipsis
SELECT 
    CASE 
        WHEN LEN(description) > 50 
        THEN LEFT(description, 47) + '...'
        ELSE description 
    END AS short_desc
FROM products;
Extract parts of codes:
sql-- Product code: 'CAT-2024-001'
SELECT 
    product_code,
    LEFT(product_code, 3) AS category,        -- 'CAT'
    RIGHT(product_code, 3) AS sequence_num    -- '001'
FROM products
WHERE product_code LIKE '%-%-%';
⚠️ Edge Cases:
Length longer than string:
sqlSELECT LEFT('Hi', 10);   -- Returns: 'Hi' (doesn't error)
SELECT RIGHT('Hi', 10);  -- Returns: 'Hi' (doesn't error)
Zero or negative length:
sqlSELECT LEFT('Hello', 0);   -- Returns: '' (empty string)
SELECT LEFT('Hello', -1);  -- Returns: '' (empty string)
NULL handling:
sqlSELECT LEFT(NULL, 5);      -- Returns: NULL
SELECT RIGHT('Hello', NULL); -- Returns: NULL

--- 
