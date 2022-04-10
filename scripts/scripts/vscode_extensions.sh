#!/bin/bash

extensions=(
    "ms-vscode-remote.remote-wsl"
    "jdinhlife.gruvbox"
    "asvetliakov.vscode-neovim"
    "golang.Go"
    "BazelBuild.vscode-bazel"
    "earthly.earthfile-syntax-highlighting"
    "dbaeumer.vscode-eslint"
    "esbenp.prettier-vscode"
)

for ext in "${extensions[@]}"
do
    code --install-extension "$ext"
done
