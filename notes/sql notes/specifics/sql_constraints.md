# Complete Guide to Database Constraints and Foreign Keys

## Table of Contents
1. [Constraint Types Overview](#constraint-types-overview)
2. [Primary Key Constraints](#primary-key-constraints)
3. [Foreign Key Constraints](#foreign-key-constraints)
4. [Check Constraints](#check-constraints)
5. [Unique Constraints](#unique-constraints)
6. [Default Constraints](#default-constraints)
7. [Latest Developments (2024-2025)](#latest-developments-2024-2025)
8. [Performance and Best Practices](#performance-and-best-practices)

---

## Constraint Types Overview

### What are Database Constraints?
Constraints are rules enforced by the database to maintain data integrity, consistency, and relationships between tables.

### Types of Constraints
- **PRIMARY KEY**: Uniquely identifies each row
- **FOREIGN KEY**: Links tables and maintains referential integrity
- **UNIQUE**: Ensures column values are unique
- **CHECK**: Validates data against specific conditions
- **NOT NULL**: Prevents null values
- **DEFAULT**: Provides default values

---

## Primary Key Constraints

### MySQL Primary Keys
```sql
-- Single column primary key
CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

-- Composite primary key
CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    PRIMARY KEY (order_id, product_id)
);

-- Add primary key to existing table
ALTER TABLE employees ADD PRIMARY KEY (emp_id);

-- Drop primary key
ALTER TABLE employees DROP PRIMARY KEY;

-- Primary key with explicit name
CREATE TABLE departments (
    dept_id INT,
    dept_name VARCHAR(50),
    CONSTRAINT pk_departments PRIMARY KEY (dept_id)
);
```

### MSSQL Primary Keys
```sql
-- Single column primary key
CREATE TABLE employees (
    emp_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) UNIQUE
);

-- Composite primary key
CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    CONSTRAINT pk_order_items PRIMARY KEY (order_id, product_id)
);

-- Add primary key to existing table
ALTER TABLE employees 
ADD CONSTRAINT pk_employees PRIMARY KEY (emp_id);

-- Drop primary key
ALTER TABLE employees DROP CONSTRAINT pk_employees;

-- Primary key with clustered index
CREATE TABLE products (
    product_id INT IDENTITY(1,1),
    product_name NVARCHAR(100),
    CONSTRAINT pk_products PRIMARY KEY CLUSTERED (product_id)
);

-- Primary key with non-clustered index
CREATE TABLE categories (
    category_id INT,
    category_name NVARCHAR(50),
    CONSTRAINT pk_categories PRIMARY KEY NONCLUSTERED (category_id)
);
```

### PostgreSQL Primary Keys
```sql
-- Single column primary key
CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

-- Composite primary key
CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    PRIMARY KEY (order_id, product_id)
);

-- Add primary key to existing table
ALTER TABLE employees ADD PRIMARY KEY (emp_id);

-- Drop primary key
ALTER TABLE employees DROP CONSTRAINT employees_pkey;

-- Primary key with explicit name
CREATE TABLE departments (
    dept_id INT,
    dept_name VARCHAR(50),
    CONSTRAINT pk_departments PRIMARY KEY (dept_id)
);

-- Primary key with UUID
CREATE TABLE sessions (
    session_id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id INT,
    created_at TIMESTAMP DEFAULT NOW()
);
```

---

## Foreign Key Constraints

### MySQL Foreign Keys

#### Traditional Syntax
```sql
-- Basic foreign key
CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- Named foreign key constraint
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    CONSTRAINT fk_orders_customer 
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Multiple foreign keys
CREATE TABLE order_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    CONSTRAINT fk_items_order 
        FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CONSTRAINT fk_items_product 
        FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Foreign key with actions
CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    dept_id INT,
    manager_id INT,
    CONSTRAINT fk_emp_dept 
        FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    CONSTRAINT fk_emp_manager 
        FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
        ON DELETE SET NULL
);

-- Add foreign key to existing table
ALTER TABLE employees 
ADD CONSTRAINT fk_emp_dept 
FOREIGN KEY (dept_id) REFERENCES departments(dept_id);

-- Drop foreign key
ALTER TABLE employees DROP FOREIGN KEY fk_emp_dept;

-- Disable foreign key checks (for bulk operations)
SET FOREIGN_KEY_CHECKS = 0;
-- Bulk insert/update operations here
SET FOREIGN_KEY_CHECKS = 1;
```

#### Latest MySQL 9.0+ Inline Syntax (2024)
```sql
-- Inline foreign key constraint (MySQL 9.0+)
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customers(customer_id),
    product_id INT REFERENCES products(product_id) ON DELETE CASCADE,
    order_date DATE DEFAULT (CURRENT_DATE)
);

-- Multiple inline constraints
CREATE TABLE employee_projects (
    assignment_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT NOT NULL REFERENCES employees(emp_id) ON DELETE CASCADE,
    project_id INT NOT NULL REFERENCES projects(project_id) ON UPDATE CASCADE,
    assigned_date DATE DEFAULT (CURRENT_DATE),
    role VARCHAR(50) DEFAULT 'Developer'
);
```

### MSSQL Foreign Keys

```sql
-- Basic foreign key
CREATE TABLE employees (
    emp_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100),
    dept_id INT,
    CONSTRAINT fk_employees_dept 
        FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- Foreign key with cascading actions
CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    order_date DATE DEFAULT GETDATE(),
    CONSTRAINT fk_orders_customer 
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Self-referencing foreign key
CREATE TABLE employees (
    emp_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100),
    manager_id INT,
    dept_id INT,
    CONSTRAINT fk_emp_manager 
        FOREIGN KEY (manager_id) REFERENCES employees(emp_id),
    CONSTRAINT fk_emp_dept 
        FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
        ON DELETE SET NULL
);

-- Composite foreign key
CREATE TABLE order_items (
    item_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT,
    customer_id INT,
    product_id INT,
    CONSTRAINT fk_items_order_customer 
        FOREIGN KEY (order_id, customer_id) 
        REFERENCES orders(order_id, customer_id)
);

-- Add foreign key to existing table
ALTER TABLE employees 
ADD CONSTRAINT fk_employees_dept 
FOREIGN KEY (dept_id) REFERENCES departments(dept_id);

-- Drop foreign key
ALTER TABLE employees DROP CONSTRAINT fk_employees_dept;

-- Disable constraint checking
ALTER TABLE employees NOCHECK CONSTRAINT fk_employees_dept;
-- Re-enable constraint checking
ALTER TABLE employees CHECK CONSTRAINT fk_employees_dept;

-- Inline foreign key (MSSQL supports this)
CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customers(customer_id),
    order_date DATE DEFAULT GETDATE()
);
```

### PostgreSQL Foreign Keys

```sql
-- Basic foreign key
CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    dept_id INT,
    CONSTRAINT fk_employees_dept 
        FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- Foreign key with actions
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE DEFAULT CURRENT_DATE,
    CONSTRAINT fk_orders_customer 
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
        ON DELETE CASCADE
        ON UPDATE RESTRICT
);

-- Deferred constraint checking
CREATE TABLE parent_child (
    parent_id INT PRIMARY KEY,
    child_id INT,
    CONSTRAINT fk_parent_child 
        FOREIGN KEY (child_id) REFERENCES parent_child(parent_id)
        DEFERRABLE INITIALLY DEFERRED
);

-- Partial foreign keys (with conditions)
CREATE TABLE archived_orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    status VARCHAR(20),
    CONSTRAINT fk_archived_customer 
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
        WHERE status = 'completed'  -- PostgreSQL specific
);

-- Array foreign keys (PostgreSQL specific)
CREATE TABLE user_roles (
    user_id INT PRIMARY KEY,
    role_ids INT[],
    CONSTRAINT fk_user_roles_check
        CHECK (role_ids <@ (SELECT ARRAY_AGG(role_id) FROM roles))
);

-- JSON foreign key validation
CREATE TABLE user_preferences (
    user_id INT PRIMARY KEY REFERENCES users(user_id),
    preferences JSONB,
    CONSTRAINT valid_theme_preference 
        CHECK (preferences->>'theme' IN ('light', 'dark', 'auto'))
);

-- Add foreign key to existing table
ALTER TABLE employees 
ADD CONSTRAINT fk_employees_dept 
FOREIGN KEY (dept_id) REFERENCES departments(dept_id);

-- Drop foreign key
ALTER TABLE employees DROP CONSTRAINT fk_employees_dept;

-- Inline foreign key
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customers(customer_id),
    order_date DATE DEFAULT CURRENT_DATE
);
```

---

## Check Constraints

### MySQL Check Constraints (MySQL 8.0.16+)
```sql
-- Basic check constraint
CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    salary DECIMAL(10,2),
    email VARCHAR(100),
    CONSTRAINT chk_age CHECK (age >= 18 AND age <= 65),
    CONSTRAINT chk_salary CHECK (salary > 0),
    CONSTRAINT chk_email CHECK (email LIKE '%@%.%')
);

-- Multiple conditions
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2),
    discount_percent DECIMAL(5,2),
    CONSTRAINT chk_price_positive CHECK (price > 0),
    CONSTRAINT chk_discount_range CHECK (discount_percent >= 0 AND discount_percent <= 100),
    CONSTRAINT chk_discounted_price CHECK (price * (1 - discount_percent/100) > 0)
);

-- Add check constraint to existing table
ALTER TABLE employees 
ADD CONSTRAINT chk_valid_email 
CHECK (email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$');

-- Drop check constraint
ALTER TABLE employees DROP CHECK chk_age;
```

### MSSQL Check Constraints
```sql
-- Basic check constraints
CREATE TABLE employees (
    emp_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100),
    age INT,
    salary DECIMAL(10,2),
    gender CHAR(1),
    email NVARCHAR(100),
    CONSTRAINT chk_age CHECK (age BETWEEN 18 AND 65),
    CONSTRAINT chk_salary CHECK (salary > 0),
    CONSTRAINT chk_gender CHECK (gender IN ('M', 'F', 'O')),
    CONSTRAINT chk_email CHECK (email LIKE '%@%.%')
);

-- Advanced check constraints
CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    order_date DATE,
    ship_date DATE,
    status NVARCHAR(20),
    total_amount DECIMAL(10,2),
    CONSTRAINT chk_order_date CHECK (order_date <= GETDATE()),
    CONSTRAINT chk_ship_after_order CHECK (ship_date >= order_date),
    CONSTRAINT chk_status CHECK (status IN ('pending', 'processing', 'shipped', 'delivered', 'cancelled')),
    CONSTRAINT chk_amount_positive CHECK (total_amount > 0)
);

-- Pattern matching check
CREATE TABLE phone_numbers (
    id INT IDENTITY(1,1) PRIMARY KEY,
    phone NVARCHAR(15),
    CONSTRAINT chk_phone_format 
        CHECK (phone LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
);

-- Add check constraint
ALTER TABLE employees 
ADD CONSTRAINT chk_valid_salary 
CHECK (salary BETWEEN 30000 AND 500000);

-- Disable/Enable check constraints
ALTER TABLE employees NOCHECK CONSTRAINT chk_age;
ALTER TABLE employees CHECK CONSTRAINT chk_age;

-- Drop check constraint
ALTER TABLE employees DROP CONSTRAINT chk_age;
```

### PostgreSQL Check Constraints
```sql
-- Basic check constraints
CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    salary DECIMAL(10,2),
    email VARCHAR(100),
    CONSTRAINT chk_age CHECK (age >= 18 AND age <= 65),
    CONSTRAINT chk_salary CHECK (salary > 0),
    CONSTRAINT chk_email CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);

-- Array check constraints
CREATE TABLE user_permissions (
    user_id SERIAL PRIMARY KEY,
    permissions TEXT[],
    CONSTRAINT chk_valid_permissions 
        CHECK (permissions <@ ARRAY['read', 'write', 'delete', 'admin'])
);

-- JSON check constraints
CREATE TABLE user_settings (
    user_id SERIAL PRIMARY KEY,
    settings JSONB,
    CONSTRAINT chk_valid_theme 
        CHECK (settings->>'theme' IN ('light', 'dark', 'auto')),
    CONSTRAINT chk_valid_language 
        CHECK (settings->>'language' ~ '^[a-z]{2}$')
);

-- Range check constraints
CREATE TABLE events (
    event_id SERIAL PRIMARY KEY,
    event_name VARCHAR(100),
    event_date DATERANGE,
    CONSTRAINT chk_future_event 
        CHECK (lower(event_date) > CURRENT_DATE)
);

-- Custom function in check constraint
CREATE OR REPLACE FUNCTION is_valid_ssn(ssn TEXT) 
RETURNS BOOLEAN AS $$
BEGIN
    RETURN ssn ~ '^\d{3}-\d{2}-\d{4}$';
END;
$$ LANGUAGE plpgsql;

CREATE TABLE persons (
    person_id SERIAL PRIMARY KEY,
    ssn VARCHAR(11),
    CONSTRAINT chk_valid_ssn CHECK (is_valid_ssn(ssn))
);

-- Add check constraint
ALTER TABLE employees 
ADD CONSTRAINT chk_valid_hire_date 
CHECK (hire_date >= '2020-01-01');

-- Drop check constraint
ALTER TABLE employees DROP CONSTRAINT chk_age;
```

---

## Unique Constraints

### MySQL Unique Constraints
```sql
-- Single column unique
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    email VARCHAR(100) UNIQUE
);

-- Composite unique constraint
CREATE TABLE user_profiles (
    profile_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    platform VARCHAR(50),
    profile_name VARCHAR(100),
    UNIQUE KEY uk_user_platform (user_id, platform)
);

-- Named unique constraint
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    sku VARCHAR(50),
    product_name VARCHAR(100),
    CONSTRAINT uk_product_sku UNIQUE (sku)
);

-- Add unique constraint
ALTER TABLE users ADD UNIQUE (email);
ALTER TABLE users ADD CONSTRAINT uk_username UNIQUE (username);

-- Drop unique constraint
ALTER TABLE users DROP INDEX uk_username;
```

### MSSQL Unique Constraints
```sql
-- Single column unique
CREATE TABLE users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(50) UNIQUE,
    email NVARCHAR(100) UNIQUE
);

-- Composite unique constraint
CREATE TABLE user_profiles (
    profile_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT,
    platform NVARCHAR(50),
    profile_name NVARCHAR(100),
    CONSTRAINT uk_user_platform UNIQUE (user_id, platform)
);

-- Unique constraint with included columns
CREATE TABLE products (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    sku NVARCHAR(50),
    product_name NVARCHAR(100),
    category_id INT,
    CONSTRAINT uk_product_sku UNIQUE (sku)
);

-- Filtered unique constraint (allows multiple NULLs)
CREATE TABLE employees (
    emp_id INT IDENTITY(1,1) PRIMARY KEY,
    ssn NVARCHAR(11),
    name NVARCHAR(100)
);

CREATE UNIQUE INDEX uk_employees_ssn 
ON employees(ssn) 
WHERE ssn IS NOT NULL;

-- Add unique constraint
ALTER TABLE users ADD CONSTRAINT uk_email UNIQUE (email);

-- Drop unique constraint
ALTER TABLE users DROP CONSTRAINT uk_email;
```

### PostgreSQL Unique Constraints
```sql
-- Single column unique
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    email VARCHAR(100) UNIQUE
);

-- Composite unique constraint
CREATE TABLE user_profiles (
    profile_id SERIAL PRIMARY KEY,
    user_id INT,
    platform VARCHAR(50),
    profile_name VARCHAR(100),
    CONSTRAINT uk_user_platform UNIQUE (user_id, platform)
);

-- Partial unique constraint
CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    email VARCHAR(100),
    status VARCHAR(20),
    CONSTRAINT uk_active_email UNIQUE (email) 
        WHERE status = 'active'
);

-- Unique constraint with expressions
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    CONSTRAINT uk_product_name_lower UNIQUE (LOWER(product_name))
);

-- Exclude constraint (PostgreSQL specific)
CREATE TABLE room_bookings (
    booking_id SERIAL PRIMARY KEY,
    room_id INT,
    booking_period TSRANGE,
    EXCLUDE USING GIST (room_id WITH =, booking_period WITH &&)
);

-- Add unique constraint
ALTER TABLE users ADD CONSTRAINT uk_email UNIQUE (email);

-- Drop unique constraint
ALTER TABLE users DROP CONSTRAINT uk_email;
```

---

## Default Constraints

### MySQL Default Constraints
```sql
-- Column defaults
CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    hire_date DATE DEFAULT (CURRENT_DATE),
    status VARCHAR(20) DEFAULT 'active',
    salary DECIMAL(10,2) DEFAULT 50000.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Expression defaults (MySQL 8.0+)
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_number VARCHAR(20) DEFAULT (CONCAT('ORD-', LPAD(CONNECTION_ID(), 6, '0'))),
    order_date DATE DEFAULT (CURRENT_DATE),
    expiry_date DATE DEFAULT (DATE_ADD(CURRENT_DATE, INTERVAL 30 DAY))
);

-- Modify default value
ALTER TABLE employees ALTER COLUMN status SET DEFAULT 'pending';

-- Remove default value
ALTER TABLE employees ALTER COLUMN status DROP DEFAULT;
```

### MSSQL Default Constraints
```sql
-- Column defaults
CREATE TABLE employees (
    emp_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    hire_date DATE DEFAULT GETDATE(),
    status NVARCHAR(20) DEFAULT 'active',
    salary DECIMAL(10,2) DEFAULT 50000.00,
    created_at DATETIME2 DEFAULT GETDATE(),
    department_code AS ('DEPT-' + CAST(dept_id AS VARCHAR(10))) PERSISTED
);

-- Named default constraints
CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    order_date DATE,
    status NVARCHAR(20),
    priority INT,
    CONSTRAINT df_order_date DEFAULT GETDATE() FOR order_date,
    CONSTRAINT df_order_status DEFAULT 'pending' FOR status,
    CONSTRAINT df_order_priority DEFAULT 1 FOR priority
);
```
 **🚨 The "Ghost Constraint" Problem!**

## **🔍 What happens when CREATE TABLE fails:**

When a `CREATE TABLE` statement fails **midway through execution**, SQL Server sometimes leaves behind "orphaned" constraint names in the system catalog.

## **📝 Example Scenario:**

```sql
-- This CREATE TABLE fails due to some error
CREATE TABLE test_table(
    id INT,
    name VARCHAR(30) NOT NULL,
    email VARCHAR(500),  -- Let's say this causes an error
    CONSTRAINT pk_id PRIMARY KEY(id)
);
-- ERROR: Table creation fails, but constraint name "pk_id" gets registered
```

## **🔧 What gets "reserved":**

**SQL Server's internal process:**
1. **Parse SQL** ✅ - Registers constraint name `pk_id`
2. **Validate columns** ❌ - Fails here (example: invalid datatype)
3. **Create table** ❌ - Never reaches this step
4. **Create constraints** ❌ - Never reaches this step

**Result:** `pk_id` exists in system catalogs but **no actual table or constraint**!

## **🕵️ How to find these "ghost" constraints:**

```sql
-- Check for orphaned constraint names
SELECT 
    kc.name AS constraint_name,
    t.name AS table_name,
    kc.object_id,
    t.object_id
FROM sys.key_constraints kc
LEFT JOIN sys.tables t ON kc.parent_object_id = t.object_id
WHERE kc.name = 'pk_id';

-- If table_name is NULL, it's a "ghost" constraint!
```

## **🧹 Cleanup methods:**

**Method 1: Try to drop it anyway**
```sql
-- This might work even if table doesn't exist
DROP INDEX pk_id ON some_table_name;
-- OR
ALTER TABLE some_table_name DROP CONSTRAINT pk_id;
```

**Method 2: Database consistency check**
```sql
-- Run database repair
DBCC CHECKDB('your_database_name') WITH REPAIR_ALLOW_DATA_LOSS;
```

**Method 3: Use different constraint name**
```sql
-- Simplest solution - just use a new name
CONSTRAINT pk_id_new PRIMARY KEY(stud_id)
```

## **🎯 Why this happens:**
- **Transaction rollback** issues
- **System catalog corruption**
- **Interrupted DDL operations**
- **SQL Server internal bugs**

**💡 This is why many DBAs prefer auto-generated constraint names or very specific naming conventions!**
```sql 
-- Complex default expressions
CREATE TABLE audit_log (
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    log_message NVARCHAR(MAX),
    log_timestamp DATETIME2 DEFAULT SYSDATETIME(),
    log_user NVARCHAR(100) DEFAULT SYSTEM_USER,
    session_id NVARCHAR(50) DEFAULT CAST(@@SPID AS NVARCHAR(50))
);

-- Add default constraint
ALTER TABLE employees 
ADD CONSTRAINT df_emp_status 
DEFAULT 'active' FOR status;

-- Drop default constraint
ALTER TABLE employees DROP CONSTRAINT df_emp_status;
```

### PostgreSQL Default Constraints
```sql
-- Column defaults
CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    hire_date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(20) DEFAULT 'active',
    salary DECIMAL(10,2) DEFAULT 50000.00,
    created_at TIMESTAMP DEFAULT NOW(),
    employee_code VARCHAR(20) DEFAULT 'EMP-' || nextval('emp_code_seq')
);

-- UUID defaults
CREATE TABLE sessions (
    session_id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id INT,
    created_at TIMESTAMP DEFAULT NOW(),
    expires_at TIMESTAMP DEFAULT (NOW() + INTERVAL '24 hours')
);

-- Function-based defaults
CREATE OR REPLACE FUNCTION generate_employee_code() 
RETURNS VARCHAR(20) AS $$
BEGIN
    RETURN 'EMP-' || TO_CHAR(nextval('employee_seq'), 'FM000000');
END;
$$ LANGUAGE plpgsql;

CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    employee_code VARCHAR(20) DEFAULT generate_employee_code(),
    name VARCHAR(100)
);

-- Array defaults
CREATE TABLE user_permissions (
    user_id SERIAL PRIMARY KEY,
    permissions TEXT[] DEFAULT ARRAY['read'],
    tags JSONB DEFAULT '[]'::jsonb
);

-- Modify default value
ALTER TABLE employees ALTER COLUMN status SET DEFAULT 'pending';

-- Remove default value
ALTER TABLE employees ALTER COLUMN status DROP DEFAULT;
```

---

## Latest Developments (2024-2025)

### Inline Foreign Key Constraints
Most popular SQL database systems now support inline foreign key constraints, allowing you to define relationships directly in column definitions for easier table creation.

```sql
-- Modern inline syntax (supported in MySQL 9.0+, MSSQL, PostgreSQL)
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customers(customer_id),
    product_id INT REFERENCES products(product_id) ON DELETE CASCADE,
    order_date DATE DEFAULT CURRENT_DATE
);
```

### Performance Optimizations
Primary Key and Foreign Key constraints now enable faster queries through optimization enhancements that leverage constraint information.

```sql
-- Query optimizer can use constraint information
SELECT c.customer_name, COUNT(o.order_id)
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id  -- FK enables optimization
GROUP BY c.customer_id, c.customer_name;
```

### Enhanced Constraint Features

#### MySQL 9.0+ Features
```sql
-- Improved constraint validation
CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100),
    phone VARCHAR(20),
    -- Enhanced email validation
    CONSTRAINT chk_email_format 
        CHECK (email REGEXP '^[a-zA-Z0-9.!#$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$'),
    -- Phone validation
    CONSTRAINT chk_phone_format 
        CHECK (phone REGEXP '^\\+?[1-9]\\d{1,14}$')
);

-- Better foreign key error messages
CREATE TABLE order_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL REFERENCES orders(order_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);
```

#### MSSQL Latest Features
```sql
-- Edge constraints for graph databases
CREATE TABLE person (
    person_id INT PRIMARY KEY,
    name NVARCHAR(100)
) AS NODE;

CREATE TABLE friendship (
    start_date DATE
) AS EDGE;

-- Temporal table constraints
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name NVARCHAR(100),
    salary DECIMAL(10,2),
    valid_from DATETIME2 GENERATED ALWAYS AS ROW START,
    valid_to DATETIME2 GENERATED ALWAYS AS ROW END,
    PERIOD FOR SYSTEM_TIME (valid_from, valid_to)
) WITH (SYSTEM_VERSIONING = ON);

-- Memory-optimized table constraints
CREATE TABLE session_data (
    session_id NVARCHAR(50) PRIMARY KEY NONCLUSTERED,
    user_id INT NOT NULL,
    data NVARCHAR(MAX),
    created_at DATETIME2 DEFAULT SYSDATETIME(),
    INDEX ix_user_id NONCLUSTERED (user_id)
) WITH (MEMORY_OPTIMIZED = ON, DURABILITY = SCHEMA_AND_DATA);
```

#### PostgreSQL Latest Features
```sql
-- Improved constraint exclusion
CREATE TABLE measurements (
    id SERIAL PRIMARY KEY,
    measurement_date DATE,
    value DECIMAL(10,2),
    CONSTRAINT chk_recent_data 
        CHECK (measurement_date >= '2024-01-01')
) PARTITION BY RANGE (measurement_date);

-- Enhanced JSON constraints
CREATE TABLE api_logs (
    log_id SERIAL PRIMARY KEY,
    request_data JSONB,
    response_data JSONB,
    CONSTRAINT chk_valid_request 
        CHECK (jsonb_typeof(request_data) = 'object'),
    CONSTRAINT chk_required_fields 
        CHECK (request_data ? 'timestamp' AND request_data ? 'endpoint'),
    CONSTRAINT chk_response_status 
        CHECK ((response_data->>'status')::INT BETWEEN 100 AND 599)
);

-- Generated columns with constraints
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    base_price DECIMAL(10,2),
    tax_rate DECIMAL(5,4) DEFAULT 0.08,
    final_price DECIMAL(10,2) GENERATED ALWAYS AS (base_price * (1 + tax_rate)) STORED,
    CONSTRAINT chk_positive_price CHECK (base_price > 0),
    CONSTRAINT chk_valid_tax_rate CHECK (tax_rate >= 0 AND tax_rate <= 1)
);
```

---

## Performance and Best Practices

### Indexing for Constraints
```sql
-- MySQL: Automatic index creation for foreign keys
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
    -- MySQL automatically creates index on customer_id
);

-- MSSQL: Manual index optimization
CREATE INDEX IX_Orders_CustomerID ON orders(customer_id);
CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    CONSTRAINT fk_orders_customer 
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- PostgreSQL: Covering indexes for better performance
CREATE INDEX idx_orders_customer_cover 
ON orders(customer_id) INCLUDE (order_date, total_amount);
```

### Constraint Naming Conventions
```sql
-- Recommended naming patterns
-- Primary Keys: pk_tablename
-- Foreign Keys: fk_childtable_parenttable or fk_childtable_column
-- Unique: uk_tablename_column
-- Check: chk_tablename_column
-- Default: df_tablename_column

CREATE TABLE order_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    
    CONSTRAINT pk_order_items PRIMARY KEY (item_id),
    CONSTRAINT fk_items_order FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CONSTRAINT fk_items_product FOREIGN KEY (product_id) REFERENCES products(product_id),
    CONSTRAINT uk_order_product UNIQUE (order_id, product_id),
    CONSTRAINT chk_quantity_positive CHECK (quantity > 0),
    CONSTRAINT chk_price_positive CHECK (unit_price > 0)
);
```

### Error Handling and Troubleshooting
```sql
-- Check constraint violations
-- MySQL
INSERT INTO employees (name, age) VALUES ('John', 15);  
-- Error: Check constraint 'chk_age' is violated

-- MSSQL  
INSERT INTO employees (name, age) VALUES ('John', 15);
-- Error: The INSERT statement conflicted with the CHECK constraint "chk_age"

-- PostgreSQL
INSERT INTO employees (name, age) VALUES ('John', 15);
-- Error: new row for relation "employees" violates check constraint "chk_age"

-- Foreign key violations
INSERT INTO orders (customer_id) VALUES (999);
-- Error: Cannot add or update a child row: a foreign key constraint fails
```

### Constraint Information Queries

#### MySQL - Query System Tables
```sql
-- View all constraints in a database
SELECT 
    TABLE_NAME,
    CONSTRAINT_NAME,
    CONSTRAINT_TYPE,
    COLUMN_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu 
    ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
WHERE tc.TABLE_SCHEMA = 'your_database_name';

-- View foreign key relationships
SELECT 
    kcu.TABLE_NAME as child_table,
    kcu.COLUMN_NAME as child_column,
    kcu.REFERENCED_TABLE_NAME as parent_table,
    kcu.REFERENCED_COLUMN_NAME as parent_column,
    rc.DELETE_RULE,
    rc.UPDATE_RULE
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu
JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS rc
    ON kcu.CONSTRAINT_NAME = rc.CONSTRAINT_NAME
WHERE kcu.TABLE_SCHEMA = 'your_database_name'
AND kcu.REFERENCED_TABLE_NAME IS NOT NULL;

-- View check constraints
SELECT 
    cc.TABLE_NAME,
    cc.CONSTRAINT_NAME,
    cc.CHECK_CLAUSE
FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS cc
WHERE cc.CONSTRAINT_SCHEMA = 'your_database_name';

-- View indexes (including unique constraints)
SELECT 
    TABLE_NAME,
    INDEX_NAME,
    COLUMN_NAME,
    NON_UNIQUE
FROM INFORMATION_SCHEMA.STATISTICS
WHERE TABLE_SCHEMA = 'your_database_name'
ORDER BY TABLE_NAME, INDEX_NAME, SEQ_IN_INDEX;
```

#### MSSQL - Query System Views
```sql
-- View all constraints
SELECT 
    t.name AS table_name,
    c.name AS constraint_name,
    c.type_desc AS constraint_type,
    col.name AS column_name
FROM sys.tables t
JOIN sys.check_constraints c ON t.object_id = c.parent_object_id
JOIN sys.columns col ON c.parent_object_id = col.object_id
WHERE t.type = 'U';

-- View foreign key relationships
SELECT 
    fk.name AS foreign_key_name,
    tp.name AS parent_table,
    cp.name AS parent_column,
    tr.name AS referenced_table,
    cr.name AS referenced_column,
    fk.delete_referential_action_desc AS delete_action,
    fk.update_referential_action_desc AS update_action
FROM sys.foreign_keys fk
JOIN sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
JOIN sys.tables tp ON fkc.parent_object_id = tp.object_id
JOIN sys.columns cp ON fkc.parent_object_id = cp.object_id AND fkc.parent_column_id = cp.column_id
JOIN sys.tables tr ON fkc.referenced_object_id = tr.object_id
JOIN sys.columns cr ON fkc.referenced_object_id = cr.object_id AND fkc.referenced_column_id = cr.column_id;

-- View check constraints with definitions
SELECT 
    t.name AS table_name,
    cc.name AS constraint_name,
    cc.definition AS check_definition,
    cc.is_disabled
FROM sys.check_constraints cc
JOIN sys.tables t ON cc.parent_object_id = t.object_id;

-- View primary keys
SELECT 
    t.name AS table_name,
    i.name AS primary_key_name,
    c.name AS column_name
FROM sys.indexes i
JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
JOIN sys.tables t ON i.object_id = t.object_id
WHERE i.is_primary_key = 1;

-- View unique constraints
SELECT 
    t.name AS table_name,
    i.name AS unique_constraint_name,
    c.name AS column_name
FROM sys.indexes i
JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
JOIN sys.tables t ON i.object_id = t.object_id
WHERE i.is_unique_constraint = 1;
```

#### PostgreSQL - Query System Catalogs
```sql
-- View all constraints
SELECT 
    tc.table_name,
    tc.constraint_name,
    tc.constraint_type,
    kcu.column_name
FROM information_schema.table_constraints tc
LEFT JOIN information_schema.key_column_usage kcu
    ON tc.constraint_name = kcu.constraint_name
    AND tc.table_schema = kcu.table_schema
WHERE tc.table_schema = 'public';

-- View foreign key relationships
SELECT 
    tc.table_name AS child_table,
    kcu.column_name AS child_column,
    ccu.table_name AS parent_table,
    ccu.column_name AS parent_column,
    rc.delete_rule,
    rc.update_rule
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu
    ON tc.constraint_name = kcu.constraint_name
JOIN information_schema.constraint_column_usage ccu
    ON ccu.constraint_name = tc.constraint_name
JOIN information_schema.referential_constraints rc
    ON tc.constraint_name = rc.constraint_name
WHERE tc.constraint_type = 'FOREIGN KEY';

-- View check constraints with source
SELECT 
    pgc.conname AS constraint_name,
    pgc.conrelid::regclass AS table_name,
    pg_get_constraintdef(pgc.oid) AS definition
FROM pg_constraint pgc
JOIN pg_namespace pgn ON pgn.oid = pgc.connamespace
WHERE pgc.contype = 'c'
AND pgn.nspname = 'public';

-- View constraint dependencies
SELECT 
    c.conname AS constraint_name,
    c.contype AS constraint_type,
    c.conrelid::regclass AS table_name,
    c.confrelid::regclass AS referenced_table
FROM pg_constraint c
WHERE c.connamespace = 'public'::regnamespace;
```

---

## Foreign Key Actions Deep Dive

### Referential Actions Comparison

| Action | MySQL | MSSQL | PostgreSQL | Description |
|--------|--------|--------|-------------|-------------|
| **CASCADE** | ✅ | ✅ | ✅ | Delete/update child records when parent changes |
| **SET NULL** | ✅ | ✅ | ✅ | Set foreign key to NULL when parent deleted |
| **SET DEFAULT** | ✅ | ✅ | ✅ | Set foreign key to default value |
| **RESTRICT** | ✅ | ✅ | ✅ | Prevent parent deletion if children exist |
| **NO ACTION** | ✅ | ✅ | ✅ | Same as RESTRICT but checked at end of statement |

### Foreign Key Actions Examples

#### CASCADE Actions
```sql
-- MySQL
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- MSSQL
CREATE TABLE order_items (
    item_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT,
    product_id INT,
    CONSTRAINT fk_items_order 
        FOREIGN KEY (order_id) REFERENCES orders(order_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_items_product 
        FOREIGN KEY (product_id) REFERENCES products(product_id)
        ON UPDATE CASCADE
);

-- PostgreSQL
CREATE TABLE audit_logs (
    log_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id) ON DELETE CASCADE,
    action VARCHAR(100),
    timestamp TIMESTAMP DEFAULT NOW()
);
```

#### SET NULL and SET DEFAULT
```sql
-- SET NULL example (all databases)
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    manager_id INT,
    dept_id INT,
    FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
        ON DELETE SET NULL,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
        ON DELETE SET NULL
);

-- SET DEFAULT example
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    category_id INT DEFAULT 1,
    product_name VARCHAR(100),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
        ON DELETE SET DEFAULT
);
```

---

## Complex Constraint Scenarios

### Multi-Table Constraints
```sql
-- PostgreSQL: Cross-table check constraints
CREATE OR REPLACE FUNCTION check_order_customer_consistency()
RETURNS TRIGGER AS $
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM customers c
        WHERE c.customer_id = NEW.customer_id
        AND c.status = 'active'
    ) THEN
        RAISE EXCEPTION 'Cannot create order for inactive customer';
    END IF;
    RETURN NEW;
END;
$ LANGUAGE plpgsql;

CREATE TRIGGER trg_order_customer_check
    BEFORE INSERT OR UPDATE ON orders
    FOR EACH ROW
    EXECUTE FUNCTION check_order_customer_consistency();
```

### Conditional Foreign Keys
```sql
-- MSSQL: Conditional foreign key with check constraint
CREATE TABLE documents (
    doc_id INT IDENTITY(1,1) PRIMARY KEY,
    doc_type VARCHAR(20),
    employee_id INT,
    customer_id INT,
    CONSTRAINT chk_doc_reference 
        CHECK (
            (doc_type = 'internal' AND employee_id IS NOT NULL AND customer_id IS NULL) OR
            (doc_type = 'external' AND customer_id IS NOT NULL AND employee_id IS NULL)
        ),
    CONSTRAINT fk_doc_employee 
        FOREIGN KEY (employee_id) REFERENCES employees(emp_id),
    CONSTRAINT fk_doc_customer 
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
```

### Soft Delete with Constraints
```sql
-- PostgreSQL: Partial unique constraints for soft deletes
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50),
    email VARCHAR(100),
    deleted_at TIMESTAMP,
    
    -- Unique constraint only for non-deleted records
    CONSTRAINT uk_active_username 
        UNIQUE (username) WHERE deleted_at IS NULL,
    CONSTRAINT uk_active_email 
        UNIQUE (email) WHERE deleted_at IS NULL
);
```

---

## Troubleshooting Common Issues

### Foreign Key Constraint Errors
```sql
-- Check for orphaned records before adding FK
SELECT o.order_id, o.customer_id
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Fix orphaned records
DELETE FROM orders 
WHERE customer_id NOT IN (SELECT customer_id FROM customers);

-- Or update with valid reference
UPDATE orders 
SET customer_id = 1  -- default customer
WHERE customer_id NOT IN (SELECT customer_id FROM customers);
```

### Circular References
```sql
-- Handle circular foreign keys with deferred constraints (PostgreSQL)
BEGIN;
SET CONSTRAINTS ALL DEFERRED;

INSERT INTO employees (emp_id, name, manager_id) VALUES (1, 'CEO', NULL);
INSERT INTO employees (emp_id, name, manager_id) VALUES (2, 'Manager', 1);
UPDATE employees SET manager_id = 2 WHERE emp_id = 1;  -- Circular reference

COMMIT;  -- Constraints checked here
```

### Constraint Validation Performance
```sql
-- Batch constraint validation (MSSQL)
ALTER TABLE large_table NOCHECK CONSTRAINT ALL;
-- Perform bulk operations
ALTER TABLE large_table WITH CHECK CHECK CONSTRAINT ALL;

-- PostgreSQL: Validate constraints without blocking
ALTER TABLE large_table VALIDATE CONSTRAINT constraint_name;
```

## Summary Table

| Feature | MySQL | MSSQL | PostgreSQL |
|---------|--------|--------|-------------|
| **Inline FK** | 9.0+ | ✅ | ✅ |
| **Deferred Constraints** | ❌ | ❌ | ✅ |
| **Partial Unique** | ❌ | ✅ (filtered index) | ✅ |
| **JSON Constraints** | Limited | Limited | ✅ Advanced |
| **Array Constraints** | ❌ | ❌ | ✅ |
| **Generated Columns** | ✅ | ✅ | ✅ |
| **Temporal Constraints** | ❌ | ✅ | ✅ |
| **Graph Constraints** | ❌ | ✅ | ❌ |

**🎯 Ah! You want to know the different CASCADE options for DELETE and UPDATE!**

## **🗑️ ON DELETE Options:**

**SET NULL** 📍
```sql
ON DELETE SET NULL
-- Parent deleted → Child FK becomes NULL
-- Employee keeps job, just loses department/manager
```

**CASCADE** 🌊
```sql
ON DELETE CASCADE  
-- Parent deleted → Child record deleted too
-- Department deleted → All employees in it deleted!
```

**RESTRICT** 🛑
```sql
ON DELETE RESTRICT
-- Cannot delete parent if children exist
-- Must delete all employees before deleting department
```

**SET DEFAULT** 🔄
```sql
ON DELETE SET DEFAULT
-- Parent deleted → Child FK becomes default value
-- Must have DEFAULT constraint on FK column
```

**NO ACTION** 🚫
```sql
ON DELETE NO ACTION
-- Same as RESTRICT (default behavior)
-- Prevents deletion if children exist
```

## **📝 ON UPDATE Options:**

**CASCADE** 🌊
```sql
ON UPDATE CASCADE
-- Parent PK updated → Child FK updated automatically
-- Department ID 5→10, all employee dept_ids change 5→10
```

**SET NULL** 📍
```sql
ON UPDATE SET NULL  
-- Parent PK updated → Child FK becomes NULL
-- Rarely used, breaks relationships
```

**RESTRICT** 🛑
```sql
ON UPDATE RESTRICT
-- Cannot update parent PK if children reference it
-- Must update children first
```

**SET DEFAULT** 🔄 (if possible)
```sql
ON UPDATE SET DEFAULT
-- Parent PK updated → Child FK becomes default value
```

**NO ACTION** 🚫
```sql
ON UPDATE NO ACTION
-- Same as RESTRICT (default behavior)
```

## **🎭 Real Examples:**

**Aggressive CASCADE:**
```sql
CONSTRAINT fk_emp_dept FOREIGN KEY (dept_id) 
REFERENCES departments(dept_id) 
ON DELETE CASCADE        -- 💥 Delete dept → Delete all employees
ON UPDATE CASCADE;       -- 🔄 Change dept ID → Update all employees
```

**Conservative RESTRICT:**
```sql
CONSTRAINT fk_emp_dept FOREIGN KEY (dept_id) 
REFERENCES departments(dept_id) 
ON DELETE RESTRICT       -- 🛑 Cannot delete dept with employees
ON UPDATE RESTRICT;      -- 🛑 Cannot change dept ID with employees
```

**Flexible SET NULL:**
```sql
CONSTRAINT fk_emp_dept FOREIGN KEY (dept_id) 
REFERENCES departments(dept_id) 
ON DELETE SET NULL       -- 📍 Delete dept → employees become dept-less
ON UPDATE CASCADE;       -- 🔄 Change dept ID → update employees
```

**With DEFAULT:**
```sql
-- Column needs DEFAULT first
dept_id INT DEFAULT 1,
CONSTRAINT fk_emp_dept FOREIGN KEY (dept_id) 
REFERENCES departments(dept_id) 
ON DELETE SET DEFAULT    -- 🔄 Delete dept → employees go to dept 1
ON UPDATE CASCADE;
```

## **🎯 Your Original Choice Analysis:**

```sql
ON DELETE SET NULL ON UPDATE CASCADE  -- 👍 Great choice!
```

**Why it's smart:**
- **DELETE SET NULL**: Employees survive department/manager changes 👥
- **UPDATE CASCADE**: IDs stay synchronized automatically 🔄
- **Balanced**: Not too aggressive, not too restrictive ⚖️

**💡 This gives you organizational flexibility while maintaining data integrity!** ✨

Complex Constraint Scenarios
Multi-Table Constraints
sql-- PostgreSQL: Cross-table check constraints
CREATE OR REPLACE FUNCTION check_order_customer_consistency()
RETURNS TRIGGER AS $
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM customers c
        WHERE c.customer_id = NEW.customer_id
        AND c.status = 'active'
    ) THEN
        RAISE EXCEPTION 'Cannot create order for inactive customer';
    END IF;
    RETURN NEW;
END;
$ LANGUAGE plpgsql;

CREATE TRIGGER trg_order_customer_check
    BEFORE INSERT OR UPDATE ON orders
    FOR EACH ROW
    EXECUTE FUNCTION check_order_customer_consistency();
Conditional Foreign Keys
sql-- MSSQL: Conditional foreign key with check constraint
CREATE TABLE documents (
    doc_id INT IDENTITY(1,1) PRIMARY KEY,
    doc_type VARCHAR(20),
    employee_id INT,
    customer_id INT,
    CONSTRAINT chk_doc_reference 
        CHECK (
            (doc_type = 'internal' AND employee_id IS NOT NULL AND customer_id IS NULL) OR
            (doc_type = 'external' AND customer_id IS NOT NULL AND employee_id IS NULL)
        ),
    CONSTRAINT fk_doc_employee 
        FOREIGN KEY (employee_id) REFERENCES employees(emp_id),
    CONSTRAINT fk_doc_customer 
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
Soft Delete with Constraints
sql-- PostgreSQL: Partial unique constraints for soft deletes
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50),
    email VARCHAR(100),
    deleted_at TIMESTAMP,
    
    -- Unique constraint only for non-deleted records
    CONSTRAINT uk_active_username 
        UNIQUE (username) WHERE deleted_at IS NULL,
    CONSTRAINT uk_active_email 
        UNIQUE (email) WHERE deleted_at IS NULL
);

Troubleshooting Common Issues
Foreign Key Constraint Errors
sql-- Check for orphaned records before adding FK
SELECT o.order_id, o.customer_id
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Fix orphaned records
DELETE FROM orders 
WHERE customer_id NOT IN (SELECT customer_id FROM customers);

-- Or update with valid reference
UPDATE orders 
SET customer_id = 1  -- default customer
WHERE customer_id NOT IN (SELECT customer_id FROM customers);
Circular References
sql-- Handle circular foreign keys with deferred constraints (PostgreSQL)
BEGIN;
SET CONSTRAINTS ALL DEFERRED;

INSERT INTO employees (emp_id, name, manager_id) VALUES (1, 'CEO', NULL);
INSERT INTO employees (emp_id, name, manager_id) VALUES (2, 'Manager', 1);
UPDATE employees SET manager_id = 2 WHERE emp_id = 1;  -- Circular reference

COMMIT;  -- Constraints checked here
Constraint Validation Performance
sql-- Batch constraint validation (MSSQL)
ALTER TABLE large_table NOCHECK CONSTRAINT ALL;
-- Perform bulk operations
ALTER TABLE large_table WITH CHECK CHECK CONSTRAINT ALL;

-- PostgreSQL: Validate constraints without blocking
ALTER TABLE large_table VALIDATE CONSTRAINT constraint_name;

