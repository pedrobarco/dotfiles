#!/bin/bash

echo "Installing tmux..."
apt install -y tmux

echo "Installing tmux plugin manager..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm