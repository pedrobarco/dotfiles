#!/bin/bash
# Install xclip

if [ "$(uname)" == "Darwin" ]; then
else
    apt install -y xclip
fi
