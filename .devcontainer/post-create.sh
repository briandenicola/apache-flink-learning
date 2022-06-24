#!/bin/bash

# this runs at Codespace creation - not part of pre-build
echo "$(date)    post-create start" >> ~/status

echo "$(date)    Create Flink minikube cluster" >> ~/status
minikube start --kubernetes-version=v1.21.5 --force
kubectl create -f https://github.com/jetstack/cert-manager/releases/download/v1.7.1/cert-manager.yaml
helm repo add flink-operator-repo https://downloads.apache.org/flink/flink-kubernetes-operator-1.0.0/
helm install flink-kubernetes-operator flink-operator-repo/flink-kubernetes-operator
kubectl create -f https://raw.githubusercontent.com/apache/flink-kubernetes-operator/release-1.0/examples/basic.yaml
kubectl get pods
#kubectl port-forward svc/basic-example-rest 8081 

echo "$(date)    Create stand-alone Flink cluster" >> ~/status
wget https://dlcdn.apache.org/flink/flink-1.15.0/flink-1.15.0-bin-scala_2.12.tgz
tar xzf flink-*.tgz
rm -f flink-*.tgz
cd flink*
./bin/start-cluster.sh

#./bin/flink run examples/streaming/WordCount.jar
#tail log/flink-*-taskexecutor-*.out

echo "$(date)    post-create complete" >> ~/status