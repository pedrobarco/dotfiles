#!/bin/bash
# Install syncthing

if [ "$(uname)" == "Darwin" ]; then
    brew install syncthing
else
    curl -fsSLo /usr/share/keyrings/syncthing-archive-keyring.gpg \
        https://syncthing.net/release-key.gpg
    echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] \
        https://apt.syncthing.net/ syncthing stable" \
        | tee /etc/apt/sources.list.d/syncthing.list
    apt update
    apt install -y syncthing
fi
