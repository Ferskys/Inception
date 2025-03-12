#!/bin/sh

# Configuração do wp-config.php
echo "Configurando wp-config.php..."
wp config create --allow-root --path=/var/www/html \
    --dbname=$WP_DATABASE_NAME \
    --dbuser=$WP_DATABASE_USER \
    --dbpass=$WP_DATABASE_PASSWORD \
    --dbhost=$WP_DATABASE_HOST \
    --dbprefix='wp_' \
    --dbcharset="utf8"

# Instalar o WordPress
echo "Instalando o WordPress..."
wp core install --allow-root --path=/var/www/html \
    --url=$WP_URL \
    --title=$WP_TITLE \
    --admin_user=$WP_ADMIN_USER \
    --admin_password=$WP_ADMIN_PASSWORD \
    --admin_email=$WP_ADMIN_EMAIL

# Instalar e ativar o plugin Redis Cache
echo "Instalando e ativando o plugin Redis Cache..."
wp plugin install redis-cache --activate --allow-root

# Configuração do Redis
echo "Configurando Redis..."
wp config set WP_REDIS_HOST $REDIS_HOST --allow-root
wp config set WP_REDIS_PORT $REDIS_PORT --allow-root

# Ativar tema padrão (por exemplo, Twenty Twenty-Two)
echo "Ativando o tema Twenty Twenty-Two..."
wp theme activate twentytwentytwo --allow-root

# Habilitar o plugin Redis
echo "Habilitando o plugin Redis..."
wp redis enable --all --allow-root

# Criar o usuário do WordPress
echo "Criando o usuário do WordPress..."
wp user create $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD --allow-root

# Chamar o php-fpm para rodar o WordPress
echo "Iniciando o PHP-FPM..."
php-fpm81 -F
