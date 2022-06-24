#!/bin/bash

# this runs each time the container starts

echo "$(date)    post-start start" >> ~/status

alias k=kubectl
source <(kubectl completion bash)
complete -F __start_kubectl k

echo "$(date)    post-start complete" >> ~/status