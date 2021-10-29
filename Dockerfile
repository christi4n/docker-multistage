#
# STAGE 1: composer
#
FROM composer:2.1.9 as composer

ARG WEB_DOCUMENT_ROOT

ENV WEB_DOCUMENT_ROOT=$WEB_DOCUMENT_ROOT

WORKDIR /app

RUN git clone https://github.com/christi4n/typo3v11-base.git
RUN mv typo3v11-base/* $PWD/ \
    && rm typo3v11-base -Rf

# Clear cache for previous buildq
RUN composer clearcache

# Run composer to build dependencies in vendor folder
RUN set -xe \
    && composer install --no-dev --no-scripts --no-suggest --no-interaction --prefer-dist --optimize-autoloader

# Generated optimized autoload files containing all classes from vendor folder and project itself
RUN composer dump-autoload --no-dev --optimize --classmap-authoritative

#
# STAGE 2: Apache web server
#
FROM webdevops/php-apache:7.4

LABEL Maintainer="Christian BELLET <christian@mydevfactory.net>" Description="Lightweight container with Nginx based on Alpine Linux."

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Setup document root
RUN mkdir -p /var/www

# Directory where we are
WORKDIR /var/www

COPY --from=composer /app /var/www/

RUN chown -R application:application /var/www/ && chmod -R g+rwX /var/www/

# Switch to use a non-root user from here on
USER application

RUN touch public/typo3conf/ENABLE_INSTALL_TOOL

# Expose the port nginx is reachable on
EXPOSE 9000
