#!/bin/bash
# Install coreutils - GNU File, Shell, and Text utilities

if [ "$(uname)" == "Darwin" ]; then
	brew install coreutils
fi
