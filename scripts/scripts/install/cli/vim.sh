#!/bin/bash
# Install vim

if [ "$(uname)" == "Darwin" ]; then
	brew install vim
else
    apt install -y vim
fi
