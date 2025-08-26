# Multi-database SQL client Docker image
FROM ubuntu:22.04

# Prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install basic utilities
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    gnupg \
    lsb-release \
    software-properties-common \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install MySQL client
RUN apt-get update && apt-get install -y \
    mysql-client \
    && rm -rf /var/lib/apt/lists/*

# Install PostgreSQL client
RUN apt-get update && apt-get install -y \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Install SQL Server tools
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/22.04/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install -y msodbcsql18 mssql-tools18 unixodbc-dev && \
    rm -rf /var/lib/apt/lists/*

# Add SQL Server tools to PATH
ENV PATH="$PATH:/opt/mssql-tools18/bin"

# Install Oracle Instant Client (Basic and SQLPlus)
RUN apt-get update && apt-get install -y libaio1 && \
    mkdir -p /opt/oracle && \
    cd /opt/oracle && \
    wget https://download.oracle.com/otn_software/linux/instantclient/218000/instantclient-basic-linux.x64-21.8.0.0.0dbru.zip && \
    wget https://download.oracle.com/otn_software/linux/instantclient/218000/instantclient-sqlplus-linux.x64-21.8.0.0.0dbru.zip && \
    unzip instantclient-basic-linux.x64-21.8.0.0.0dbru.zip && \
    unzip instantclient-sqlplus-linux.x64-21.8.0.0.0dbru.zip && \
    rm *.zip && \
    echo /opt/oracle/instantclient_21_8 > /etc/ld.so.conf.d/oracle-instantclient.conf && \
    ldconfig && \
    rm -rf /var/lib/apt/lists/*

# Set Oracle environment variables
ENV LD_LIBRARY_PATH=/opt/oracle/instantclient_21_8:$LD_LIBRARY_PATH
ENV PATH=$PATH:/opt/oracle/instantclient_21_8

# Install MongoDB shell (mongosh) for NoSQL practice
RUN wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | apt-key add - && \
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-6.0.list && \
    apt-get update && \
    apt-get install -y mongodb-mongosh && \
    rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -m -s /bin/bash sqluser

# Create working directory
WORKDIR /sql_scripts

# Copy all SQL scripts and notes
COPY --chown=sqluser:sqluser . .

# Switch to non-root user
USER sqluser

# Default command - bash shell for interactive use
CMD ["/bin/bash"]
