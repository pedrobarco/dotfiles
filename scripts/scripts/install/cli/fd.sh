#!/bin/bash
# Install fd

if [ "$(uname)" == "Darwin" ]; then
	brew install fd
else
    apt install -y fd-find
fi
