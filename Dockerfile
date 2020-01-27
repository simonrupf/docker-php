FROM alpine:3.11

ENV S6RELEASE v1.22.1.0
ENV S6URL     https://github.com/just-containers/s6-overlay/releases/download/
ENV S6_READ_ONLY_ROOT 1

RUN \
# Install dependencies
    apk add --no-cache \
        nginx \
        php7-fpm \
        php7-opcache \
        tzdata \
    && \
# Remove (some of the) default nginx config
    rm -rf \
        /etc/nginx.conf \
        /etc/nginx/conf.d \
        /etc/nginx/sites-* \
        /etc/php7/php-fpm.d/www.conf \
    && \
# Ensure nginx logs, even if the config has errors, are written to stderr
    ln -s /dev/stderr /var/log/nginx/error.log

# Install s6 overlay for service management
RUN apk add --no-cache gnupg && \
    export GNUPGHOME="$(mktemp -d)" && \
    gpg2 --list-public-keys || /bin/true && \
    wget -qO - https://keybase.io/justcontainers/key.asc | gpg2 --import - && \
    cd /tmp && \
    wget -qO - ${S6URL}${S6RELEASE}/s6-overlay-amd64.tar.gz.sig > s6-overlay-amd64.tar.gz.sig && \
    wget -qO - ${S6URL}${S6RELEASE}/s6-overlay-amd64.tar.gz > s6-overlay-amd64.tar.gz && \
    gpg2 --verify s6-overlay-amd64.tar.gz.sig && \
    tar xzf s6-overlay-amd64.tar.gz -C / && \
    apk del gnupg && \
    rm -rf "${GNUPGHOME}" /tmp/*

COPY etc /etc

# Support running s6 under a non-root user
RUN mkdir /etc/services.d/nginx/supervise /etc/services.d/php-fpm7/supervise && \
    mkfifo /etc/services.d/nginx/supervise/control && \
    mkfifo /etc/services.d/php-fpm7/supervise/control && \
    mkfifo /etc/s6/services/s6-fdholderd/supervise/control && \
    chown -R nginx:www-data /etc/services.d /etc/s6 /run

USER nginx:www-data
EXPOSE 8080/tcp
VOLUME /run /tmp /var/lib/nginx/tmp
WORKDIR /var/www

ENTRYPOINT ["/init"]
