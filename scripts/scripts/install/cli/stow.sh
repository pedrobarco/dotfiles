#!/bin/bash
# Install stow

if [ "$(uname)" == "Darwin" ]; then
	brew install stow
else
    apt install -y stow
fi
