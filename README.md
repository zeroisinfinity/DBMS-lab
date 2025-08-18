## SQL Scripts Repository

### Overview
This repository contains SQL practice scripts, lab exercises, and notes for multiple database systems: MySQL, PostgreSQL, Oracle, and SQL Server/Azure SQL. It also includes folders for NoSQL notes and personal experiments.

Use this README as a quick reference to locate scripts and run them against your databases.

### Repository Layout
```
/home/rootusername/SQL_scripts
├── Practice/
│  ├── mysql_prac/
│  │  ├── basics_mysqll.sql
│  │  ├── inter_mysql.sql
│  │  └── misc.sql
│  ├── pg_prac/
│  │  ├── basics_pg.sql
│  │  ├── sql_orderby.sql
│  │  └── pg_inter_prac.sql
│  ├── oracle_prac/
│  │  └── oracle.sql
│  ├── azure_prac/
│  │  ├── basics_azure.sql
│  │  ├── inter_mssql.sql
│  │  └── azure_prac.sqlproj
│  └── mango_prac/   (placeholder for MongoDB/NoSQL practice)
├── notes/
│  ├── sql notes/
│  │  ├── basics/
│  │  ├── intermediate/
│  │  ├── oracle/
│  │  └── specifics/
│  └── nosql_notes/  (placeholder for NoSQL notes)
└── others/
   ├── lab/
   │  └── dbms_28july.sql
   └── mine/
      ├── script1.sql
      ├── SQLQuery join.sql
      └── SQLQuery set.sql
```

### Prerequisites
- MySQL client (`mysql`)
- PostgreSQL client (`psql`)
- Oracle client (SQL*Plus `sqlplus` or Oracle SQLcl)
- SQL Server tools (`sqlcmd`) or Azure Data Studio
- MongoDB shell (`mongosh`) if using NoSQL examples

On Ubuntu/Debian you can install common clients:
```bash
sudo apt update
sudo apt install -y mysql-client postgresql-client
# For SQL Server tools (interactive EULA):
# curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc
# sudo add-apt-repository "$(curl -fsSL https://packages.microsoft.com/config/ubuntu/$(. /etc/os-release; echo $VERSION_ID)/prod.list)"
# sudo apt update && sudo apt install -y mssql-tools unixodbc-dev
# For Oracle SQL*Plus/SQLcl, use Oracle-provided installers.
```

### How to Run Scripts

#### MySQL
- Connect interactively:
```bash
mysql -u <username> -p
```
- Run a script against a specific database:
```bash
mysql -u <username> -p <DB_NAME> < /home/rootusername/SQL_scripts/Practice/mysql_prac/basics_mysqll.sql
```
- Example with root and a database named `practice_db`:
```bash
mysql -u root -p practice_db < /home/rootusername/SQL_scripts/Practice/mysql_prac/inter_mysql.sql
```

#### PostgreSQL
- Connect interactively:
```bash
psql -U <username> -d <database>
```
- Run a script file:
```bash
psql -U <username> -d <database> -f /home/rootusername/SQL_scripts/Practice/pg_prac/basics_pg.sql
```

#### Oracle (SQL*Plus)
- Connect and run a script:
```bash
sqlplus <user>/<password>@<host>:<port>/<service_name> @/home/rootusername/SQL_scripts/Practice/oracle_prac/oracle.sql
```
- Example service-based EZCONNECT: `sqlplus scott/tiger@localhost:1521/XEPDB1 @/path/to/file.sql`

#### SQL Server / Azure SQL (sqlcmd)
- Connect and run a script:
```bash
sqlcmd -S <server_or_host> -U <username> -P <password> -d <database> -i /home/rootusername/SQL_scripts/Practice/azure_prac/inter_mssql.sql
```
- Use `-C` for Azure SQL to trust server cert if needed.

#### MongoDB (placeholder)
If you add JavaScript-based query files under `Practice/mango_prac/`, you can run them with `mongosh` like:
```bash
mongosh "mongodb://<host>:<port>/<db>" /home/rootusername/SQL_scripts/Practice/mango_prac/example.js
```

### Quick Start Examples
- MySQL: initialize schema/data
```bash
mysql -u root -p mydb < /home/rootusername/SQL_scripts/Practice/mysql_prac/misc.sql
```
- PostgreSQL: run ordering examples
```bash
psql -U postgres -d mydb -f /home/rootusername/SQL_scripts/Practice/pg_prac/sql_orderby.sql
```
- SQL Server/Azure: run intermediate practice
```bash
sqlcmd -S localhost -U sa -P '<YourStrong!Passw0rd>' -d tempdb -i /home/rootusername/SQL_scripts/Practice/azure_prac/inter_mssql.sql
```

### Conventions
- Scripts are grouped by platform under `Practice/`.
- Most scripts are safe to re-run, but some may create/drop objects. Review before executing in shared environments.
- Use a dedicated practice database/schema per platform to avoid conflicts (e.g., `practice_db`, `public.practice`, `PRACTICE` schema).

### Troubleshooting
- Authentication errors: verify user, password, and database exist; ensure the server is running and reachable.
- Permissions: some DDL requires elevated privileges; use a user with appropriate grants.
- SQL dialect: do not mix scripts across engines; run MySQL scripts only on MySQL, etc.
- Encoding/newlines: if you see odd characters, open files with UTF-8 encoding.

### Suggested Workflow
1. Create a dedicated practice database in your target engine.
2. Skim the script to understand what objects it creates/uses.
3. Run the script using the appropriate client command above.
4. Experiment interactively, then commit changes with clear messages.

### License / Intent
Personal learning and practice materials. Use at your own risk in non-production environments.

