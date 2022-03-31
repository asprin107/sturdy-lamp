#!/bin/sh

APACHE_SOURCE_DIR="${HOME}/certbot-auto-config/apache_httpd/"
APACHE_VERSION="2.4.51"

mkdir -p ${APACHE_SOURCE_DIR}
sudo yum install -y gcc apr apr-devel apr-util apr-util-devel pcre-devel openssl-devel
curl -o ${APACHE_SOURCE_DIR}/httpd-${APACHE_VERSION}.tar.gz https://dlcdn.apache.org//httpd/httpd-${APACHE_VERSION}.tar.gz
tar -zxf ${APACHE_SOURCE_DIR}/httpd-${APACHE_VERSION}.tar.gz -C ${APACHE_SOURCE_DIR}
cd ${APACHE_SOURCE_DIR}/httpd-${APACHE_VERSION}
./configure --enable-ssl --enable-so
sudo make
sudo make install
sudo /usr/local/apache2/bin/apachectl start