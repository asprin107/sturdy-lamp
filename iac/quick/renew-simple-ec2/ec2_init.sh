#!/bin/bash

# KUBECTL
## Download kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
## Varify kubectl
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
# Install kubectl
chmod +x kubectl
mv ./kubectl /usr/local/bin/kubectl


# DOCKER
## Install Docker
sudo yum update -y
sudo yum install docker -y
## Grant Docker to user
sudo usermod -aG docker ec2-user
newgrp docker
## Docker daemon setting
sudo systemctl enable docker
sudo systemctl start docker


# MINIKUBE
## Download minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
## Install minikube
sudo install minikube-linux-amd64 /usr/bin/minikube
su ec2-user -c 'minikube start'