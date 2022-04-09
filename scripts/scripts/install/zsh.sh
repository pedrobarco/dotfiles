#!/bin/bash
# Install zsh

if [ "$(uname)" == "Darwin" ]; then
	brew install zsh
else
    apt install -y zsh
fi
