#!/usr/bin/env bash


configure_subject_alternate_names() {
    sed "s|SUBJECT_ALT_NAME_1|$SAN|g" "${ICA_CONF}" > "${SERVER_CONF}"
}

create_server_private_key() {
    openssl genrsa -aes256 -passout "pass:${PWD}" -out "${SERVER_KEY}" 2048
    chmod 400 "${SERVER_KEY}"
}

create_server_certificate_signing_request() {
    openssl req -config "${SERVER_CONF}" \
        -new -sha256 \
        -key "${SERVER_KEY}" \
        -out "${SERVER_CSR}" \
        -passin "pass:${PWD}" \
        -subj "${SERVER_SUBJ}"
}

sign_server_csr() {
    openssl ca -batch -config "${SERVER_CONF}" \
        -extensions "server_cert" \
        -days 375 -notext -md sha256 \
        -in "${SERVER_CSR}" \
        -out "${SERVER_CER}" \
        -passin "pass:${PWD}"

    chmod 444 "${SERVER_CER}"
}

verify_server_certificate_chain_of_trust() {
    openssl verify -CAfile "${ICA_CACHAIN}" "${SERVER_CER}"
}

store_chain_of_trust_and_certificate_in_pkcs12() {
    openssl pkcs12 -export \
        -out "${SERVER_PKCS12}" \
        -inkey "${SERVER_KEY}" \
        -name "${SERVER_ALIAS}" \
        -in "${SERVER_CER}" \
        -certfile "${ICA_CER}" \
        -passin "pass:${PWD}" \
        -passout "pass:${PWD}"
}

display_contents_of_pkcs12() {
    openssl pkcs12 -in "${SERVER_PKCS12}" -passin "pass:${PWD}" -passout "pass:${PWD}" -info
}
