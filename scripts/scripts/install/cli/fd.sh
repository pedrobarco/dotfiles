#!/bin/bash
# Install fd

if [ "$(uname)" == "Darwin" ]; then
	brew install fd
else
    apt install -y fd-find
    ln -s $(which fdfind) $HOME/.local/bin/fd
fi
