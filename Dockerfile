FROM wordpress:php8.2-fpm

RUN apt-get update && apt-get -y install \
  zlib1g-dev \
  libmemcached-dev \
  libssl-dev

RUN apt-get clean autoclean && rm -rf /var/lib/apt/lists/*

# add redis
RUN MAKEFLAGS=" -j 4" pecl install redis igbinary memcached apcu \
  && docker-php-ext-enable redis \
  && docker-php-ext-enable igbinary \
  && docker-php-ext-enable memcached \
  && docker-php-ext-enable apcu 

# add memory limits
RUN printf '%s\n' 'memory_limit = 2G' \
  'upload_max_filesize = 256M' \
  'post_max_size = 256M' \
  'max_execution_time = 36000' \
  'max_input_time = 36000' \
  'default_socket_timeout = 3000' \
  > /usr/local/etc/php/conf.d/uploads.ini

EXPOSE 9000

CMD ["php-fpm"]
