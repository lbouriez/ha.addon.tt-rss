ARG BUILD_FROM=ghcr.io/linuxserver/baseimage-alpine-nginx:3.12
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# From lunik1/docker-tt-rss
# set version label
ARG VERSION
ARG TT_RSS_VERSION
LABEL build_version="master ${BUILD_DATE}"

RUN \
    apk add --no-cache \
        curl=7.64.0-r5 \
        php7-apcu=5.1.16-r0 \
        php7-curl=7.2.33-r0 \
        php7-dom=7.2.33-r0 \
        php7-gd=7.2.33-r0 \
        php7-iconv=7.2.33-r0 \
        php7-intl=7.2.33-r0 \
        php7-ldap=7.2.33-r0 \
        php7-mcrypt=1.0.1-r1 \
        php7-mysqli=7.2.33-r0 \
        php7-mysqlnd=7.2.33-r0 \
        php7-pcntl=7.2.33-r0 \
        php7-pdo_mysql=7.2.33-r0 \
        php7-pdo_pgsql=7.2.33-r0 \
        php7-pgsql=7.2.33-r0 \
        php7-posix=7.2.33-r0 \
        tar=1.32-r0 \
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
    && rm -rf /tmp/* \
    \
    && sed -i 's/^;clear_env/clear_env/i' /etc/php7/php-fpm.d/www.conf

# Copy root filesystem
COPY rootfs /

EXPOSE 80 443

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
