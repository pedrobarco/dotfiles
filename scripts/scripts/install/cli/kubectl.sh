#!/bin/bash
# Install kubectl

if [ "$(uname)" == "Darwin" ]; then
	brew install kubectl
else
    curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg \
        https://packages.cloud.google.com/apt/doc/apt-key.gpg
    echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] \
        https://apt.kubernetes.io/ kubernetes-xenial main" \
        | tee /etc/apt/sources.list.d/kubernetes.list
    apt update
    apt install -y kubectl
fi
