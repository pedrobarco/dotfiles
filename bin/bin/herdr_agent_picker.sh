#!/bin/bash

herdr=${HERDR_BIN_PATH:-herdr}

selected=$("$herdr" agent list 2>/dev/null \
    | jq -r '.result.agents[]
        | "\(.pane_id)\t\(.agent_status)\t\(.workspace_id)\t\(.agent)"' \
    | column -t -s $'\t' \
    | fzy)

if [[ -z $selected ]]; then
    exit 0
fi

pane_id=$(echo "$selected" | awk '{print $1}')
if [[ -n $pane_id ]]; then
    "$herdr" agent focus "$pane_id"
fi
