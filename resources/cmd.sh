#!/bin/bash

set -eo pipefail

function init_stepcli() {
    /usr/bin/grep fingerprint ${ACME_CONFIG} | /usr/bin/cut -d '"' -f4 | \
    /usr/bin/xargs -i /usr/bin/step-cli ca bootstrap --ca-url https://acme:9000 --fingerprint {} --install
}

function get_certificate() {
    SANS=${CERT_SANS:-$DNS_NAME}
    local -a args=( --password-file "${ACME_PASSWORD}" "${DNS_NAME}" "/etc/gitlab/ssl/${DNS_NAME}.crt" "/etc/gitlab/ssl/${DNS_NAME}.key" )

    if [[ ! -z "${CERT_NOTAFTER}" ]]; then
        args=(--not-after "$CERT_NOTAFTER" "${args[@]}")
    fi

    if [[ ! -z "${CERT_NOTBEFORE}" ]]; then
        args=(--not-before "$CERT_NOTBEFORE" "${args[@]}")
    fi

    if [[ "${CERT_OVERWRITE}" == "true" ]]; then
        args=(--force "${args[@]}")
    fi

    if [[ ! -z "${CERT_EMAIL}" ]]; then
        args=(--contact "$CERT_EMAIL" "${args[@]}")
    fi

    IFS=','
    for san in $SANS; do
        args=(--san "$san" "${args[@]}")
    done

    /usr/bin/mkdir -p /etc/gitlab/ssl && /usr/bin/chmod 755 /etc/gitlab/ssl
    /usr/bin/step-cli ca certificate "${args[@]}"
}

function renew_certificate() {
    /usr/sbin/start-stop-daemon --start --background --name renew-cert --make-pidfile --pidfile /var/run/step-cli.pid --exec /usr/bin/step-cli \
    -- ca renew --daemon --exec "/opt/gitlab/bin/gitlab-ctl hup nginx" /etc/gitlab/ssl/$DNS_NAME.crt /etc/gitlab/ssl/$DNS_NAME.key
}

init_stepcli
get_certificate
renew_certificate
/assets/init-container