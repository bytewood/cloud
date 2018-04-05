#!/usr/bin/env bash

create_root_ca_key() {
    openssl genrsa -aes256 -passout "pass:${PWD}" -out "${CA_KEY}" 4096
    chmod 400 "${CA_KEY}"
}

create_root_ca_certificate() {
    openssl req -config "${CA_CONF}" \
            -extensions "v3_ca" \
            -new -x509 -days 7300 -sha256 \
            -key "${CA_KEY}" \
            -out "${CA_CER}" \
            -subj "${CA_SUBJ}" \
            -passin "pass:${PWD}"
    chmod 444 "${CA_CER}"
}
