#!/bin/bash

# Install zsh
echo "Installing zsh..."
apt install -y zsh

# Install antibody
echo "Installing antibody - zsh plugin manager..."
curl -sfL git.io/antibody | sh -s - -b /usr/local/bin

