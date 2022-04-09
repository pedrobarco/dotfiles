#!/bin/bash
# Install watch

if [ "$(uname)" == "Darwin" ]; then
	brew install watch
else
    apt install -y watch
fi
