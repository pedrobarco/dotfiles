#!/bin/bash
# Install wget

if [ "$(uname)" == "Darwin" ]; then
	brew install wget
else
    apt install -y wget
fi
