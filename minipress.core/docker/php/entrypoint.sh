#!/bin/sh
set -e
CONF=/var/www/html/minipress.appli/src/conf/minipress.db.conf.ini
cat > "$CONF" <<INI
driver=mysql
username=${DB_USERNAME}
password=${DB_PASSWORD}
host=${DB_HOST}
database=${DB_DATABASE}
charset=utf8mb4
collation=utf8mb4_unicode_ci
INI
exec php-fpm
