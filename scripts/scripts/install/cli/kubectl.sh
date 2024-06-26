#!/bin/bash
# Install kubectl

if [ "$(uname)" == "Darwin" ]; then
	brew install kubectl
else
    cd "$(mktemp -d)"
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    cd -
fi
