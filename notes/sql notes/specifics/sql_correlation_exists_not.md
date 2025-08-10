# Complete Guide to Correlation, EXISTS, and NOT EXISTS

## Table of Contents
1. [Correlation (Correlated Subqueries)](#correlation)
2. [EXISTS Operator](#exists-operator)
3. [NOT EXISTS Operator](#not-exists-operator)
4. [Performance Considerations](#performance-considerations)
5. [Advanced Examples](#advanced-examples)

---

## Correlation

### What is Correlation?
Correlation in SQL refers to **correlated subqueries** - inner queries that reference columns from the outer query. The inner query is executed once for each row of the outer query.

### Basic Correlation Syntax
```sql
-- General syntax
SELECT columns
FROM table1 t1
WHERE condition AND (
    SELECT columns 
    FROM table2 t2 
    WHERE t2.column = t1.column  -- This creates correlation
);
```

### Sample Tables for Examples
```sql
-- Employees table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department_id INT,
    salary DECIMAL(10,2),
    hire_date DATE
);

-- Departments table  
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);

-- Orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2)
);

-- Customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);
```

---

## EXISTS Operator

### What is EXISTS?
EXISTS is a logical operator that tests whether a subquery returns any rows. It returns TRUE if the subquery contains any rows, FALSE otherwise.

### MySQL EXISTS Examples

```sql
-- Find employees who work in departments that exist
SELECT emp_id, name, department_id
FROM employees e
WHERE EXISTS (
    SELECT 1 
    FROM departments d 
    WHERE d.dept_id = e.department_id
);

-- Find customers who have placed orders
SELECT customer_id, customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);

-- Find employees earning more than average in their department
SELECT emp_id, name, salary, department_id
FROM employees e1
WHERE EXISTS (
    SELECT 1
    FROM employees e2
    WHERE e2.department_id = e1.department_id
    HAVING e1.salary > AVG(e2.salary)
);

-- Find departments with employees hired in the last year
SELECT dept_id, dept_name
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.dept_id
    AND e.hire_date >= DATE_SUB(NOW(), INTERVAL 1 YEAR)
);

-- Complex EXISTS with multiple conditions
SELECT customer_id, customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
    AND o.order_date >= '2024-01-01'
    AND o.total_amount > 1000
);
```

### MSSQL EXISTS Examples

```sql
-- Find employees who work in existing departments
SELECT emp_id, name, department_id
FROM employees e
WHERE EXISTS (
    SELECT 1 
    FROM departments d 
    WHERE d.dept_id = e.department_id
);

-- Find customers who have placed orders
SELECT customer_id, customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);

-- Find employees earning more than department average
SELECT emp_id, name, salary, department_id
FROM employees e1
WHERE EXISTS (
    SELECT 1
    FROM employees e2
    WHERE e2.department_id = e1.department_id
    HAVING e1.salary > AVG(e2.salary)
);

-- Find departments with recent hires
SELECT dept_id, dept_name
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.dept_id
    AND e.hire_date >= DATEADD(YEAR, -1, GETDATE())
);

-- EXISTS with CTE (Common Table Expression)
WITH HighValueOrders AS (
    SELECT customer_id
    FROM orders
    WHERE total_amount > 5000
)
SELECT customer_id, customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM HighValueOrders h
    WHERE h.customer_id = c.customer_id
);

-- Nested EXISTS
SELECT emp_id, name
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM departments d
    WHERE d.dept_id = e.department_id
    AND EXISTS (
        SELECT 1
        FROM orders o
        INNER JOIN customers c ON o.customer_id = c.customer_id
        WHERE c.city = d.location
    )
);
```

### PostgreSQL EXISTS Examples

```sql
-- Find employees in existing departments
SELECT emp_id, name, department_id
FROM employees e
WHERE EXISTS (
    SELECT 1 
    FROM departments d 
    WHERE d.dept_id = e.department_id
);

-- Find customers with orders
SELECT customer_id, customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);

-- Find employees earning above department average
SELECT emp_id, name, salary, department_id
FROM employees e1
WHERE EXISTS (
    SELECT 1
    FROM employees e2
    WHERE e2.department_id = e1.department_id
    HAVING e1.salary > AVG(e2.salary)
);

-- Find departments with recent hires
SELECT dept_id, dept_name
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.dept_id
    AND e.hire_date >= CURRENT_DATE - INTERVAL '1 year'
);

-- EXISTS with array operations (PostgreSQL specific)
SELECT customer_id, customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
    AND EXTRACT(MONTH FROM o.order_date) = ANY(ARRAY[1,2,3]) -- Q1 orders
);

-- EXISTS with window functions
SELECT emp_id, name, salary
FROM employees e1
WHERE EXISTS (
    SELECT 1
    FROM (
        SELECT emp_id, 
               RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) as salary_rank
        FROM employees
    ) ranked
    WHERE ranked.emp_id = e1.emp_id
    AND ranked.salary_rank <= 3
);
```

---

## NOT EXISTS Operator

### What is NOT EXISTS?
NOT EXISTS returns TRUE if the subquery returns no rows, FALSE if it returns any rows. It's the logical opposite of EXISTS.

### MySQL NOT EXISTS Examples

```sql
-- Find employees not assigned to any department
SELECT emp_id, name
FROM employees e
WHERE NOT EXISTS (
    SELECT 1 
    FROM departments d 
    WHERE d.dept_id = e.department_id
);

-- Find customers who have never placed an order
SELECT customer_id, customer_name
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);

-- Find departments with no employees
SELECT dept_id, dept_name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.dept_id
);

-- Find customers with no orders in the current year
SELECT customer_id, customer_name
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
    AND YEAR(o.order_date) = YEAR(NOW())
);

-- Find employees who don't earn the maximum salary in their department
SELECT emp_id, name, salary, department_id
FROM employees e1
WHERE NOT EXISTS (
    SELECT 1
    FROM employees e2
    WHERE e2.department_id = e1.department_id
    AND e2.salary > e1.salary
);

-- Complex NOT EXISTS - customers without large orders
SELECT customer_id, customer_name
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
    AND o.total_amount > 10000
);
```

### MSSQL NOT EXISTS Examples

```sql
-- Find employees not in any department
SELECT emp_id, name
FROM employees e
WHERE NOT EXISTS (
    SELECT 1 
    FROM departments d 
    WHERE d.dept_id = e.department_id
);

-- Find customers with no orders
SELECT customer_id, customer_name
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);

-- Find empty departments
SELECT dept_id, dept_name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.dept_id
);

-- Find customers with no recent orders
SELECT customer_id, customer_name
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
    AND o.order_date >= DATEADD(MONTH, -6, GETDATE())
);

-- Find non-top earners in each department
SELECT emp_id, name, salary, department_id
FROM employees e1
WHERE NOT EXISTS (
    SELECT 1
    FROM employees e2
    WHERE e2.department_id = e1.department_id
    AND e2.salary > e1.salary
);

-- Using NOT EXISTS with window functions
SELECT customer_id, customer_name
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM (
        SELECT customer_id,
               ROW_NUMBER() OVER (ORDER BY total_amount DESC) as order_rank
        FROM orders
    ) ranked_orders
    WHERE ranked_orders.customer_id = c.customer_id
    AND ranked_orders.order_rank <= 10
);
```

### PostgreSQL NOT EXISTS Examples

```sql
-- Find unassigned employees
SELECT emp_id, name
FROM employees e
WHERE NOT EXISTS (
    SELECT 1 
    FROM departments d 
    WHERE d.dept_id = e.department_id
);

-- Find customers without orders
SELECT customer_id, customer_name
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);

-- Find departments without employees
SELECT dept_id, dept_name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.dept_id
);

-- Find customers without recent orders
SELECT customer_id, customer_name
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
    AND o.order_date >= CURRENT_DATE - INTERVAL '6 months'
);

-- Find non-maximum earners per department
SELECT emp_id, name, salary, department_id
FROM employees e1
WHERE NOT EXISTS (
    SELECT 1
    FROM employees e2
    WHERE e2.department_id = e1.department_id
    AND e2.salary > e1.salary
);

-- NOT EXISTS with JSON operations (PostgreSQL specific)
SELECT customer_id, customer_name
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o,
         json_array_elements_text('["premium", "vip", "gold"]'::json) as status
    WHERE o.customer_id = c.customer_id
    AND o.customer_status = status
);
```

---

## Performance Considerations

### EXISTS vs IN vs JOIN

```sql
-- EXISTS (usually fastest for large datasets)
SELECT customer_id, customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id
);

-- IN (can be slower with large subquery results)
SELECT customer_id, customer_name
FROM customers c
WHERE customer_id IN (
    SELECT DISTINCT customer_id FROM orders
);

-- JOIN (good for retrieving additional columns)
SELECT DISTINCT c.customer_id, c.customer_name
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id;
```

### Optimization Tips

#### MySQL Optimization
```sql
-- Use indexes on correlated columns
CREATE INDEX idx_orders_customer_id ON orders(customer_id);
CREATE INDEX idx_employees_dept_id ON employees(department_id);

-- Prefer EXISTS over IN for better performance
-- Good
WHERE EXISTS (SELECT 1 FROM orders WHERE customer_id = c.customer_id);

-- Less efficient
WHERE customer_id IN (SELECT customer_id FROM orders);

-- Use covering indexes when possible
CREATE INDEX idx_orders_cover ON orders(customer_id, order_date, total_amount);
```

#### MSSQL Optimization
```sql
-- Create appropriate indexes
CREATE INDEX IX_Orders_CustomerID ON orders(customer_id);
CREATE INDEX IX_Employees_DeptID ON employees(department_id);

-- Use query hints when needed
SELECT customer_id, customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1 
    FROM orders o WITH (INDEX(IX_Orders_CustomerID))
    WHERE o.customer_id = c.customer_id
);

-- Consider using APPLY for complex correlations
SELECT c.customer_id, c.customer_name, ca.order_count
FROM customers c
CROSS APPLY (
    SELECT COUNT(*) as order_count
    FROM orders o
    WHERE o.customer_id = c.customer_id
) ca
WHERE ca.order_count > 0;
```

#### PostgreSQL Optimization
```sql
-- Create indexes with specific conditions
CREATE INDEX idx_orders_customer_recent 
ON orders(customer_id) 
WHERE order_date >= CURRENT_DATE - INTERVAL '1 year';

-- Use partial indexes for better performance
CREATE INDEX idx_employees_active 
ON employees(department_id) 
WHERE status = 'active';

-- Analyze query plans
EXPLAIN ANALYZE
SELECT customer_id, customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id
);
```

---

## Advanced Examples

### Multiple Correlations
```sql
-- Find customers who have orders in multiple years
SELECT customer_id, customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1 FROM orders o1 
    WHERE o1.customer_id = c.customer_id 
    AND YEAR(o1.order_date) = 2023
)
AND EXISTS (
    SELECT 1 FROM orders o2 
    WHERE o2.customer_id = c.customer_id 
    AND YEAR(o2.order_date) = 2024
);
```

### Correlated DELETE
```sql
-- MySQL/PostgreSQL
DELETE FROM employees e1
WHERE EXISTS (
    SELECT 1 FROM employees e2
    WHERE e2.department_id = e1.department_id
    AND e2.salary > e1.salary
    AND e2.hire_date < e1.hire_date
);

-- MSSQL
DELETE e1
FROM employees e1
WHERE EXISTS (
    SELECT 1 FROM employees e2
    WHERE e2.department_id = e1.department_id
    AND e2.salary > e1.salary
    AND e2.hire_date < e1.hire_date
);
```

### Correlated UPDATE
```sql
-- Update employee salaries based on department average
UPDATE employees e1
SET salary = (
    SELECT AVG(salary) * 1.1
    FROM employees e2
    WHERE e2.department_id = e1.department_id
)
WHERE EXISTS (
    SELECT 1
    FROM employees e3
    WHERE e3.department_id = e1.department_id
    GROUP BY department_id
    HAVING COUNT(*) > 1
);
```

### Complex Business Logic
```sql
-- Find customers who have consistent ordering patterns
SELECT customer_id, customer_name
FROM customers c
WHERE EXISTS (
    -- Has orders in at least 3 different months
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
    GROUP BY customer_id
    HAVING COUNT(DISTINCT DATE_FORMAT(o.order_date, '%Y-%m')) >= 3  -- MySQL
    -- HAVING COUNT(DISTINCT FORMAT(o.order_date, 'yyyy-MM')) >= 3   -- MSSQL
    -- HAVING COUNT(DISTINCT TO_CHAR(o.order_date, 'YYYY-MM')) >= 3  -- PostgreSQL
)
AND NOT EXISTS (
    -- But no orders exceeding 50000
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
    AND o.total_amount > 50000
);
```

### Recursive Correlation (PostgreSQL)
```sql
-- Find all employees and their reporting hierarchy
WITH RECURSIVE employee_hierarchy AS (
    -- Base case: top-level managers
    SELECT emp_id, name, department_id, NULL::INT as manager_id, 1 as level
    FROM employees
    WHERE NOT EXISTS (
        SELECT 1 FROM employees mgr WHERE mgr.emp_id = employees.manager_id
    )
    
    UNION ALL
    
    -- Recursive case: employees with managers
    SELECT e.emp_id, e.name, e.department_id, e.manager_id, eh.level + 1
    FROM employees e
    INNER JOIN employee_hierarchy eh ON e.manager_id = eh.emp_id
)
SELECT * FROM employee_hierarchy
WHERE EXISTS (
    SELECT 1 FROM orders o
    INNER JOIN customers c ON o.customer_id = c.customer_id
    INNER JOIN departments d ON d.location = c.city
    WHERE d.dept_id = employee_hierarchy.department_id
);
```

## Summary

| Feature | MySQL | MSSQL | PostgreSQL |
|---------|--------|--------|-------------|
| **EXISTS** | ✅ Standard syntax | ✅ Standard syntax | ✅ Standard syntax |
| **NOT EXISTS** | ✅ Standard syntax | ✅ Standard syntax | ✅ Standard syntax |
| **Correlated Subqueries** | ✅ Full support | ✅ Full support | ✅ Full support |
| **Performance** | Good with indexes | Excellent with hints | Excellent with partial indexes |
| **Advanced Features** | Basic correlation | APPLY operator | Recursive CTEs, JSON correlation |

### Best Practices:
1. **Always use appropriate indexes** on correlated columns
2. **Prefer EXISTS over IN** for subqueries that might return NULLs
3. **Use SELECT 1** in EXISTS subqueries for clarity
4. **Test query performance** with EXPLAIN/EXPLAIN ANALYZE
5. **Consider alternatives** like JOINs or window functions for complex scenarios
6. **Be careful with NOT EXISTS** and NULL values in subqueries
