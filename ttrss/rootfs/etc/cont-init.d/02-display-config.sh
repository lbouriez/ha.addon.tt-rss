#!/usr/bin/with-contenv bashio
bashio::log.blue \
        '-----------------------------------------------------------'
    bashio::log.blue " Here is the configuration on boot"
    bashio::log.blue " TTRSS_DB_TYPE => ${TTRSS_DB_TYPE}"
    bashio::log.blue " TTRSS_DB_HOST => ${TTRSS_DB_HOST}"
    bashio::log.blue " TTRSS_DB_USER => ${TTRSS_DB_USER}"
    bashio::log.blue " TTRSS_DB_NAME => ${TTRSS_DB_NAME}"
    bashio::log.blue " TTRSS_DB_PASS => *******"
    bashio::log.blue " TTRSS_DB_PORT => ${TTRSS_DB_PORT}"
    bashio::log.blue " TTRSS_SELF_URL_PATH => ${TTRSS_SELF_URL_PATH}"
    bashio::log.blue \
        '-----------------------------------------------------------'