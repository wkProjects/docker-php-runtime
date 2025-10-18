FROM php:8.4-apache

RUN apt-get update && apt-get -y install locales && \
    echo "de_DE ISO-8859-1" >>/etc/locale.gen && \
    echo "de_DE.UTF-8 UTF-8" >>/etc/locale.gen && \
    locale-gen de_DE de_DE.utf8 \
    && a2enmod rewrite \
    && rm -rf /var/lib/apt/lists/*

COPY php.ini $PHP_INI_DIR/conf.d/custom.ini
RUN curl -sSLf \
        -o /usr/local/bin/install-php-extensions \
        https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions && \
    chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions \
        gd \
        mysqli \
        opcache \
        pdo
