#!/bin/bash

# this runs each time the container starts

echo "$(date)    post-start start" >> ~/status

echo "$(date)    Setting bashrc" >> ~/status

echo . /etc/bash_completion >> ~/.bashrc
echo alias k=kubectl >> ~/.bashrc
echo 'source <(kubectl completion bash)' >> ~/.bashrc 
echo complete -F __start_kubectl k >> ~/.bashrc

echo "$(date)    Create Flink minikube cluster" >> ~/status
minikube start --kubernetes-version=v1.21.5 --force

echo "$(date)    post-start complete" >> ~/status