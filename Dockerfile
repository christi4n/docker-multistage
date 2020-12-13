#
# STAGE 1: composer
#
FROM composer:1.10.17 as composer

ARG WEB_DOCUMENT_ROOT

ENV WEB_DOCUMENT_ROOT=$WEB_DOCUMENT_ROOT

# Copy composer files from project root into composer container's working dir
COPY composer.* /app/

# Run composer to build dependencies in vendor folder
RUN set -xe \
    && composer install --no-dev --no-scripts --no-suggest --no-interaction --prefer-dist --optimize-autoloader

# Copy everything from project root into composer container's working dir
# COPY . /app
WORKDIR /app
# Generated optimized autoload files containing all classes from vendor folder and project itself
RUN composer dump-autoload --no-dev --optimize --classmap-authoritative

#
# STAGE 2: nginx
#
FROM webdevops/php-apache:7.4

LABEL Maintainer="Christian BELLET <christian@mydevfactory.net>" Description="Lightweight container with Nginx based on Alpine Linux."

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Setup document root
RUN mkdir -p /var/www

RUN chown -R application:application /var/www

# Switch to use a non-root user from here on
USER nobody

# Add application
WORKDIR /var/www

COPY --from=composer /app /var/www/

CMD mv /app/www/public/* /app/www/html

# Expose the port nginx is reachable on
EXPOSE 9000
