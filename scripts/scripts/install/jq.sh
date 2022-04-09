#!/bin/bash
# Install jq

if [ "$(uname)" == "Darwin" ]; then
	brew install jq
else
    apt install -y jq
fi
