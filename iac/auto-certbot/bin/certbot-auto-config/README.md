# Precedure
1. Run init.sh
   1. get-self-signed-cert.sh
   2. install-apache.sh (can be skipped when already has apache httpd running.)
   3. install-certbot.sh
2. Check and Config Apache httpd server config.
3. Run final.sh
   1. get-cert-certbot.sh
   2. enroll-automation.sh

# Check
## 1. Apache Config Files
### 1-1. httpd.conf
* Comment in `mod_ssl` module.
* Comment in `mod_socache_shmcb` module.
* Comment in *Include conf/extra/httpd-ssl.conf* Include phrase about ssl.
* Comment in *Include conf/extra/httpd-vhosts.conf* Include phrase about vhosts.

### 1-2. extra/httpd-vhosts.conf (Optional. but recommended)
* Edit VirtualHost for your needs. (below is sample)
```
<VirtualHost *:80>
    ServerAdmin webmaster@dummy-host.example.com
    DocumentRoot "/usr/local/apache2/docs/dummy-host.example.com"
    ServerName test.domain.com
    ErrorLog "logs/dummy-host.example.com-error_log"
    CustomLog "logs/dummy-host.example.com-access_log" common
</VirtualHost>

<VirtualHost *:80>
    ServerAdmin webmaster@dummy-host2.example.com
    DocumentRoot "/usr/local/apache2/docs/dummy-host2.example.com"
    ServerName test.domain.com
    ServerAlias www.test.domain.com
    ErrorLog "logs/dummy-host2.example.com-error_log"
    CustomLog "logs/dummy-host2.example.com-access_log" common
</VirtualHost>
```

### 1-3. extra/httpd-ssl.conf
* Edit certificate location. /etc/letsencrypt is a certificate home directory for certbot.
#### Certificate
```
SSLCertificateFile "/usr/local/apache2/conf/server.crt"
>>>
SSLCertificateFile "/etc/letsencrypt/live/test.domain.com/cert.pem"
```
* Edit private key location. /etc/letsencrypt is a certificate home directory for certbot.
#### Private Key
```
SSLCertificateKeyFile "/usr/local/apache2/conf/server.key"
>>>
SSLCertificateKeyFile "/etc/letsencrypt/live/test.domain.com/privkey.pem"
```
* Edit chain key location. /etc/letsencrypt is a certificate home directory for certbot.
#### Chain Key (Optional)
```
SSLCertificateChainFile "/usr/local/apache2/conf/server-ca.crt"
>>>
SSLCertificateChainFile "/etc/letsencrypt/live/test.domain.com/chain.pem"
```
* If you need to serve multiple certificate for multiple server name, then add virtual host for your needs.

# Info
## Certbot
Location whare certificate stored from certbot is
*/etc/letsencrypt/archive/test.domain.com*
