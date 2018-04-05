#!/bin/sh
# Creates a directory structure and file based database for a certificate
# authority that can create, sign and revoke PKI private keys and certificates
#

create_store() {
    STORE_FOLDER="${1}"
    OPENSSL_CONF_TEMPLATE="${2}"
    FOLDER_FOR_INTERMEDIATES="${3}"
    CERTIFICATE_AUTHORITY_NAME="${4}"
    OPENSSL_CONFIGURATION="${STORE_FOLDER}/cnf/openssl.cnf"

    mkdir -p "${STORE_FOLDER}/cnf"
    mkdir -p "${STORE_FOLDER}/crypt"
    mkdir -p "${STORE_FOLDER}/crl"
    mkdir -p "${STORE_FOLDER}/newcerts"
    mkdir -p "${STORE_FOLDER}/${FOLDER_FOR_INTERMEDIATES}"

    touch "${STORE_FOLDER}/index.txt"
    touch "${STORE_FOLDER}/index.txt.attr"
    echo 1000 > "${STORE_FOLDER}/serial"
    echo 1000 > "${STORE_FOLDER}/crlnumber"

    sed "s|BASE_DIRECTORY|$STORE_FOLDER|g" "${OPENSSL_CONF_TEMPLATE}" > "${OPENSSL_CONFIGURATION}"

    sed -i "" "s|C_NAME|$CERTIFICATE_AUTHORITY_NAME|g" "${OPENSSL_CONFIGURATION}"

    chmod -R 777 $STORE_FOLDER
}

create_directory_for_server_certificate_configurations() {
    mkdir -p "${ICA_DIR}/certificates/servers/cnf"
}

create_directory_for_client_certificate_configurations() {
    mkdir -p "${ICA_DIR}/certificates/clients/cnf"
}
