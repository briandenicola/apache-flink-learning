# Overview

This repository is intended as a place of learning flink utilizing CodeSpaces and DevContainers
_More details pending_

# Quickstart

## Stand-alone Cluster
```bash
cd flink*
./bin/start-cluster.sh
./bin/flink run examples/streaming/WordCount.jar
tail log/flink-*-taskexecutor-*.out
```

## Kubernetes Cluster
```bash
kubectl create sa flink
kubectl create rolebinding flink-operator --clusterrole=flink-operator --serviceaccount=default:flink
kubectl create -f https://raw.githubusercontent.com/apache/flink-kubernetes-operator/release-1.0.1/examples/basic.yaml
kubectl get pods
kubectl logs basic-example-*
```