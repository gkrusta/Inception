#!/bin/sh

WP_DIR=/var/www/html
mkdir -p /run/php/

if [ ! -d "$WP_DIR" ]
then
	mkdir -p "$WP_DIR"
fi

chown -R www-data:www-data "$WP_DIR"
chmod 755 "$WP_DIR"

echo "Setting up WordPress"
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 
chmod +x wp-cli.phar 
mv wp-cli.phar /usr/local/bin/wp

cd "$WP_DIR"

sed -i 's#listen = /run/php/php7.4-fpm.sock#listen = wordpress:9000#g' /etc/php/7.4/fpm/pool.d/www.conf

sed -i "s/database_name_here/$MYSQL_DATABASE/" wp-config-sample.php
sed -i "s/username_here/$MYSQL_USER/" wp-config-sample.php
sed -i "s/password_here/$MYSQL_USER_PASSWORD/" wp-config-sample.php
sed -i "s/localhost/mariadb:3306/" wp-config-sample.php

cp wp-config-sample.php wp-config.php


wp core install --url=$WORDPRESS_URL --title=$WORDPRESS_TITLE --admin_user=$WORDPRESS_ADMIN --admin_password=$WORDPRESS_ADMIN_PASSWORD --admin_email=$WORDPRESS_ADMIN_EMAIL --skip-email --allow-root
wp user create $WORDPRESS_USER $WORDPRESS_USER_EMAIL --role=author --user_pass=$WORDPRESS_USER_PASSWORD --allow-root


echo "Starting WordPress"
sleep 1
/usr/sbin/php-fpm7.4 -F