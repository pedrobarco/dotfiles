#!/bin/bash
# Install xclip

if [ "$(uname)" == "Linux" ]; then
    apt install -y xclip
fi
