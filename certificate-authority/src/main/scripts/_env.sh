#!/usr/bin/env bash

export PWD=My0wn5peci@lSecret#

# The canonical path of this project

export ROOT="/Users/peter/projects/bytewood/bytewood-cloud/certificate-authority"

# The folder that the certificate authority is installed under.
export BASE="${ROOT}/ca"

# The script folder
export SCRIPTS="${ROOT}/src/main/scripts"

# Root CA, Issuer, subject alternate name and certificate subject values
export CA_CN="${1}"
export ICA_CN="${2}"
export CN="${3}"
export OU="${4}"
export O="${5}"
export L="${6}"
export ST="${7}"
export C="${8}"
export SAN="${9}"


# Root CA
export CA_NAME=`echo "${CA_CN}" | sed 's| |_|g'`
export CA_DIR="${BASE}/${CA_NAME}"
export CA_CONF="${CA_DIR}/cnf/openssl.cnf"
export CA_CRYPT="${CA_DIR}/crypt"
export CA_CONF_TEMPLATE="${ROOT}/src/main/resources/ca/openssl.cnf"

export CA_KEY="${CA_CRYPT}/${CA_NAME}.key.pem"
export CA_CER="${CA_CRYPT}/${CA_NAME}.cert.pem"
export CA_SUBJ="/C=ZA/ST=Western Cape/L=Cape Town/O=bytewood/OU=works/CN=${CA_CN}"


# Intermediate CA
export ICA_NAME=`echo "${ICA_CN}" | sed 's| |_|g'`
export ICA_DIR="${CA_DIR}/intermediates/${ICA_NAME}"
export ICA_CONF="${ICA_DIR}/cnf/openssl.cnf"
export ICA_CRYPT="${ICA_DIR}/crypt"
export ICA_CONF_TEMPLATE="${ROOT}/src/main/resources/ica/openssl.cnf"

export ICA_KEY="${ICA_CRYPT}/${ICA_NAME}.key.pem"
export ICA_CER="${ICA_CRYPT}/${ICA_NAME}.cert.pem"
export ICA_CSR="${ICA_CRYPT}/${ICA_NAME}.csr.pem"
export ICA_SUBJ="/C=ZA/ST=Western Cape/L=Cape Town/O=bytewood/OU=works/CN=${ICA_CN}"

export ICA_CHAIN="${ICA_DIR}/crypt/${ICA_NAME}.chain.pem"


# Server
export SERVER_ALIAS=`echo "${CN}" | sed 's| |_|g'`
export SERVER_CRYPT="${ICA_DIR}/certificates/servers"
export SERVER_CONF="${SERVER_CRYPT}/cnf/${SERVER_ALIAS}.cnf"

export SERVER_KEY="${SERVER_CRYPT}/${SERVER_ALIAS}.key.pem"
export SERVER_CER="${SERVER_CRYPT}/${SERVER_ALIAS}.cert.pem"
export SERVER_CSR="${SERVER_CRYPT}/${SERVER_ALIAS}.csr.pem"
export SERVER_PKCS12="${SERVER_CRYPT}/${SERVER_ALIAS}.p12"
export SERVER_SUBJ="/C=$C/ST=$ST/L=$L/O=$O/OU=$OU/CN=$CN"


exit_on_error() {
	exitcode=$?; [[ "$exitcode" -ne 0 ]] && { echo ${exitcode}; exit ${exitcode}; }
}

process_commands() {
    for command in "${commands[@]}"
    do
        echo "__________ $command"
        eval "${command}"
        exit_on_error
        echo
        echo
    done
}

verify_certificate_key_pair() {
    CERTIFICATE="${1}"
    PRIVATE_KEY="${2}"
    c_hash=`openssl x509 -noout -modulus -in "${CERTIFICATE}" | openssl md5`
    k_hash=`openssl rsa -noout -modulus -in "${PRIVATE_KEY}" -passin "pass:${PWD}" | openssl md5`
    [[ "$chash" = "$khash" ]] && answer="valid" || answer="invalid"
    echo "Certificate Key Pair is $answer"
}
