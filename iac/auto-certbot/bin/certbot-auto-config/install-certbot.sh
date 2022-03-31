#!/bin/sh
# Install system dependencies
sudo yum install python3 augeas-libs -y

# Set up a Python virtual environment
sudo python3 -m venv /opt/certbot/
sudo /opt/certbot/bin/pip3 install --upgrade pip

# Install Certbot
sudo /opt/certbot/bin/pip3 install certbot certbot-apache

# Prepare the Certbot command
sudo ln -s /opt/certbot/bin/certbot /usr/bin/certbot