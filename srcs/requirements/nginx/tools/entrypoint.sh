#!/bin/bash

CERT_PATH="/etc/nginx/ssl"
DOMAIN=${DOMAIN_NAME:-localhost}
COMMON_NAME=${COMMON_NAME:-localhost}

# Gerar certificado
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    -out "$CERT_PATH/$COMMON_NAME.crt" \
    -keyout "$CERT_PATH/$COMMON_NAME.key" \
    -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=$COMMON_NAME/CN=$DOMAIN/"

# Substituir variáveis no template para gerar nginx.conf final
envsubst '${DOMAIN_NAME} ${COMMON_NAME}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

# Iniciar nginx
exec nginx -g "daemon off;"