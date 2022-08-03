#!/bin/bash

# this runs at Codespace creation - not part of pre-build
echo "$(date)    post-create start" >> ~/status

echo "$(date)    Create Flink minikube cluster" >> ~/status
minikube start --kubernetes-version=v1.24.3 --force

helm repo add flink-operator-repo https://downloads.apache.org/flink/flink-kubernetes-operator-1.1.0
helm repo add jetstack https://charts.jetstack.io
helm repo update

helm upgrade -i cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.8.2  --set installCRDs=true --wait
helm upgrade -i flink-kubernetes-operator flink-operator-repo/flink-kubernetes-operator --namespace flink --create-namespace

echo "$(date)    Download flink" >> ~/status
wget https://dlcdn.apache.org/flink/flink-1.15.0/flink-1.15.0-bin-scala_2.12.tgz
tar xzf flink-*.tgz
rm -f flink-*.tgz

echo "$(date)    Install Python Flink libraries" >> ~/status
python -m pip install apache-flink

echo "$(date)    post-create complete" >> ~/status