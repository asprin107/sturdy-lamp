#!/bin/sh

APACHE_HOME="/usr/local/apache2"

echo "0 0,12 * * *  root sudo certbot renew -q --post-hook \"${APACHE_HOME}/bin/apachectl graceful\"" | sudo tee -a /etc/crontab > /dev/null