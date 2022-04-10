#!/bin/bash
# Install minikube

OS="$(uname | tr '[:upper:]' '[:lower:]')"
ARCH="$(uname -m | sed \
    -e 's/x86_64/amd64/' \
    -e 's/\(arm\)\(64\)\?.*/\1\2/' \
    -e 's/aarch64$/arm64/')"
MINIKUBE="minikube-${OS}-${ARCH}"

cd "$(mktemp -d)"
curl -LO "https://storage.googleapis.com/minikube/releases/latest/$MINIKUBE"
install $MINIKUBE /usr/local/bin/minikube
