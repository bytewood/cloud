# bytewood-certificate-authority

Bash scripts to create a Certificate authority and keychain using openssl

###### With guidance from:
https://jamielinux.com/docs/openssl-certificate-authority/

## Usage
First check values in src/main/scripts/_env.sh

#### Create a new certificate authority
src/main/scripts/new-ca.sh <root-ca-name>
```
src/main/scripts/new-ca.sh "Bytewood Root CA"
```

#### Create a new certificate chain
src/main/scripts/new-cachain.sh <root-ca-name> <intermediate-ca-name>
```
src/main/scripts/new-cachain.sh "Bytewood Root CA" "Bytewood Intermediate CA"
```

#### Create a new PKCS12 certificate store with a new server certificate
src/main/scripts/new-pkcs12.sh  <root-ca-name> <intermediat-ca-name> <cn> <ou> <o> <city> <state> <country-code> <SAN>
```
src/main/scripts/new-pkcs12.sh  "Bytewood Root CA" "Bytewood Intermediate CA" "red.dev" dev bytewood "Cape Town" "Western Cape" ZA "green.dev"
```

## TODO
- implement CRL's
- multiple SAN's
