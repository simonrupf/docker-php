FROM alpine:3.16

ARG UID=100
ARG GID=82

RUN \
# Install dependencies
    apk add --upgrade --no-cache \
        nginx \
        php81-fpm \
        php81-opcache \
        s6 \
        tzdata \
    && \
# Remove (some of the) default nginx config
    rm -rf \
        /etc/nginx.conf \
        /etc/nginx/http.d/*.conf \
        /etc/php81/php-fpm.d/www.conf \
        /var/www/localhost \
    && \
# Ensure nginx logs, even if the config has errors, are written to stderr
    ln -s /dev/stderr /var/log/nginx/error.log

COPY etc /etc

# Support running s6 under a non-root user
RUN mkdir /etc/s6/services/nginx/supervise \
        /etc/s6/services/php-fpm81/supervise && \
    mkfifo /etc/s6/services/nginx/supervise/control \
        /etc/s6/services/php-fpm81/supervise/control && \
    chown -R ${UID}:${GID} /etc/s6 /run

# user nginx, group www-data
USER ${UID}:${GID}
EXPOSE 8080/tcp
VOLUME /run /tmp /var/lib/nginx/tmp
WORKDIR /var/www

ENTRYPOINT ["/etc/init.d/rc.local"]
