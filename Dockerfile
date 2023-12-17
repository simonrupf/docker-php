FROM alpine:3.19

ARG UID=100
ARG GID=82

LABEL org.opencontainers.image.authors="Simon Rupf <simon@rupf.net>" \
      org.opencontainers.image.source=https://github.com/simonrupf/docker-php \
      org.opencontainers.image.version="${VERSION}"

RUN \
# Install dependencies
    apk add --upgrade --no-cache \
        unit-php82 \
        php82-opcache \
        tzdata \
    && \
# Create working directory
    mkdir -p /var/www/public && \
# Support running unit under a non-root user
    chown -R ${UID}:${GID} /run /var/www /var/lib/unit

COPY --chown=${UID}:${GID} conf.json /var/lib/unit/

# user nginx, group www-data
USER ${UID}:${GID}
EXPOSE 8080/tcp
VOLUME /run /tmp /var/lib/unit
WORKDIR /var/www

HEALTHCHECK CMD ["wget", "-qO/dev/null", "http://localhost:8080"]
ENTRYPOINT ["/usr/sbin/unitd"]
CMD ["--no-daemon", "--log", "/dev/stdout", "--tmpdir", "/tmp"]
