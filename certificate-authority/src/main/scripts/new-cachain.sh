#!/usr/bin/env bash

ROOT="`pwd`/`dirname $0`"
source "${ROOT}/_env.sh" "${1}" "${2}"
source "${SCRIPTS}/_store.sh"
source "${SCRIPTS}/_ica.sh"

commands=(
    'create_store "${ICA_DIR}" "${ICA_CONF_TEMPLATE}" "certificates" "${ICA_NAME}"'
    'create_intermediate_ca_key'
    'create_intermediate_ca_certificate_signing_request'
    'sign_intermediate_ca_csr'
    'create_directory_for_server_certificate_configurations'
    'create_directory_for_client_certificate_configurations'
    'create_certificate_authority_chain_pem'
    'verify_certificate_key_pair "${ICA_CER}" "${ICA_KEY}"'
)
process_commands

