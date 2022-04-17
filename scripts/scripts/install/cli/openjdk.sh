#!/bin/bash
# Install openjdk

if [ "$(uname)" == "Darwin" ]; then
    brew install openjdk@11
else
    apt install -y openjdk-11-jdk
fi
