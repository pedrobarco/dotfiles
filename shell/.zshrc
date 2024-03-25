# Functions {{{
# =========
. $HOME/.functions
# }}}
# Environment {{{
# ===========
# Support 256 colors
export TERM=xterm-256color
export COLORTERM=truecolor

# Set a cache dir.
export ZSH_CACHE_DIR=$HOME/.zsh/cache

# Ensure editor is nvim
export EDITOR=nvim
export VISUAL=$EDITOR

# 10ms for key sequences
export KEYTIMEOUT=1

# }}}
# Aliases {{{
# =======
# Load our aliases.
if [ -f $HOME/.aliases ]; then
    . $HOME/.aliases
fi
# }}}
# Antidote {{{
# =======
# This makes the `zsh-nvm` plugin load lazily, and thus reduces the impact of the plugin on shell
# start-up time.
export NVM_LAZY_LOAD="true"
export NVM_LAZY_LOAD_EXTRA_COMMANDS=('nvim')

# source antidote
source $HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load
# }}}
# Prompt {{{
# ======
eval "$(starship init zsh)"
# }}}

# vim:foldmethod=marker:foldlevel=0:sts=4:ts=4:sw=4:et
