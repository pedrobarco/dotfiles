#!/bin/bash

repo=$1
nth=$(($(echo "$REPOS" | grep -o "/" | wc -l) * 2 - 1))
herdr=${HERDR_BIN_PATH:-herdr}

if [[ -z $repo ]]; then
    repo=$(find $REPOS -maxdepth 3 -type d \
        -exec test -e '{}/.git' \; -print -prune \
        | cut -d "/" -f$nth- \
        | fzy)
fi

selected_repo="$REPOS/$repo"
if [[ ! -d $selected_repo ]]; then
    exit 0
fi

workspace_id=$("$herdr" workspace list 2>/dev/null \
    | jq -r --arg label "$repo" \
        '.result.workspaces[] | select(.label == $label) | .workspace_id' \
    | head -n1)

if [[ -n $workspace_id ]]; then
    "$herdr" workspace focus "$workspace_id"
else
    "$herdr" workspace create --cwd "$selected_repo" --label "$repo" --focus
fi
