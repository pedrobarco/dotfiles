#!/bin/bash

# TODO: clone git repo
# TODO: detect platform and run setup script
# TODO: clone vim-plug automatically

stow --restow -t $HOME shell
stow --restow -t $HOME vim
stow --restow -t $HOME nvim
stow --restow -t $HOME tmux
stow --restow -t $HOME --no-folding code
