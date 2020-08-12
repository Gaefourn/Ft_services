#!/bin/sh
mkdir /run/nginx
touch /run/nginx/nginx.pid
mkdir -p /run/mysqld

echo "User: " $WORDPRESS_DB_USER;
echo "Host: " $WORDPRESS_DB_HOST;
echo "Password: " $WORDPRESS_DB_PASSWORD;
mysql -u $WORDPRESS_DB_USER -h $WORDPRESS_DB_HOST -p$WORDPRESS_DB_PASSWORD ;
while [ $? != 0 ]
do
    sleep 2 ;
    echo "Command failed with error code: " $?;
    mysql -u $WORDPRESS_DB_USER -h $WORDPRESS_DB_HOST -p$WORDPRESS_DB_PASSWORD
done
echo "After brutforce";
mysql -u $WORDPRESS_DB_USER -h $WORDPRESS_DB_HOST -p$WORDPRESS_DB_PASSWORD -e 'CREATE DATABASE wordpress;';
echo "After wp creaction";
mysql -u $WORDPRESS_DB_USER -h $WORDPRESS_DB_HOST -p$WORDPRESS_DB_PASSWORD wordpress < /wordpress-dump.sql;


/usr/sbin/nginx
php-fpm7 -F