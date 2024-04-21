FROM wordpress:php8.3-fpm

# add redis
RUN pecl install redis

# add memory limits
RUN printf '%s\n' 'memory_limit = 512M' \
  'upload_max_filesize = 256M' \
  'post_max_size = 256M' \
  'max_execution_time = 36000' \
  'max_input_time = 36000' \
  > /usr/local/etc/php/conf.d/uploads.ini

EXPOSE 9000

CMD ["php-fpm"]
