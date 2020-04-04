#!/bin/bash

# Install essential packages
echo "Installing essential packages..."
apt install -y git vim stow

# Run other scripts
echo "Running setup scripts..."
sh ./shell.sh
sh ./tmux.sh
sh ./hosts.sh
sh ./fonts.sh
