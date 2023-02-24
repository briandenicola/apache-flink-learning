#!/bin/bash

# this runs each time the container starts

echo "$(date)    post-start start" >> ~/status

#echo "$(date)    Create Flink minikube cluster" >> ~/status
#minikube start --kubernetes-version=v1.24.35 --force

echo "$(date)    post-start complete" >> ~/status