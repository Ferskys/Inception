FROM alpine:3.20.6

RUN apk add --no-cache nginx openssl && \
    mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -sha256 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/fsuomins.key \
        -out /etc/nginx/ssl/fsuomins.crt \
        -days 365 -nodes \
        -subj "/C=BR/ST=SãoPaulo/L=Brasil/O=42 School/OU=fsuomins/CN=fsuomins/"

COPY nginx.conf /etc/nginx/http.d/default.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
