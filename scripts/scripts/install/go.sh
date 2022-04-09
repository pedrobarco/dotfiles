#!/bin/bash
# Install go

if [ "$(uname)" == "Darwin" ]; then
	brew install go
else
    apt install -y golang-go
fi
