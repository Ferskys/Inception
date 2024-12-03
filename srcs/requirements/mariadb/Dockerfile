FROM alpine:3.19.4
RUN apk update && apk upgrade && apk add mariadb mariadb-client
COPY mariadb.conf /etc/my.cnf
RUN mkdir -p /var/lib/mysql /var/log/mysqld /var/run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /var/log/mysqld /var/run/mysqld
COPY mariadb.sh /usr/bin/mariadb.sh
RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql
RUN chmod +x /usr/bin/mariadb.sh
EXPOSE 3306
ENTRYPOINT [ "/usr/bin/mariadb.sh" ]