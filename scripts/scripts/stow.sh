#!/bin/bash

# TODO: clone git repo
# TODO: detect platform and run setup script
# TODO: clone vim-plug automatically

# DONE: use stow to symlink
stow shell -t $HOME
stow vim -t $HOME
stow --no-folding nvim -t $HOME
stow --no-folding code -t $HOME
stow tmux -t $HOME
