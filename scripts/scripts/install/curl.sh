#!/bin/bash
# Install curl

if [ "$(uname)" == "Darwin" ]; then
	brew install curl
else
    apt install -y curl
fi
