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
    "ripgrep"
    "fd"
    "fzy"

    # vpn
    "openconnect"

    # runtimes
    "go"
    "python3"
    "kubectl"
    "minikube"

    # development
    "tmux"
    "vim"
    "pre-commit"
    "bazelisk"

    # plugin managers
    "antibody"
    "tpm"
    "krew"
)

sdir=$(dirname $BASH_SOURCE[0])
for p in "${packages[@]}"
do
    . "$sdir/install/cli/$p.sh"
done
