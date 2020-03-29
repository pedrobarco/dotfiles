#          _
#    _____| |_  _ _ __
#  _|_ (_-< ' \| '_/ _|
# (_)__/__/_||_|_| \__|

# Colors {{{
# ======
if [ -t 1 ]; then
    BLACK="$(tput setaf 0)"
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    MAGENTA="$(tput setaf 5)"
    CYAN="$(tput setaf 6)"
    WHITE="$(tput setaf 7)"
    BRIGHT_BLACK="$(tput setaf 8)"
    BRIGHT_RED="$(tput setaf 9)"
    BRIGHT_GREEN="$(tput setaf 10)"
    BRIGHT_YELLOW="$(tput setaf 11)"
    BRIGHT_BLUE="$(tput setaf 12)"
    BRIGHT_MAGENTA="$(tput setaf 13)"
    BRIGHT_CYAN="$(tput setaf 14)"
    BRIGHT_WHITE="$(tput setaf 15)"
    BOLD="$(tput bold)"
    UNDERLINE="$(tput sgr 0 1)"
    INVERT="$(tput sgr 1 0)"
    RESET="$(tput sgr0)"
else
    BLACK=""
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    MAGENTA=""
    CYAN=""
    WHITE=""
    BRIGHT_BLACK=""
    BRIGHT_RED=""
    BRIGHT_GREEN=""
    BRIGHT_YELLOW=""
    BRIGHT_BLUE=""
    BRIGHT_MAGENTA=""
    BRIGHT_CYAN=""
    BRIGHT_WHITE=""
    BOLD=""
    UNDERLINE=""
    INVERT=""
    RESET=""
fi
# }}}
# Functions {{{
# =========
. $HOME/.functions
# }}}
# Environment {{{
# ===========
# Set a cache dir.
export ZSH_CACHE_DIR=$HOME/.zsh/cache

# Ensure editor is Vim
export EDITOR=vim
export VISUAL=$EDITOR

# 10ms for key sequences
export KEYTIMEOUT=1

# Ensure Vim and others use 256 colours.
if [[ "$TERM" != "screen"* && "$TERM" != "tmux"* ]]; then
    export TERM=rxvt-unicode-256color
fi
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

# Load colour variables.
eval "$(dircolors -b)"

# Description for options that are not described by completion functions.
zstyle ':completion:*' auto-description "${BRIGHT_BLACK}Specify %d${RESET}"
# Enable corrections, expansions, completions and approximate completers.
zstyle ':completion:*' completer _expand _complete _correct _approximate
# Display 'Completing $section' between types of matches, ie. 'Completing external command'
zstyle ':completion:*' format "${BRIGHT_BLACK}Completing %d${RESET}"
# Display all types of matches separately (same types as above).
zstyle ':completion:*' group-name ''
# Use menu selection if there are more than two matches (or when not on screen).
zstyle ':completion:*' menu select=2
zstyle ':completion:*' menu select=long
# Set colour specifications.
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
# Prompt to show when completions don't fit on screen.
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
# Define matcher specifications.
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' \
    'r:|[._-]=* r:|=* l:|=*'
# Don't use legacy `compctl`.
zstyle ':completion:*' use-compctl false
# Show command descriptions.
zstyle ':completion:*' verbose true
# Extra patterns to accept.
zstyle ':completion:*' accept-exact '*(N)'
# Enable caching.
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $ZSH_CACHE_DIR

# Extra settings for processes.
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
# }}}
# History {{{
# =======
# Keep 10000000 lines of history within the shell and save it to ~/.zsh_history:
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000

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
# Antibody {{{
# =======
# This makes the `zsh-nvm` plugin load lazily, and thus reduces the impact of the plugin on shell
# start-up time.
export NVM_LAZY_LOAD="true"

if _has antibody; then
    # If plugins have not been downloaded, then download and static load in future.
    if [[ ! -e "$HOME/.zsh_plugins.sh" ]]; then
        # Fetch plugins.
        antibody bundle < "$HOME/.zsh_plugins.txt" > "$HOME/.zsh_plugins.sh"
    fi

    # Load plugins.
    . "$HOME/.zsh_plugins.sh"
fi
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
SPACESHIP_RPROMPT_ORDER=(
vi_mode
)
# }}}

# vim:foldmethod=marker:foldlevel=0:sts=4:ts=4:sw=4:et
