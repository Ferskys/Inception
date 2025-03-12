FROM alpine:3.20.6

# Argumentos de configuração do banco de dados
ARG WP_DATABASE_NAME
ARG WP_DATABASE_USER
ARG WP_DATABASE_PASSWORD
ARG WP_DATABASE_ROOT
ARG WP_DATABASE_ROOT_PASSWORD

# Criando diretórios e ajustando permissões
RUN mkdir -p /var/lib/mysql /var/run/mysqld && chmod -R 777 /var/run/mysqld

# Instalando pacotes necessários
RUN apk update && apk add --no-cache mariadb mariadb-client openrc

# Copiando a configuração personalizada do MariaDB
COPY ./conf/my.cnf /etc/my.cnf

# Copiando o script de configuração para dentro do container
COPY ./tools/configure-db.sh /tmp/configure-db.sh

# Tornando o script executável e executando-o
RUN chmod a+x /tmp/configure-db.sh; ash -f /tmp/configure-db.sh

# Expondo a porta do MariaDB
EXPOSE 3306

# Comando para iniciar o MariaDB
ENTRYPOINT [ "mariadbd-safe" ]