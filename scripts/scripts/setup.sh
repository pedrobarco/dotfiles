#!/bin/bash

# Install essential packages
echo "Installing essential packages..."
apt install -y git vim tmux stow

# Run other scripts
echo "Running setup scripts..."
sh ./zsh.sh
sh ./hosts.sh
sh ./fonts.sh
