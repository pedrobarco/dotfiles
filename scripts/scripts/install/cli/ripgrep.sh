#!/bin/bash
# Install ripgrep

if [ "$(uname)" == "Darwin" ]; then
	brew install ripgrep
else
    apt install -y ripgrep
fi
