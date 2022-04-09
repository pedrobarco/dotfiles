#!/bin/bash
# Install python3

if [ "$(uname)" == "Darwin" ]; then
	brew install python
else
    apt install -y python3 python3-pip
fi
