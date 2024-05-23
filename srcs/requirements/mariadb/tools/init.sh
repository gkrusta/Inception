#!/bin/sh

if [ ! -d /run/mysqld ]
then
	echo "Setting up Mariadb"
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
	chown -R mysql:mysql /var/lib/mysql

cat << EOF > init.sql

DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM IF NOT EXISTS mysql.db WHERE db='test';
DELETE FROM IF NOT EXISTS mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1.', '::1');

ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;

EOF

chmod +x init.sql

mv init.sql /var/lib/mysql/init.sql

fi

echo "Mariadb started"

mariadbd --init-file /var/lib/mysql/init.sql