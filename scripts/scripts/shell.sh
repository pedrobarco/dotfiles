#!/bin/bash

echo "Installing zsh..."
apt install -y zsh

echo "Installing antibody - zsh plugin manager..."
curl -sfL git.io/antibody | sh -s - -b /usr/local/bin

