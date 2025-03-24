#!/bin/sh

# Create the initialization SQL file
echo "CREATE DATABASE IF NOT EXISTS $WP_DB_NAME CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;" > /db1.sql
echo "CREATE USER IF NOT EXISTS '$WP_DB_USER'@'%' IDENTIFIED BY '$WP_DB_PASSWORD';" >> /db1.sql
echo "CREATE USER IF NOT EXISTS '$WP_DB_USER'@'localhost' IDENTIFIED BY '$WP_DB_PASSWORD';" >> /db1.sql
echo "GRANT ALL PRIVILEGES ON $WP_DB_NAME.* TO '$WP_DB_USER'@'%';" >> /db1.sql
echo "GRANT ALL PRIVILEGES ON $WP_DB_NAME.* TO '$WP_DB_USER'@'localhost';" >> /db1.sql
echo "FLUSH PRIVILEGES;" >> /db1.sql

# If root user is defined, add its creation and privileges
if [ -n "$MYSQL_ROOT_USER" ]; then
    echo "CREATE USER IF NOT EXISTS '$MYSQL_ROOT_USER'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> /db1.sql
    echo "CREATE USER IF NOT EXISTS '$MYSQL_ROOT_USER'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> /db1.sql
    echo "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_ROOT_USER'@'%' WITH GRANT OPTION;" >> /db1.sql
    echo "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_ROOT_USER'@'localhost' WITH GRANT OPTION;" >> /db1.sql
    echo "FLUSH PRIVILEGES;" >> /db1.sql
fi

# Initialize the database if not already created
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing the database..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

# Start MariaDB in the foreground using the init file
mariadbd --user=mysql --datadir=/var/lib/mysql --init-file=/db1.sql