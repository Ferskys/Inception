FROM alpine:3.19.4
RUN apk update && apk upgrade && apk add nginx && apk add openssl 
RUN mkdir /etc/nginx/ssl
RUN openssl req -x509 -sha256 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/fsuomins.key \
    -out /etc/nginx/ssl/fsuomins.crt \
    -days 365 -nodes \
    -subj "/C=BR/ST=SãoPaulo/L=Brasil/O=42 School/OU=fsuomins/CN=fsuomins/"
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]  