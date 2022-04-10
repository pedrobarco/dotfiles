#!/bin/bash
# Install antibody - zsh plugin manager

if [ "$(uname)" == "Darwin" ]; then
	brew install antibody
else
	curl -sfL git.io/antibody | sh -s - -b /usr/local/bin
fi
