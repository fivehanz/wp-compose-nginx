FROM wordpress:php8.3-fpm

RUN pecl install redis

EXPOSE 9000

CMD ["php-fpm"]
