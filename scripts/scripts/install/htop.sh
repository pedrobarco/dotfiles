#!/bin/bash
# Install htop

if [ "$(uname)" == "Darwin" ]; then
	brew install htop
else
    apt install -y htop
fi
