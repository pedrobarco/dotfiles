#!/bin/bash

repo=$1
nth=$(($(echo "$REPOS" | grep -o "/" | wc -l) * 2 - 1))

if [[ -z $repo ]]; then
    repo=$(find $REPOS -type d \
        -exec test -e '{}/.git' \; -print -prune \
        | cut -d "/" -f$nth- \
        | fzy)
fi

selected_repo="$REPOS/$repo"
if [[ ! -d $selected_repo ]]; then
    exit 0
fi

session_name=$(echo "$repo" | sed "s/[\.|\/]/_/g")
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $session_name -c $selected_repo
    exit 0
fi

if ! tmux has-session -t=$session_name 2> /dev/null; then
    tmux new-session -ds $session_name -c $selected_repo
fi

tmux switch-client -t $session_name
