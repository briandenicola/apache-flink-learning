#!/bin/bash

# this runs at Codespace creation - not part of pre-build
echo "$(date)    post-create start" >> ~/status

echo "$(date)    Download flink" >> ~/status
wget https://dlcdn.apache.org/flink/flink-1.15.0/flink-1.15.0-bin-scala_2.12.tgz
tar xzf flink-*.tgz
rm -f flink-*.tgz

echo "$(date)    Install Python Flink libraries" >> ~/status
python -m pip install apache-flink

# Install Task
echo "$(date)    Install Task.dev" >> ~/status
sudo sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin

echo "$(date)    post-create complete" >> ~/status