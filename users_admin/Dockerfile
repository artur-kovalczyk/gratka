FROM php:8.4.16-cli
RUN apt-get update && apt-get install -y git unzip libicu-dev libzip-dev libpq-dev && docker-php-ext-install intl pdo pdo_pgsql zip
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
WORKDIR /var/www/html
EXPOSE 8000



