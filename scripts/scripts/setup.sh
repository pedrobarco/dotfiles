#!/bin/bash

packages=(
    # core
    "bash"
    "zsh"
    "git"
    "coreutils"
    "gpg"
    "curl"
    "wget"
    "zip"

    # utilities
    "htop"
    "telnet"
    "xclip"
    "stow"
    "jq"
    "tree"
    "watch"

    # vpn
    "openconnect"

    # runtimes
    "go"
    "python3"
    "bazelisk"
    "kubectl"

    # development
    "tmux"
    "vim"

    # plugins
    "antibody"
    "pre-commit"
    "tpm"
)

sdir=$(dirname $BASH_SOURCE[0])
for p in "${packages[@]}"
do
    . "$sdir/install/cli/$p.sh"
done
