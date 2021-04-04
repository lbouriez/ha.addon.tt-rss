FROM ${BUILD_FROM}

# MOFIFY DATA PATH
RUN sed -i "s|/config|/data|g" /etc/services.d/update-feeds/run
RUN sed -i "s|/config|/data|g" /etc/cont-init.d/19-newdefault
RUN sed -i "s|/config/|/data/|g" /etc/cont-init.d/30-config

RUN sed -i "s|/config|/data|g" /defaults/default
RUN sed -i "s|/config|/data|g" /defaults/default.incontainer

VOLUME [ "/data" ]

RUN chmod -R 777 /data /var/www/

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
