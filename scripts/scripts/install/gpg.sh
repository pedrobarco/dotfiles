#!/bin/bash
# Install gpg

if [ "$(uname)" == "Darwin" ]; then
	brew install \
        ca-certificates  \
        gnupg
else
    apt install -y \
        apt-transport-https \
        ca-certificates \
        gnupg \
        lsb-release
fi
