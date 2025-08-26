# Docker Setup for SQL Scripts Repository

## Overview
This Docker setup provides a containerized environment with all database clients pre-installed:
- MySQL client
- PostgreSQL client  
- SQL Server tools (sqlcmd)
- Oracle SQL*Plus
- MongoDB shell (mongosh)

## Prerequisites
- Docker installed on your system
- Database servers running (MySQL, PostgreSQL, SQL Server, Oracle, MongoDB)

## Setup Instructions

### Step 1: Build the Docker Image
```bash
cd /home/sahil/SQL_scripts
docker build -t sql-client .
```

### Step 2: Run the Container
Choose one of these methods:

#### Method A: Interactive Container (Recommended)
```bash
docker run -it --rm -v $(pwd):/sql_scripts sql-client
```
This gives you a bash shell inside the container with all your SQL files mounted.

#### Method B: Docker Compose (if docker-compose is installed)
```bash
# Install docker-compose first if needed:
sudo apt install docker-compose

# Then run:
docker-compose up -d
docker-compose exec sql-client bash
docker-compose down  # when finished
```

## Running SQL Scripts

### Inside the Container (Method A)

Once you're in the container shell (`sqluser@container:/sql_scripts$`), you can run scripts:

#### MySQL Scripts
```bash
# Connect and run a script file
mysql -h host.docker.internal -u root -p practice_db < /sql_scripts/Practice/mysql_prac/basics_mysqll.sql

# Or connect interactively first
mysql -h host.docker.internal -u root -p practice_db
# Then inside MySQL prompt:
source /sql_scripts/Practice/mysql_prac/basics_mysqll.sql;
```

#### PostgreSQL Scripts
```bash
# Run a script file directly
psql -h host.docker.internal -U postgres -d practice_db -f /sql_scripts/Practice/pg_prac/basics_pg.sql

# Or connect interactively
psql -h host.docker.internal -U postgres -d practice_db
# Then inside psql prompt:
\i /sql_scripts/Practice/pg_prac/basics_pg.sql
```

#### SQL Server Scripts
```bash
# Run script directly
sqlcmd -S host.docker.internal -U sa -P 'YourPassword' -d practice_db -i /sql_scripts/Practice/azure_prac/inter_mssql.sql

# Interactive connection
sqlcmd -S host.docker.internal -U sa -P 'YourPassword' -d practice_db
```

#### Oracle Scripts
```bash
# Run script with SQL*Plus
sqlplus username/password@host.docker.internal:1521/XEPDB1 @/sql_scripts/Practice/oracle_prac/oracle.sql

# Interactive connection
sqlplus username/password@host.docker.internal:1521/XEPDB1
```

#### MongoDB Scripts
```bash
# Run JavaScript file
mongosh "mongodb://host.docker.internal:27017/practice_db" /sql_scripts/Practice/mango_prac/example.js

# Interactive connection
mongosh "mongodb://host.docker.internal:27017/practice_db"
```

### One-liner Execution (Without entering container)

You can also run scripts directly without entering the container:

```bash
# MySQL
docker run --rm -v $(pwd):/sql_scripts sql-client mysql -h host.docker.internal -u root -p practice_db < /sql_scripts/Practice/mysql_prac/basics_mysqll.sql

# PostgreSQL
docker run --rm -v $(pwd):/sql_scripts sql-client psql -h host.docker.internal -U postgres -d practice_db -f /sql_scripts/Practice/pg_prac/basics_pg.sql

# SQL Server
docker run --rm -v $(pwd):/sql_scripts sql-client sqlcmd -S host.docker.internal -U sa -P 'YourPassword' -d practice_db -i /sql_scripts/Practice/azure_prac/inter_mssql.sql
```

## Database Connection Examples

### Connecting to Local Databases

If your databases are running on your host machine:

```bash
# MySQL on localhost:3306
mysql -h host.docker.internal -u root -p

# PostgreSQL on localhost:5432
psql -h host.docker.internal -U postgres -d postgres

# SQL Server on localhost:1433
sqlcmd -S host.docker.internal -U sa -P 'YourPassword'

# Oracle on localhost:1521
sqlplus system/password@host.docker.internal:1521/XE

# MongoDB on localhost:27017
mongosh "mongodb://host.docker.internal:27017"
```

### Connecting to Remote Databases

Replace `host.docker.internal` with the actual server IP or hostname:

```bash
# Remote MySQL
mysql -h 192.168.1.100 -u username -p database_name

# Remote PostgreSQL
psql -h db.example.com -U username -d database_name

# Azure SQL Database
sqlcmd -S yourserver.database.windows.net -U username -P password -d database_name
```

## File Structure Inside Container

Your local directories are mounted as:
- `./Practice/` → `/sql_scripts/Practice/`
- `./notes/` → `/sql_scripts/notes/`
- `./others/` → `/sql_scripts/others/`
- `./README.md` → `/sql_scripts/README.md`

## Common Workflows

### 1. Test a MySQL Script
```bash
# Start container
docker run -it --rm -v $(pwd):/sql_scripts sql-client

# Inside container - run the script
mysql -h host.docker.internal -u root -p practice_db < /sql_scripts/Practice/mysql_prac/basics_mysqll.sql
```

### 2. Interactive PostgreSQL Session
```bash
# Start container
docker run -it --rm -v $(pwd):/sql_scripts sql-client

# Connect to PostgreSQL
psql -h host.docker.internal -U postgres -d practice_db

# Load and run script
\i /sql_scripts/Practice/pg_prac/basics_pg.sql
```

### 3. Batch Process Multiple Scripts
```bash
# Inside container, run multiple MySQL scripts
for script in /sql_scripts/Practice/mysql_prac/*.sql; do
    echo "Running $script..."
    mysql -h host.docker.internal -u root -p practice_db < "$script"
done
```

## Environment Variables

You can set environment variables for database connections:

```bash
# Set environment variables
docker run -it --rm \
  -v $(pwd):/sql_scripts \
  -e MYSQL_HOST=host.docker.internal \
  -e MYSQL_USER=root \
  -e MYSQL_DATABASE=practice_db \
  sql-client

# Then use them in the container
mysql -h $MYSQL_HOST -u $MYSQL_USER -p $MYSQL_DATABASE
```

## Troubleshooting

### Connection Issues
- **"Connection refused"**: Ensure your database server is running and accessible
- **"Host not found"**: Try using your actual IP address instead of `host.docker.internal`
- **Authentication failed**: Verify username/password and user permissions

### File Permission Issues
- Files are owned by `sqluser` inside the container
- If you get permission errors, check file ownership on your host

### Network Issues
- On Linux, `host.docker.internal` might not work - use `172.17.0.1` or your actual host IP
- For external databases, ensure firewall allows connections from Docker containers

### Getting Host IP Address
```bash
# On Linux, find Docker host IP
ip route show default | awk '/default/ {print $3}'

# Or use this inside the container
getent hosts host.docker.internal | awk '{ print $1 }'
```

## Tips and Best Practices

1. **Create Practice Databases**: Use dedicated databases for testing (e.g., `practice_db`, `test_schema`)
2. **Backup Important Data**: Always backup before running DDL scripts
3. **Review Scripts**: Check what objects scripts create/drop before running
4. **Use Transactions**: Wrap DML operations in transactions for safety
5. **Version Control**: Keep your SQL scripts in version control
6. **Environment Separation**: Use different connection parameters for dev/test/prod

## Security Notes

- Never hardcode passwords in scripts
- Use environment variables or config files for credentials
- The container runs as non-root user `sqluser` for security
- Consider using Docker secrets for sensitive data in production
