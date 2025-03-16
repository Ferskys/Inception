#!/bin/sh

# Inicializa o banco de dados
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing the database..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

# Inicia o MariaDB em segundo plano para configuração
echo "Iniciando o MariaDB..."
mariadbd --user=mysql --datadir=/var/lib/mysql
# Aguarda o serviço do MariaDB iniciar corretamente
sleep 10  # Ajuste o tempo conforme necessário para garantir que o MariaDB tenha tempo para inicializar

# Executa comandos para configurar o banco e os usuários
echo "Configurando banco de dados e usuários..."

# Criação do banco de dados e usuários
mariadb -e "CREATE DATABASE IF NOT EXISTS $WP_DB_NAME;"
mariadb -e "CREATE USER IF NOT EXISTS '$WP_DB_USER'@'%' IDENTIFIED BY '$WP_DB_PASSWORD';"
mariadb -e "GRANT ALL ON $WP_DB_NAME.* TO '$WP_DB_USER'@'%';"
mariadb -e "FLUSH PRIVILEGES;"

if [ -n "$MYSQL_ROOT_USER" ]; then
mariadb -e "CREATE USER IF NOT EXISTS '$MYSQL_ROOT_USER'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
mariadb -e "GRANT ALL ON $WP_DB_NAME.* TO '$MYSQL_ROOT_USER'@'%';"
mariadb -e "FLUSH PRIVILEGES;"
fi
# Altera a senha do usuário root do MariaDB
mariadb -e "ALTER USER '$MYSQL_ROOT_USER'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"

echo "Configuração concluída com sucesso!"