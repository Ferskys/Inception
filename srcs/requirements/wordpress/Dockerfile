# srcs/requirements/wordpress/Dockerfile
FROM alpine:3.20.6

# Update the package index and install PHP 8.3 and required extensions
RUN apk update && apk add --no-cache \
    php83 \
    php83-fpm \
    php83-mysqli \
    php83-json \
    php83-openssl \
    php83-curl \
    php83-zlib \
    php83-xml \
    php83-phar \
    php83-tokenizer \
    php83-dom \
    php83-ctype \
    php83-iconv \
    php83-session \
    php83-mbstring \
    wget

# Download and extract WordPress
RUN wget https://wordpress.org/latest.tar.gz && \
    mkdir -p /var/www/html && \
    tar -xzf latest.tar.gz -C /var/www/html --strip-components=1 && \
    rm latest.tar.gz

# Copy the WordPress configuration file
COPY conf/wp-config.php /var/www/html/wp-config.php

# Set permissions
RUN chown -R nobody:nobody /var/www/html

# Expose port 9000 for php-clearfpm
EXPOSE 9000

# Start php-fpm
CMD ["/usr/sbin/php-fpm83", "-F"]