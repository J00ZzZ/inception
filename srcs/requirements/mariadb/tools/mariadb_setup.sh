#!/bin/sh
set -e

# Ensure directories exist and have correct permissions
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

mkdir -p /var/log/mysql
chown -R mysql:mysql /var/log/mysql

chown -R mysql:mysql /var/lib/mysql

# Retrieve secrets
if [ -f /run/secrets/db_password ] && [ -f /run/secrets/db_root_password ]; then
    DB_PASSWORD=$(cat /run/secrets/db_password)
    DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
else
    echo "Error: Secret files not found!"
    exit 1
fi

# Initialize MariaDB directory if database tables do not exist
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB system databases..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql --rpm
fi

# Create initialization SQL script
TEMP_SQL="/tmp/init.sql"
cat << EOF > "$TEMP_SQL"
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED VIA mysql_native_password USING PASSWORD('${DB_ROOT_PASSWORD}');
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

echo "Configuring database..."
# Run mysqld in bootstrap mode to execute SQL without starting the server
mysqld --user=mysql --bootstrap < "$TEMP_SQL"
rm -f "$TEMP_SQL"

echo "Database configuration completed. Starting MariaDB..."
exec mysqld --user=mysql
