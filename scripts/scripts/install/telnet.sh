#!/bin/bash
# Install telnet

if [ "$(uname)" == "Darwin" ]; then
	brew install telnet
else
    apt install -y telnet
fi
