#!/bin/bash
# Install git

if [ "$(uname)" == "Darwin" ]; then
	brew install git
else
    apt install -y git
fi
