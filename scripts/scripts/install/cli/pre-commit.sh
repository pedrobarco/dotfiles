#!/bin/bash
# Install pre-commit

if [ "$(uname)" == "Darwin" ]; then
	brew install pre-commit
else
    pip install pre-commit
fi
