# ███████╗███████╗██╗  ██╗██████╗  ██████╗
# ╚══███╔╝██╔════╝██║  ██║██╔══██╗██╔════╝
#   ███╔╝ ███████╗███████║██████╔╝██║
#  ███╔╝  ╚════██║██╔══██║██╔══██╗██║
# ███████╗███████║██║  ██║██║  ██║╚██████╗
# ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝



export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussel"

plugins=(git)

source $ZSH/oh-my-zsh.sh

alias dotfiles='cd ; cd Dropbox\/Dotfiles'
alias -g sigma='ist181905@sigma.ist.utl.pt'

alias ls="ls -a --color=auto"

echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc


