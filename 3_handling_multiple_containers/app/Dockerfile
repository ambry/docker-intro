ARG PHP_VERSION=7.3

FROM php:${PHP_VERSION}-fpm-alpine

WORKDIR /app

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY composer.json composer.lock symfony.lock .env ./
COPY bin bin/
COPY config config/
COPY public public/
COPY src src/

RUN set -eux; \
    composer install \
    --prefer-dist \
    --no-dev \
    --no-autoloader \
    --no-scripts \
    --no-progress \
    --no-suggest \
    --no-interaction

RUN set -eux; \
	mkdir -p var/cache var/log; \
    composer dump-autoload \
        --no-dev \
        --optimize \
        --no-scripts \
        --classmap-authoritative \
	&& chmod +x bin/console \
	&& chown -R www-data:www-data . \
    && sync

CMD ["php-fpm", "-F"]
