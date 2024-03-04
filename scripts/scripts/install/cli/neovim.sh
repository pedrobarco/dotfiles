#!/bin/bash
# Install neovim

NVIM_VERSION=0.9.5

if [ "$(uname)" == "Darwin" ]; then
	brew install neovim
else
    cd "$(mktemp -d)"
    curl -fsSLO "https://github.com/neovim/neovim/releases/download/v$NVIM_VERSION/nvim-linux64.tar.gz"
    tar -xzf "nvim-linux64.tar.gz" -C /opt/
    cd -

    ln -s /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim
fi
