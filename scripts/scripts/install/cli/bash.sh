#!/bin/bash
# Install bash

if [ "$(uname)" == "Darwin" ]; then
	brew install bash
else
    apt install -y bash
fi
