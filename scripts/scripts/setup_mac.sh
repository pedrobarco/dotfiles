#!/bin/bash

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install brew normal packages
brew install \
	zsh antibody \
	vim tmux \
	go \
	git git-flow tig lazygit stow  \
	tree watch htop wget telnet jq \
	yarn kubectl docker-compose \
	firefox vlc

# Install brew casks packages
brew install --cask docker vscodium thunderbird tor-browser

# Clone tmux tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
