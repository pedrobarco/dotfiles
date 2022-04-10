#!/bin/bash
# Install zip

if [ "$(uname)" == "Darwin" ]; then
	brew install zip
else
    apt install -y zip
fi
