FROM php:8.3-fpm-alpine

RUN docker-php-ext-install pdo pdo_mysql

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html/minipress.appli/src
COPY minipress.appli/src/composer.json ./
RUN composer install --no-interaction --no-progress --no-scripts || true

COPY docker/php/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /var/www/html
CMD ["/usr/local/bin/entrypoint.sh"]
