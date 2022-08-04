# Overview

This repository is intended as a place of learning flink utilizing CodeSpaces and DevContainers
_More details pending_

# Quickstart

## Stand-alone Cluster
```bash
flink*/bin/start-cluster.sh
flink*/bin/flink run flink*/examples/streaming/WordCount.jar
tail flink*/log/flink-*-taskexecutor-*.out

python ./src/basic_operations.py

python ./src/word_count.py --input ./data/livy.txt --output ./data/livy_word_count
cat ./data/livy_word_count/$(date)/prefix-*

flink*/./bin/stop-cluster.sh
```

## Minikube Kubernetes Cluster
```bash
kubectl create sa flink
kubectl create rolebinding flink-operator --clusterrole=flink-operator --serviceaccount=default:flink
kubectl create -f ./manifests/basic_operations.yaml
kubectl get pods
kubectl port-forward svc/basic-example-rest 8081 &
kubectl logs -f deploy/basic-example
```

## AKS Kubernetes Cluster
```
 az login --scope https://graph.microsoft.com//.default

cd infrastructure
terraform init
terraform apply -auto-approve

export RG=`terraform output AKS_RESOURCE_GROUP | tr -d \"
export AKS=`terraform output AKS_CLUSTER_NAME | tr -d \"`

az aks install-cli
az aks get-credentials -g ${RG} -n ${AKS}
kubelogin convert-kubeconfig -l azurecli

export ACR_NAME=`terraform output ACR_NAME | tr -d \"`
az acr login -n ${ACR_NAME}

cd ../src; 
docker build -t ${ACR_NAME}/python_order_demo:latest .
docker push ${ACR_NAME}/python_order_demo:latest

cd ../manifests
envsubst < ./python-example.tmpl | kubectl apply -f-
```