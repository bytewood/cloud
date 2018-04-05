#!/usr/bin/env bash

create_intermediate_ca_key() {
    openssl genrsa -aes256 -passout "pass:${PWD}" -out "${ICA_KEY}" 4096
    chmod 400 "${ICA_KEY}"
}

create_intermediate_ca_certificate_signing_request() {
    openssl req -config "${ICA_CONF}" -new -sha256 \
        -key "${ICA_KEY}" \
        -out "${ICA_CSR}" \
        -passin "pass:${PWD}" \
        -subj "${ICA_SUBJ}"
}

sign_intermediate_ca_csr() {
    openssl ca -batch -config "${CA_CONF}" \
        -extensions "v3_intermediate_ca" \
        -days 3650 -notext -md sha256 \
        -in "${ICA_CSR}" \
        -out "${ICA_CER}" \
        -passin "pass:${PWD}"
    chmod 444 "${ICA_CER}"
}

create_certificate_authority_chain_pem() {
    cat "${ICA_CER}" "${CA_CER}" > "${ICA_CHAIN}"
}
