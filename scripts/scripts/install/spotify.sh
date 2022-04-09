#!/bin/bash
# Install spotify

if [ "$(uname)" == "Darwin" ]; then
	brew install --cask spotify
else
	curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg \
        | sudo apt-key add -
    echo "deb http://repository.spotify.com stable non-free" \
        | sudo tee /etc/apt/sources.list.d/spotify.list
	apt update
	apt install -y spotify-client
fi