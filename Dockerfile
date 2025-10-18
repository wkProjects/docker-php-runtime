FROM php:8.4-apache

ARG EXTENSION_INSTALLER_VERSION=2.9.13
ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/download/${EXTENSION_INSTALLER_VERSION}/install-php-extensions /usr/local/bin/

COPY php_extensions /etc/php_extensions
RUN install-php-extensions $(cat /etc/php_extensions)

COPY apache_modules /etc/apache_modules
RUN a2enmod $(cat apache_modules)

COPY php.ini $PHP_INI_DIR/conf.d/custom.ini

RUN apt-get update && apt-get -y install locales && \
    echo "de_DE ISO-8859-1" >>/etc/locale.gen && \
    echo "de_DE.UTF-8 UTF-8" >>/etc/locale.gen && \
    locale-gen de_DE de_DE.utf8 \
    && rm -rf /var/lib/apt/lists/*
