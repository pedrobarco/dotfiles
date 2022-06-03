#!/bin/bash
# Install go

GO_VERSION=1.18.3

if [ "$(uname)" == "Darwin" ]; then
	brew install go
else
    cd "$(mktemp -d)"
    curl -fsSLO "https://go.dev/dl/go$GO_VERSION.linux-amd64.tar.gz"
    tar -C /usr/local -xzf "go$GO_VERSION.linux-amd64.tar.gz"
    cd -
fi
