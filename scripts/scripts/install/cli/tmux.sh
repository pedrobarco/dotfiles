#!/bin/bash
# Install tmux

if [ "$(uname)" == "Darwin" ]; then
	brew install tmux
else
    apt install -y tmux
fi
