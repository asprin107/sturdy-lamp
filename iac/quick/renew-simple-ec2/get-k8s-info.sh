#!/bin/sh

SERVER_KEY_FILE=""
SERVER_USER="ec2-user"
SERVER_IP=""

OUTPUT_DIR="./k8s-config-info"
OUTPUT_KUBE_DIR="kube"
OUTPUT_MINIKUBE_DIR="minikube"

mkdir -p ${OUTPUT_DIR}/${OUTPUT_KUBE_DIR}
mkdir -p ${OUTPUT_DIR}/${OUTPUT_MINIKUBE_DIR}

# kubectl config
scp -i ${SERVER_KEY_FILE} ${SERVER_USER}@${SERVER_IP}:~/.kube/config ${OUTPUT_DIR}/${OUTPUT_KUBE_DIR}

# minikube ca cert
scp -i ${SERVER_KEY_FILE} ${SERVER_USER}@${SERVER_IP}:~/.minikube/ca.crt ${OUTPUT_DIR}/${OUTPUT_MINIKUBE_DIR}
# minikube client cert for access (key, cert)
scp -i ${SERVER_KEY_FILE} -r ${SERVER_USER}@${SERVER_IP}:~/.minikube/profiles/minikube ${OUTPUT_DIR}/${OUTPUT_MINIKUBE_DIR}