#!/bin/sh

WP_DIR=/var/www/html/wordpress
mkdir -p /run/php/

if [ ! -d "$WP_DIR" ]
then
	mkdir -p "$WP_DIR"
fi

chown -R www-data:www-data "$WP_DIR"

if [ ! -f wp-config.php ]
echo "Setting up WordPress"
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 
chmod +x wp-cli.phar 
mv wp-cli.phar /usr/local/bin/wp

cd "$WP_DIR"

wp core download --allow-root

mv wp-config-sample.php wp-config.php

sed -i "s/database/$MYSQL_DATABASE/" wp-config.php
sed -i "s/database_user/$WORDPRESS_USER/" wp-confi
sed -i "s/passwod/$WORDPRESS_USER_PASSWORD/" wp-config.php
sed -i "s/localhost/mariadb/" wp-config.php 

wp core install --url=$WORDPRESS_URL --title=$WORDPRESS_TITLE --admin_user=$WORDPRESS_ADMIN --admin_password=$WORDPRESS_ADMIN_PASSWORD --admin_email=$WORDPRESS_ADMIN_EMAIL --skip-email --allow-root
wp user create $WORDPRESS_USER $WORDPRESS_USER_EMAIL --role=author --user_pass=$WORDPRESS_USER_PASSWORD --allow-root

sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf
fi

echo "WordPress started"
exec /usr/sbin/php7.3-fpm -F