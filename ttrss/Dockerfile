ARG BUILD_FROM=ghcr.io/linuxserver/baseimage-alpine:3.13
# hadolint ignore=DL3006
FROM ${BUILD_FROM} as base
# Based on https://github.com/linuxserver/docker-baseimage-alpine-nginx

COPY base-root /

# hadolint ignore=SC2016
RUN \
    apk add --no-cache \
        php8=8.0.13-r0 \
        php8-fileinfo=8.0.13-r0 \
        php8-fpm=8.0.13-r0 \
        php8-common=8.0.13-r0 \
        php8-mbstring=8.0.13-r0 \
        php8-openssl=8.0.13-r0 \
        php8-session=8.0.13-r0 \
        php8-simplexml=8.0.13-r0 \
        php8-xml=8.0.13-r0 \
        php8-xmlwriter=8.0.13-r0 \
    \
    && apk add --no-cache \
        apache2-utils=2.4.54-r0 \
        git=2.30.6-r0 \
        libressl3.1-libssl=3.1.5-r0 \
        logrotate=3.18.0-r3 \
        nano=5.4-r3 \
        nginx=1.18.0-r15 \
        openssl=1.1.1q-r0 \
    \
    && echo 'fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;' >> \
	    /etc/nginx/fastcgi_params \
    \
    && rm -f /etc/nginx/conf.d/default.conf \
    \
    && sed -i "s#/var/log/messages {}.*# #g" /etc/logrotate.conf \
    \
    && sed -i 's#/usr/sbin/logrotate /etc/logrotate.conf#/usr/sbin/logrotate /etc/logrotate.conf -s /config/log/logrotate.status#g' \
	    /etc/periodic/daily/logrotate

FROM base
# Based on https://github.com/lunik1/docker-tt-rss

# Environment variables
ENV \
    LANG="C.UTF-8" \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    S6_CMD_WAIT_FOR_SERVICES=1

# Copy root filesystem
COPY rootfs /

# Set shell
SHELL ["/bin/ash", "-o", "pipefail", "-c"]

# Install base system
ARG TT_RSS_VERSION=master

RUN \
    set -o pipefail \
    \
    && apk add --no-cache \
        php8-curl=8.0.13-r0 \
        php8-dom=8.0.13-r0 \
        php8-gd=8.0.13-r0 \
        php8-iconv=8.0.13-r0 \
        php8-intl=8.0.13-r0 \
        php8-ldap=8.0.13-r0 \
        php8-mysqli=8.0.13-r0 \
        php8-mysqlnd=8.0.13-r0 \
        php8-pcntl=8.0.13-r0 \
        php8-pdo_mysql=8.0.13-r0 \
        php8-pdo_pgsql=8.0.13-r0 \
        php8-pgsql=8.0.13-r0 \
        php8-posix=8.0.13-r0 \
    \
    && apk add --no-cache \
        php8-pecl-apcu=5.1.20-r0 \
        php8-pecl-mcrypt=1.0.4-r0 \
    \
    && apk add --no-cache \
        curl=7.79.1-r3 \
        tar=1.34-r0 \
        bash=5.1.16-r0 \
        jq=1.6-r1 \
    \
    && mkdir -p /var/www/html/ \
    \
    && if [ -z ${TT_RSS_VERSION+x} ]; then TT_RSS_VERSION=master; fi \
    \
    && curl -o \
        /tmp/ttrss.tar.gz -L \
        "https://gitlab.com/lunik1/tt-rss/-/archive/master/tt-rss-${TT_RSS_VERSION}.tar.gz" \
    \
    && tar xf \
        /tmp/ttrss.tar.gz -C \
	    /var/www/html/ --strip-components=1 \
    \
    && ln -sf /usr/bin/php8 /usr/bin/php \
    \
    && sed -i 's/^;clear_env/clear_env/i' /etc/php8/php-fpm.d/www.conf \
    \
    && mkdir -p /config \
    \
    && chmod -R 777 /var/www/html /config \
    \
    && curl -J -L -o /tmp/bashio.tar.gz \
        "https://github.com/hassio-addons/bashio/archive/v0.13.0.tar.gz" \
    && mkdir /tmp/bashio \
    && tar zxvf \
        /tmp/bashio.tar.gz \
        --strip 1 -C /tmp/bashio \
    \
    && mv /tmp/bashio/lib /usr/lib/bashio \
    && ln -s /usr/lib/bashio/bashio /usr/bin/bashio \
    && chmod -R 555 /usr/lib/bashio \
    \
    && apk del --no-cache --purge \
    && rm -f -r \
        /tmp/*

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Laurent Bouriez <laurent@bouriez.org>" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant lbouriez Add-ons" \
    org.opencontainers.image.authors="Laurent Bouriez <laurent@bouriez.org>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://addons.community" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
