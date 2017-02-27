# ███████╗███████╗██╗  ██╗██████╗  ██████╗
# ╚══███╔╝██╔════╝██║  ██║██╔══██╗██╔════╝
#   ███╔╝ ███████╗███████║██████╔╝██║
#  ███╔╝  ╚════██║██╔══██║██╔══██╗██║
# ███████╗███████║██║  ██║██║  ██║╚██████╗
# ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝



export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

alias dotfiles='cd ; cd Dropbox\/Dotfiles'
alias -g sigma='ist181905@sigma.ist.utl.pt'

alias ls="ls -a --color=auto"

echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc


source /home/barco/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/barco/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/barco/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/barco/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
