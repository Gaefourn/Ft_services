#!/bin/sh

mkdir -p /run/mysqld
mysql_install_db --user=username --basedir=/usr

cat << EOF > admin.sql
CREATE USER 'username'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'username'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF
mysqld --user=username --bootstrap --verbose=0 --skip-grant-tables=0 < admin.sql
exec /usr/bin/mysqld --user=username --console