FROM php:7.3-fpm
ARG WITH_XDEBUG=false

RUN apt-get update && apt-get install -y --no-install-recommends \
    vim curl debconf subversion \
    git apt-transport-https apt-utils \
    build-essential locales acl mailutils \
    wget zip unzip gnupg gnupg1 gnupg2 ssh
# Installation pour Symfony Panther
RUN apt-get install -y libzip-dev zlib1g-dev chromium
# To disable Chrome's sandboxing (unsafe, but allows to use Panther in containers)
ENV PANTHER_NO_SANDBOX 1

RUN if [ $WITH_XDEBUG = "true" ] ; then \
       pecl install xdebug; \
       docker-php-ext-enable xdebug; \
       echo "error_reporting = E_ALL" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
       echo "display_startup_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
       echo "display_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
       echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
   fi ;

RUN docker-php-ext-install pdo pdo_mysql

COPY php-fpm-pool.conf /etc/php/7.3/pool.d/www.conf

RUN curl -sSk https://getcomposer.org/installer | php -- --disable-tls && \
   mv composer.phar /usr/local/bin/composer

RUN rm -rf /var/lib/apt/lists/*
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    echo "fr_FR.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen

WORKDIR /var/www/backend

EXPOSE 9000
CMD ["php-fpm"]