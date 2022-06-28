#!/bin/bash

# this runs each time the container starts

echo "$(date)    post-start start" >> ~/status

echo . /etc/bash_completion >> ~/.bashrc
echo alias k=kubectl >> ~/.bashrc
echo 'source <(kubectl completion bash)' >> ~/.bashrc 
echo complete -F __start_kubectl k >> ~/.bashrc

echo "$(date)    Create Flink minikube cluster" >> ~/status
minikube start --kubernetes-version=v1.21.5 --force
#kubectl create sa flink
#kubectl create rolebinding flink-operator --clusterrole=flink-operator --serviceaccount=default:flink
#kubectl create -f https://raw.githubusercontent.com/apache/flink-kubernetes-operator/release-1.0.1/examples/basic.yaml
#kubectl get pods
#kubectl port-forward svc/basic-example-rest 8081 

#echo "$(date)    Create stand-alone Flink cluster" >> ~/status
#cd flink*
#./bin/start-cluster.sh
#./bin/flink run examples/streaming/WordCount.jar
#tail log/flink-*-taskexecutor-*.out

echo "$(date)    post-start complete" >> ~/status