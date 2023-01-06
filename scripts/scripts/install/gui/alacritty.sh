#!/bin/bash
# Install alacritty

if [ "$(uname)" == "Darwin" ]; then
	brew install --cask alacritty
else
    echo "alacritty: no setup script found"
fi
