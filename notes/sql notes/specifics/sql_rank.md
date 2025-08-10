# Complete Guide to SQL Ranking and Row Number Functions

## Core Ranking Functions

### 1. ROW_NUMBER()
Assigns unique sequential integers starting from 1, regardless of ties.

```sql
-- Basic syntax
ROW_NUMBER() OVER (ORDER BY column_name)
```

```sql
-- With partitioning
ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC)
```

**Example:**
```sql
SELECT 
    employee_name,
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) as row_num
FROM employees;
```

### 2. RANK()
Assigns ranks with gaps for ties (1, 2, 2, 4, 5...)

```sql
RANK() OVER (ORDER BY column_name)
```

**Example:**
```sql
SELECT 
    employee_name,
    salary,
    RANK() OVER (ORDER BY salary DESC) as rank_num
FROM employees;
```

### 3. DENSE_RANK()
Assigns ranks without gaps for ties (1, 2, 2, 3, 4...)

```sql
DENSE_RANK() OVER (ORDER BY column_name)
```

**Example:**
```sql
SELECT 
    employee_name,
    salary,
    DENSE_RANK() OVER (ORDER BY salary DESC) as dense_rank_num
FROM employees;
```

### 4. PERCENT_RANK()
Returns the percentile rank (0 to 1) of each row.

```sql
PERCENT_RANK() OVER (ORDER BY column_name)
```

**Formula:** `(rank - 1) / (total_rows - 1)`

### 5. CUME_DIST()
Returns the cumulative distribution (0 to 1).

```sql
CUME_DIST() OVER (ORDER BY column_name)
```

**Formula:** `number_of_rows_with_values <= current_value / total_rows`

## Advanced Ranking Functions

### 6. NTILE(n)
Divides rows into n approximately equal groups.

```sql
NTILE(4) OVER (ORDER BY salary DESC) -- Creates quartiles
```

**Example:**
```sql
SELECT 
    employee_name,
    salary,
    NTILE(4) OVER (ORDER BY salary DESC) as quartile
FROM employees;
```

## Database-Specific Features and Variations

### MySQL (8.0+)
- **Window Functions Support:** Added in MySQL 8.0
- **All standard functions available:** ROW_NUMBER(), RANK(), DENSE_RANK(), PERCENT_RANK(), CUME_DIST(), NTILE()
- **Named Windows:** 
```sql
SELECT 
    name, 
    salary,
    ROW_NUMBER() OVER w as row_num,
    RANK() OVER w as rank_num
FROM employees
WINDOW w AS (ORDER BY salary DESC);
```

- **Frame Specification:**
```sql
ROW_NUMBER() OVER (
    ORDER BY salary 
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
)
```

### SQL Server (MSSQL)
- **Available since:** SQL Server 2005 for basic functions
- **Enhanced features in newer versions:**
- **STRING_AGG with WITHIN GROUP:** (SQL Server 2017+)
```sql
SELECT STRING_AGG(employee_name, ', ') WITHIN GROUP (ORDER BY salary DESC)
FROM employees;
```

- **LAG/LEAD with IGNORE NULLS:** (SQL Server 2022+)
```sql
LAG(salary, 1) IGNORE NULLS OVER (ORDER BY hire_date)
```

- **Window Frame Extensions:** RANGE support improvements
- **FIRST_VALUE/LAST_VALUE optimizations**

### PostgreSQL
- **Most comprehensive window function support**
- **All standard functions plus extensions**
- **Custom aggregates as window functions:**
```sql
SELECT 
    name,
    salary,
    array_agg(salary) OVER (ORDER BY salary ROWS 2 PRECEDING) as salary_window
FROM employees;
```

- **Hypothetical set functions:**
```sql
-- RANK of a hypothetical value
SELECT RANK(50000) WITHIN GROUP (ORDER BY salary) FROM employees;
```

- **Mode and percentile functions:**
```sql
SELECT 
    percentile_cont(0.5) WITHIN GROUP (ORDER BY salary) as median,
    mode() WITHIN GROUP (ORDER BY department) as most_common_dept
FROM employees;
```

## Latest Features and Enhancements (2023-2024)

### MySQL 8.0.32+
- **Improved performance** for window functions with large datasets
- **Better memory management** for partitioned window operations
- **Enhanced optimizer** for window function queries

### SQL Server 2022
- **IGNORE NULLS clause** for LAG/LEAD functions
- **Improved performance** for window functions over large partitions
- **Better parallelization** of window operations

### PostgreSQL 15+
- **MERGE command** with window functions in WHEN clauses
- **Improved performance** for window functions with complex expressions
- **Better optimization** for multiple window functions in single query

## Practical Examples and Comparisons

### Getting Top N per Group
```sql
-- Top 3 highest paid employees per department
WITH ranked_employees AS (
    SELECT 
        employee_name,
        department,
        salary,
        ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) as rn
    FROM employees
)
SELECT * FROM ranked_employees WHERE rn <= 3;
```

### Difference Between RANK vs DENSE_RANK vs ROW_NUMBER
```sql
SELECT 
    employee_name,
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) as row_num,    -- 1,2,3,4,5,6
    RANK() OVER (ORDER BY salary DESC) as rank_num,        -- 1,2,2,4,5,6
    DENSE_RANK() OVER (ORDER BY salary DESC) as dense_rank -- 1,2,2,3,4,5
FROM employees;
```

### Percentile Analysis
```sql
SELECT 
    employee_name,
    salary,
    PERCENT_RANK() OVER (ORDER BY salary) as percent_rank,
    CUME_DIST() OVER (ORDER BY salary) as cumulative_dist,
    NTILE(10) OVER (ORDER BY salary) as decile
FROM employees;
```

### Moving Averages with Rankings
```sql
SELECT 
    date,
    sales,
    ROW_NUMBER() OVER (ORDER BY date) as day_number,
    AVG(sales) OVER (ORDER BY date ROWS 6 PRECEDING) as moving_avg_7days,
    RANK() OVER (ORDER BY sales DESC) as sales_rank
FROM daily_sales;
```

## Performance Considerations

### Optimization Tips
1. **Use appropriate indexes** on ORDER BY columns
2. **Partition wisely** - smaller partitions perform better
3. **Combine multiple window functions** with same OVER clause
4. **Use LIMIT** with ranking functions for top-N queries
5. **Consider materialized views** for frequently used rankings

### Index Recommendations
```sql
-- For partitioned ranking
CREATE INDEX idx_emp_dept_salary ON employees(department, salary DESC);
```

```sql
-- For simple ranking
CREATE INDEX idx_emp_salary ON employees(salary DESC);
```

## Common Use Cases

1. **Leaderboards and Rankings**
2. **Top N per category**
3. **Percentile analysis**
4. **Gap and island problems**
5. **Running totals with rankings**
6. **Deduplication** (using ROW_NUMBER)
7. **Pagination** with consistent ordering
8. **Time series analysis**

## Error Handling and Edge Cases

### Handling NULLs
```sql
-- NULLs are typically ordered last (database dependent)
ORDER BY salary DESC NULLS LAST  -- PostgreSQL explicit syntax
```

### Empty Partitions
```sql
-- Always returns at least one row per partition if EXISTS
SELECT 
    COALESCE(
        RANK() OVER (PARTITION BY department ORDER BY salary DESC), 
        1
    ) as safe_rank
FROM employees;
```
---
### BY CHATGPT - 5

Absolutely! Here’s the same point‑wise cheat sheet on ROW_NUMBER, RANK, DENSE_RANK with tons of emojis, plus clean copy‑pastable queries for MySQL 8+, SQL Server, and PostgreSQL.

Cheat sheet (readable + emojis)
-  What they are:
  -  ROW_NUMBER(): unique number per row in the window (no ties share a number)
  -  RANK(): ties share rank; gaps after ties (1,2,2,4)
  -  DENSE_RANK(): ties share rank; no gaps (1,2,2,3)
-  How to use:
  -  Always with OVER(...)
  -  ORDER BY inside OVER decides rank order
  -  PARTITION BY resets ranks per group (e.g., per department/category)
-  When to use what:
  -  ROW_NUMBER: pick the single “best/latest” row per group (dedup, top-1)
  -  RANK: keep ties and show gaps (competition standings)
  -  DENSE_RANK: compact band numbers (salary bands, tiers)
-  Real-time use cases:
  -  Top-N per category/department/product
  -  Latest record per entity (latest order per customer)
  -  Salary banding and pay equity analysis
  -  Pagination slices (ROW_NUMBER for pages)
  -  SCD/Change tracking (pick latest effective row)
- ⚙️ Performance tips:
  -  Index PARTITION BY and ORDER BY columns if possible
  -  Pre-aggregate before ranking to shrink data
  -  Select only needed columns (avoid SELECT *)
  -  Check plans: EXPLAIN (MySQL), EXPLAIN ANALYZE (Postgres), Actual Plan (SQL Server)

Copy‑pastable queries (MySQL 8+, SQL Server, PostgreSQL)

1)  Global ranking: top products by total quantity
```sql
SELECT
  p.product_id,
  p.product_name,
  SUM(o.quantity) AS total_qty,
  RANK()       OVER (ORDER BY SUM(o.quantity) DESC) AS rnk,
  DENSE_RANK() OVER (ORDER BY SUM(o.quantity) DESC) AS dense_rnk,
  ROW_NUMBER() OVER (ORDER BY SUM(o.quantity) DESC) AS row_num
FROM products p
JOIN orders o ON o.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_qty DESC;
```
2)  Top 3 per category (keep ties with RANK)
```sql
SELECT *
FROM (
  SELECT
    p.category,
    p.product_name,
    SUM(o.quantity) AS qty,
    RANK() OVER (PARTITION BY p.category ORDER BY SUM(o.quantity) DESC) AS rnk
  FROM products p
  JOIN orders o ON o.product_id = p.product_id
  GROUP BY p.category, p.product_name
) t
WHERE rnk <= 3
ORDER BY category, rnk, qty DESC, product_name;
```

3)  Deduplicate: latest order per customer (exactly one)
```sql
SELECT *
FROM (
  SELECT
    o.*,
    ROW_NUMBER() OVER (
      PARTITION BY o.customer_id
      ORDER BY o.order_date DESC, o.order_id DESC
    ) AS rn
  FROM orders o
) x
WHERE rn = 1
ORDER BY customer_id;
```
4)  Salary bands per department (compact)
```sql
SELECT
  e.department_id,
  e.employee_name,
  e.salary,
  DENSE_RANK() OVER (PARTITION BY e.department_id ORDER BY e.salary DESC) AS salary_band
FROM employees e
ORDER BY department_id, salary DESC;
```
5)  Pagination with ROW_NUMBER (page 2, size 10 → rows 11–20)
```sql
WITH numbered AS (
  SELECT
    o.*,
    ROW_NUMBER() OVER (ORDER BY o.order_date DESC, o.order_id DESC) AS rn
  FROM orders o
)
SELECT *
FROM numbered
WHERE rn BETWEEN 11 AND 20
ORDER BY rn;
```
6)  Break ties deterministically (add a tiebreaker)
```sql
SELECT
  e.*,
  RANK() OVER (
    PARTITION BY e.department_id
    ORDER BY e.salary DESC, e.employee_id ASC
  ) AS rnk_with_tiebreak
FROM employees e;
```

7)  Top seller per product (one salesperson per product)
```sql
SELECT *
FROM (
  SELECT
    o.product_id,
    o.employee_id,
    SUM(o.quantity) AS qty_sold,
    ROW_NUMBER() OVER (
      PARTITION BY o.product_id
      ORDER BY SUM(o.quantity) DESC, o.employee_id
    ) AS rn
  FROM orders o
  GROUP BY o.product_id, o.employee_id
) s
WHERE rn = 1
ORDER BY product_id;
```

8)  Dense tiers: revenue tiers per customer
```sql
SELECT
  o.customer_id,
  SUM(o.total_amount) AS revenue,
  DENSE_RANK() OVER (ORDER BY SUM(o.total_amount) DESC) AS revenue_tier
FROM orders o
GROUP BY o.customer_id
ORDER BY revenue DESC;
```

9)  RANK vs DENSE_RANK illustration (ties cause gaps vs no gaps)
```sql
SELECT
  o.customer_id,
  SUM(o.total_amount) AS revenue,
  RANK()       OVER (ORDER BY SUM(o.total_amount) DESC) AS rnk_with_gaps,
  DENSE_RANK() OVER (ORDER BY SUM(o.total_amount) DESC) AS rnk_no_gaps
FROM orders o
GROUP BY o.customer_id
ORDER BY revenue DESC;
```

10)  Latest effective-dated record per employee (SCD-like)
```sql
SELECT *
FROM (
  SELECT
    e.*,
    ROW_NUMBER() OVER (
      PARTITION BY e.employee_id
      ORDER BY e.hire_date DESC
    ) AS rn
  FROM employees e
) s
WHERE rn = 1;
```

Notes by engine (quick )
- MySQL 8.0+: supports all shown window functions; no QUALIFY—use subqueries/CTEs to filter ranks.
- SQL Server: supports all; ROW_NUMBER great for pagination; OFFSET/FETCH also available.
- PostgreSQL: supports all; use EXPLAIN ANALYZE for insight; powerful CTEs and window frames.

Extra pro tips 
-  Window frame defaults: for ORDER BY in window, default frame is RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW in some engines; for ranking functions it doesn’t change the result, but be explicit with ROWS if mixing aggregates.
-  Stable ordering: when ordering by a non-unique column (e.g., salary), add a unique tiebreaker (e.g., employee_id) to avoid non-deterministic row numbers.
-  Pre-aggregate: If you rank by SUM/COUNT, aggregate in a subquery first, then rank to reduce repeated computation.

Want me to tailor these to your exact table/column names or generate sample outputs from your 10-row data? 
