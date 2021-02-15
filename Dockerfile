FROM alpine:3.13

ENV S6_READ_ONLY_ROOT 1

RUN \
# Install dependencies
    apk add --upgrade --no-cache \
        nginx \
        php7-fpm \
        php7-opcache \
        s6-overlay \
        tzdata \
    && \
# Remove (some of the) default nginx config
    rm -rf \
        /etc/nginx.conf \
        /etc/nginx/http.d/*.conf \
        /etc/php7/php-fpm.d/www.conf \
        /var/www/localhost \
    && \
# Ensure nginx logs, even if the config has errors, are written to stderr
    ln -s /dev/stderr /var/log/nginx/error.log

COPY etc /etc

# Support running s6 under a non-root user
RUN mkdir /etc/s6/services/nginx/supervise \
        /etc/s6/services/php-fpm7/supervise && \
    mkfifo /etc/s6/services/nginx/supervise/control \
        /etc/s6/services/php-fpm7/supervise/control && \
    chown -R nginx:www-data /etc/s6 /run

# user nginx, group www-data
USER 100:82
EXPOSE 8080/tcp
VOLUME /run /tmp /var/lib/nginx/tmp
WORKDIR /var/www

ENTRYPOINT ["/init"]
