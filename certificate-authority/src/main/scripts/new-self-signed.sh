#!/usr/bin/env bash

# TODO: parameterize this script

## Self Signed Certificate
    openssl genrsa -out server.key 2048
    openssl req -new -out server.csr -key server.key
    openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
