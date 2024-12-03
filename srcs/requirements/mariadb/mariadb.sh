#!/bin/sh
echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;" > startdb.sql
echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFY BY '$MYSQL_PASSWORD';" >> startdb.sql
echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';" >> startdb.sql
echo "ALTER USER 'MYSQL_ROOT_USER'@'wordpress.srcs_inception' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> startdb.sql
echo "FLUSH PRIVILEGES;" >> startdb.sql
sleep 8 
mariadbd-safe < startdb.sql
mariadbd-safe -F 