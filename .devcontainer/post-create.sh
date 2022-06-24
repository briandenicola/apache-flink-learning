#!/bin/bash

# this runs at Codespace creation - not part of pre-build
echo "$(date)    post-create start" >> ~/status

minikube start --kubernetes-version=v1.21.5 --force
kubectl create -f https://github.com/jetstack/cert-manager/releases/download/v1.7.1/cert-manager.yaml
helm repo add flink-operator-repo https://downloads.apache.org/flink/flink-kubernetes-operator-1.0.0/
helm install flink-kubernetes-operator flink-operator-repo/flink-kubernetes-operator
kubectl get pods

echo "$(date)    post-create complete" >> ~/status