#!/bin/sh

APACHE_HOME="/usr/local/apache2"
ALT_DOMAIN = "test.domain.com"
ALT_DOMAIN2 = "www.test.domain.com"
MANGER_EMAIL = "admin@domain.com"

# Get Certificate with Certbot from Let's Encrypt
sudo certbot certonly -n --webroot \
  -w ${APACHE_HOME}/htdocs \
  -d ${ALT_DOMAIN} \
  -d ${ALT_DOMAIN2} \
  -m ${MANGER_EMAIL}