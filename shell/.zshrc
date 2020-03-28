#          _
#    _____| |_  _ _ __
#  _|_ (_-< ' \| '_/ _|
# (_)__/__/_||_|_| \__|

# Path to oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Support 256 color term
export TERM=rxvt-unicode-256color

# Set default text editor
export VISUAL=vim
export EDITOR=$VISUAL
# Kills lag
export KEYTIMEOUT=1

ZSH_THEME="robbyrussell"

# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git vi-mode tmux extract zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

alias -g sigma='ist181905@sigma.ist.utl.pt'

export NVM_DIR=~/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

