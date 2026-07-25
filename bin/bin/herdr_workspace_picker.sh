#!/bin/bash

herdr=${HERDR_BIN_PATH:-herdr}

selected=$("$herdr" workspace list 2>/dev/null \
    | jq -r '.result.workspaces[]
        | "\(.workspace_id)\t\(.number)\t\(.agent_status)\t\(.label)"' \
    | column -t -s $'\t' \
    | fzy)

if [[ -z $selected ]]; then
    exit 0
fi

workspace_id=$(echo "$selected" | awk '{print $1}')
if [[ -n $workspace_id ]]; then
    "$herdr" workspace focus "$workspace_id"
fi
