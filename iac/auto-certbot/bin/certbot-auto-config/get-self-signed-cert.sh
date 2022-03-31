#!/bin/sh

CERT_HOME=${HOME}/certbot-auto-config
CERT_DIR=${CERT_HOME}/cert
CERT_CONFIG=${CERT_HOME}/config
CERT_NAME=server

mkdir -p ${CERT_DIR}
# Generate key
openssl genrsa 2048 > ${CERT_DIR}/${CERT_NAME}.key
# Generate CSR
openssl req -config ${CERT_CONFIG}/${CERT_NAME}.cnf -new -key ${CERT_DIR}/${CERT_NAME}.key -out ${CERT_DIR}/${CERT_NAME}.csr
# Generate Self-signed Certificate
openssl x509 -signkey ${CERT_DIR}/${CERT_NAME}.key -in ${CERT_DIR}/${CERT_NAME}.csr -req -days 365 -out ${CERT_DIR}/${CERT_NAME}.crt -extfile ${CERT_CONFIG}/${CERT_NAME}.v3.ext
