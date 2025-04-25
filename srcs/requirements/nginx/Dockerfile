FROM alpine:3.20.6

ENV DOMAIN_NAME=localhost
ENV COMMON_NAME=localhost

RUN apk update && \
    apk upgrade && \
    apk add nginx openssl bash gettext  # ← adiciona o gettext aqui

RUN mkdir -p /etc/nginx/ssl

COPY conf/nginx.conf.template /etc/nginx/nginx.conf.template
COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
