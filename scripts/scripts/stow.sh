#!/bin/bash

# TODO: clone git repo
# TODO: detect platform and run setup script
# TODO: clone vim-plug automatically

# DONE: use stow to symlink
stow shell
stow vim
stow --no-folding nvim
stow --no-folding code
stow tmux
