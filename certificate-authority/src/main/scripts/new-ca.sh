#!/usr/bin/env bash

ROOT="`pwd`/`dirname $0`"
source "${ROOT}/_env.sh" "${1}"
source "${SCRIPTS}/_store.sh"
source "${SCRIPTS}/_ca.sh"

commands=(
    'create_store "${CA_DIR}" "${CA_CONF_TEMPLATE}" "intermediates" "${CA_NAME}"'
    'create_root_ca_key'
    'create_root_ca_certificate'
    'verify_certificate_key_pair "${CA_CER}" "${CA_KEY}"'
)

process_commands