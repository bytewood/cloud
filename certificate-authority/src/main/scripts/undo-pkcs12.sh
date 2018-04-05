#!/usr/bin/env bash

[[ $# < 3 ]] && exit -1

ROOT="`pwd`/`dirname $0`"
source "${ROOT}/_env.sh" "${1}" "${2}" "${3}"

undo_latest_server_certificate() {
    rm -f "${ICA_DIR}/index.txt"
    mv "${ICA_DIR}/index.txt.old" "${ICA_DIR}/index.txt"

    rm -f "${ICA_DIR}/serial"
    mv "${ICA_DIR}/serial.old" "${ICA_DIR}/serial"

    rm -f "${SERVER_CONF}"
    rm -f "${SERVER_KEY}"
    rm -f "${SERVER_CER}"
    rm -f "${SERVER_CSR}"
    rm -f "${SERVER_PKCS12}"
}

usage() {
    echo "./undo-pkcs12.sh <ROOT_CA_NAME> <INTERMEDIATE_CA_NAME> <SERVER_CERTIFICATE_NAME>" \
        "\n\tRemoves the "
    exit -1
}
undo_latest_server_certificate

