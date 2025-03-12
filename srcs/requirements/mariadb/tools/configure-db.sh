#!/bin/sh

# Inicializa o banco de dados
echo "Inicializando o MariaDB..."
mariadb-install-db --user=mysql --datadir=/var/lib/mysql

# Inicia o MariaDB em segundo plano para configuração
echo "Iniciando o MariaDB..."
mariadbd-safe &

# Aguarda o serviço do MariaDB iniciar corretamente
sleep 10  # Ajuste o tempo conforme necessário para garantir que o MariaDB tenha tempo para inicializar

# Executa comandos para configurar o banco e os usuários
echo "Configurando banco de dados e usuários..."

# Remove usuários e banco de dados padrões
mariadb -e "DROP USER IF EXISTS ''@'localhost'"
mariadb -e "DROP DATABASE IF EXISTS test"

# Criação do banco de dados e usuários
mariadb -e "CREATE DATABASE IF NOT EXISTS $WP_DATABASE_NAME;"
mariadb -e "GRANT ALL ON $WP_DATABASE_NAME.* TO '$WP_DATABASE_USER'@'%' IDENTIFIED BY '$WP_DATABASE_PASSWORD';"

# Altera a senha do usuário root do MariaDB
mariadb -e "ALTER USER '$WP_DATABASE_ROOT'@'localhost' IDENTIFIED BY '$WP_DATABASE_ROOT_PASSWORD';"
mariadb -e "FLUSH PRIVILEGES;"

echo "Configuração concluída com sucesso!"