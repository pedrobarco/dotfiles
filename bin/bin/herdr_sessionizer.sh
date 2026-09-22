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

# bail on empty selection (e.g. fzy cancelled with esc); an empty repo would
# otherwise resolve $selected_repo to $REPOS itself and create a blank workspace
if [[ -z $repo ]]; then
    exit 0
fi

selected_repo="$REPOS/$repo"
if [[ ! -d $selected_repo ]]; then
    exit 0
fi
selected_repo=$(cd "$selected_repo" && pwd -P)

# A Worktrunk (or git) worktree shares the parent repo. Open it through herdr's
# worktree API so the sidebar nests it under that repo and shows the branch.
# workspace create would record a standalone space named after the directory.
if git_dir=$(git -C "$selected_repo" rev-parse --git-dir 2>/dev/null) \
    && git_common=$(git -C "$selected_repo" rev-parse --git-common-dir 2>/dev/null); then
    git_dir=$(cd "$selected_repo" && cd "$git_dir" && pwd -P)
    git_common=$(cd "$selected_repo" && cd "$git_common" && pwd -P)
    if [[ $git_dir != "$git_common" ]]; then
        worktree_json=$("$herdr" worktree list --cwd "$selected_repo" 2>/dev/null) || exit 1
        repo_root=$(printf '%s\n' "$worktree_json" | jq -r '.result.source.repo_root // empty')
        if [[ -z $repo_root || ! -d $repo_root ]]; then
            printf 'herdr_sessionizer: could not resolve the parent repo for %s\n' "$selected_repo" >&2
            exit 1
        fi
        "$herdr" worktree open --cwd "$repo_root" --path "$selected_repo" --focus
        exit
    fi
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
