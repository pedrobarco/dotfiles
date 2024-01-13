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
# Completion {{{
# ==========
# Use modern completion system.
autoload -Uz +X compinit && compinit

# Execute code in the background to not affect the current session.
{
    # Compile zcompdump, if modified, to increase startup speed.
    zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
    if [[ -s "$zcompdump" ]] && \
       [[ (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
      zcompile -U "$zcompdump"
    fi
} &!

# }}}
# History {{{
# =======
# Keep 10000000 lines of history within the shell and save it to ~/.zsh_history:
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=$HISTSIZE

# Treat the '!' character specially during expansion.
setopt BANG_HIST
# Write the history file in the ":start:elapsed;command" format.
setopt EXTENDED_HISTORY
# Write to the history file immediately, not when the shell exits.
setopt INC_APPEND_HISTORY
# Share history between all sessions.
setopt NO_SHARE_HISTORY
# Expire duplicate entries first when trimming history.
setopt HIST_EXPIRE_DUPS_FIRST
# Don't record an entry that was just recorded again.
setopt HIST_IGNORE_DUPS
# Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_ALL_DUPS
# Do not display a line previously found.
setopt HIST_FIND_NO_DUPS
# Don't record an entry starting with a space.
setopt HIST_IGNORE_SPACE
# Don't write duplicate entries in the history file.
setopt HIST_SAVE_NO_DUPS
# Remove superfluous blanks before recording entry.
setopt HIST_REDUCE_BLANKS
# Don't execute immediately upon history expansion.
setopt HIST_VERIFY
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

antidote_dir="$HOME/.antidote"
if [[ "$(uname)" == "Darwin" ]]; then
  antidote_dir="$(brew --prefix)/opt/antidote/share/antidote"
fi

# source antidote
source "$antidote_dir/antidote.zsh"

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load
# }}}
# Prompt {{{
# ======
SPACESHIP_VI_MODE_INSERT=
SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  line_sep      # Line break
  char          # Prompt character
)
SPACESHIP_RPROMPT_ORDER=()
# }}}

# vim:foldmethod=marker:foldlevel=0:sts=4:ts=4:sw=4:et
