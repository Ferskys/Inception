FROM    alpine:3.20.6

RUN apk update && \
    apk upgrade && \
    apk add	nginx \
              openssl

RUN mkdir -p etc/nginx/ssl

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
       -out /etc/nginx/ssl/fsuomins.crt \
       -keyout /etc/nginx/ssl/fsuomins.key \
       -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=fsuomins/CN=fsuomins/"

COPY conf/nginx.conf /etc/nginx/nginx.conf

CMD [ "nginx", "-g", "daemon off;" ]