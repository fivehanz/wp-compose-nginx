FROM wordpress:php8.3-fpm

# add redis
RUN MAKEFLAGS=" -j 4" pecl install redis igbinary \
  && docker-php-ext-enable redis \
  && docker-php-ext-enable igbinary

# add memory limits
RUN printf '%s\n' 'memory_limit = 2G' \
  'upload_max_filesize = 256M' \
  'post_max_size = 256M' \
  'max_execution_time = 36000' \
  'max_input_time = 36000' \
  > /usr/local/etc/php/conf.d/uploads.ini

EXPOSE 9000

CMD ["php-fpm"]
