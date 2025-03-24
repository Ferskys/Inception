FROM alpine:3.20.6

RUN apk update && \
    apk upgrade && \
    apk add php82 \
            php82-fpm \
            php82-mysqli \
            php82-json \
            php82-xml \
            php82-curl \
            php82-openssl \
            php82-mbstring \
            php82-gd \
            php82-zlib \
            php82-phar \
            mysql-client \
            curl && \
            ln -s /usr/bin/php82 /usr/bin/php && \
            ln -s /usr/bin/php-fpm82 /usr/bin/php-fpm

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/wordpress

RUN echo "memory_limit = 512M" >> /etc/php82/php.ini

RUN mkdir -p /run/php /var/www/wordpress

COPY tools/wp-entrypoint.sh /usr/bin/wp-entrypoint.sh
RUN chmod +x /usr/bin/wp-entrypoint.sh

# Configure PHP-FPM
RUN echo "listen = 0.0.0.0:9000" >> /etc/php82/php-fpm.d/www.conf && \
    echo "pm.max_children = 50" >> /etc/php82/php-fpm.d/www.conf && \
    echo "pm.start_servers = 5" >> /etc/php82/php-fpm.d/www.conf && \
    echo "pm.min_spare_servers = 5" >> /etc/php82/php-fpm.d/www.conf && \
    echo "pm.max_spare_servers = 35" >> /etc/php82/php-fpm.d/www.conf && \
    echo "pm.max_requests = 500" >> /etc/php82/php-fpm.d/www.conf

# Set proper permissions
RUN chown -R nobody:nobody /var/www/wordpress && \
    chmod -R 755 /var/www/wordpress

EXPOSE 9000

ENTRYPOINT [ "/usr/bin/wp-entrypoint.sh" ]