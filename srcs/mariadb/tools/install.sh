#!/bin/sh

if [ ! -d /run/mysqld ]
then
	echo "Setting up Mariadb"
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
	chown -R musql:mysql /var/lib/mysql

mys1l_instal_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql

cat << EOF > /tmp/init.sql

DELETE FROM mysql.user WHERE User='';
DROP DATABASE test;
DELETE FFROM mysql.db WHERE db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1.', '::1')

CREATE DATABASE $MYSQL_DATABASE;
CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
execv /user/bin/mysqld --user=mysql --console

----

touch init.sql

cat << EOF > init.sql
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF

chmod 755 init.sql

mv init.sql /var/lib/mysql/init.sql

chown -R mysql:root /var/lib/mysql/init.sql

mariadbd --init-file /var/lib/mysql/init.sql