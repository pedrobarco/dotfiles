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


# Java path
export JAVA_HOME="/usr/lib/jvm/java-8-oracle"

ZSH_THEME="robbyrussell"

# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git vim tmux extract zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

alias -g sigma='ist181905@sigma.ist.utl.pt'

