#!/usr/bin/env bash

ROOT="`pwd`/`dirname $0`"
source "${ROOT}/_env.sh" "${1}" "${2}" "${3}" "${4}" "${5}" "${6}" "${7}" "${8}" "${9}"
source "${SCRIPTS}/_server.sh"

commands=(
    'configure_subject_alternate_names'
    'create_server_private_key'
    'create_server_certificate_signing_request'
    'sign_server_csr'
#   'verify_server_certificate_chain_of_trust'
    'verify_certificate_key_pair "${SERVER_CER}" "${SERVER_KEY}"'
    'store_chain_of_trust_and_certificate_in_pkcs12'
    'display_contents_of_pkcs12'
)

process_commands
