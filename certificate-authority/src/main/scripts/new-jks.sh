#!/usr/bin/env bash

# TODO: parameterize this script


## Import key and certificate into java keystore
#### first create pkcs12
    openssl pkcs12 -export -in server.crt -inkey server.key \
                    -out server.p12 -name [some-alias] \
                    -chain
                    -CAfile ca.crt -caname root
#### second
    keytool -importkeystore \
        -deststorepass [changeit] \
        -destkeypass [changeit] \
        -destkeystore server.keystore \
        -srckeystore server.p12 \
        -srcstoretype PKCS12 \
        -srcstorepass some-password \
        -alias [some-alias]