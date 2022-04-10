#!/bin/bash
# Install openconnect

if [ "$(uname)" == "Darwin" ]; then
	brew install openconnect
else
    apt install -y openconnect
fi
