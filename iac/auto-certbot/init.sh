#!/usr/bin/env sh

# Install system dependencies
sudo yum install python3 augeas-libs -y

# Set up a Python virtual environment
sudo python3 -m venv /opt/certbot/
sudo /opt/certbot/bin/pip3 install --upgrade pip

# Install Certbot
sudo /opt/certbot/bin/pip3 install certbot certbot-apache

# Prepare the Certbot command
sudo ln -s /opt/certbot/bin/certbot /usr/bin/certbot

# Choose how you'd like to run Certbot
## Either get and install your certificates...
sudo certbot --apache
## just get a certificate
# sudo certbot certonly --apache

# Set up automatic renewal
echo "0 0,12 * * * root /opt/certbot/bin/python -c 'import random; import time; time.sleep(random.random() * 3600)' && sudo certbot renew -q" | sudo tee -a /etc/crontab > /dev/null

# Rollback
sudo rm -rf /opt/certbot