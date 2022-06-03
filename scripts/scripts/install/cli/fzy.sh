#!/bin/bash
# Install fzy

if [ "$(uname)" == "Darwin" ]; then
	brew install fzy
else
    apt install -y fzy
fi
