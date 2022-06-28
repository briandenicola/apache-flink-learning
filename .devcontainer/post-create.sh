#!/bin/bash

# this runs at Codespace creation - not part of pre-build
echo "$(date)    post-create start" >> ~/status

echo "$(date)    Create Flink minikube cluster" >> ~/status
minikube start --kubernetes-version=v1.21.5 --force
kubectl create -f https://github.com/jetstack/cert-manager/releases/download/v1.7.1/cert-manager.yaml
helm repo add flink-operator-repo https://downloads.apache.org/flink/flink-kubernetes-operator-0.1.0/
helm repo update
helm install flink-kubernetes-operator flink-operator-repo/flink-kubernetes-operator --namespace flink --create-namespace
kubectl create -f https://raw.githubusercontent.com/apache/flink-kubernetes-operator/release-1.0/examples/basic.yaml

echo "$(date)    Download flink" >> ~/status
wget https://dlcdn.apache.org/flink/flink-1.15.0/flink-1.15.0-bin-scala_2.12.tgz
tar xzf flink-*.tgz
rm -f flink-*.tgz

echo "$(date)    post-create complete" >> ~/status