#!/bin/sh

# Generate Self-signed-certificate
./get-self-signed-cert.sh
# Install Apache
./install-apache.sh
# Install Certbot
./install-certbot.sh