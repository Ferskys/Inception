FROM alpine:3.20.6

RUN apk update && apk upgrade && apk add mariadb mariadb-client

COPY tools/my.cnf /etc/my.cnf

RUN mkdir -p /var/lib/mysql /var/log/mysqld /var/run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /var/log/mysqld /var/run/mysqld

COPY tools/configure-db.sh /usr/bin/configure-db.sh
RUN chmod +x /usr/bin/configure-db.sh

EXPOSE 3306

ENTRYPOINT [ "/usr/bin/configure-db.sh"]