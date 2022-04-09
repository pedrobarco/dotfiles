#!/bin/bash

# Install apt packages
apt install -y \
	vlc thunderbird \
	openvpn openconnect \
	ffmpeg v4l-utils v4l2loopback-dkms

# TODO: sudo dpkg-reconfigure resolvconf
# TODO: nvm setup (install --lts)
# TODO: nvim setup (install nvim pip3 + npm modules)
# TODO: nvim setup lsp
# yarn global add typescript-language-server typescript

# Change default shell to zsh
chsh -s $(which zsh)

# Mkdir zsh cache
mkdir -p $HOME/.zsh/cache/
