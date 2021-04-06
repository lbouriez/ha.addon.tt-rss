ARG BUILD_FROM=ghcr.io/linuxserver/baseimage-alpine-nginx:3.13
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

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
ARG TT_RSS_VERSION

RUN \
    set -o pipefail \
    \
    && apk add --no-cache \
        php7-curl=7.4.15-r0 \
        php7-dom=7.4.15-r0 \
        php7-gd=7.4.15-r0 \
        php7-iconv=7.4.15-r0 \
        php7-intl=7.4.15-r0 \
        php7-ldap=7.4.15-r0 \
        php7-mysqli=7.4.15-r0 \
        php7-mysqlnd=7.4.15-r0 \
        php7-pcntl=7.4.15-r0 \
        php7-pdo_mysql=7.4.15-r0 \
        php7-pdo_pgsql=7.4.15-r0 \
        php7-pgsql=7.4.15-r0 \
        php7-posix=7.4.15-r0 \
    \
    && apk add --no-cache \
        curl=7.74.0-r1 \
        php7-apcu=5.1.20-r0 \
        php7-mcrypt=1.0.4-r0 \
        tar=1.33-r1 \
        bash=5.1.0-r0 \
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
    && ln -sf /usr/bin/php7 /usr/bin/php \
    \
    && sed -i 's/^;clear_env/clear_env/i' /etc/php7/php-fpm.d/www.conf \
    \
    && chmod -R 777 /var/www/html \
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
