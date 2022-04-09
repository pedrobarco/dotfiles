#!/bin/bash
# Install tree

if [ "$(uname)" == "Darwin" ]; then
	brew install tree
else
    apt install -y tree
fi
