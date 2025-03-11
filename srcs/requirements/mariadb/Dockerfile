FROM alpine:3.20.6

RUN apk add --no-cache mariadb mariadb-client

RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql

COPY conf/my.cnf /etc/mysql/my.cnf

VOLUME /var/lib/mysql

EXPOSE 3306

CMD ["mariadbd", "--user=root"]