#!/bin/bash
# Install antibody - zsh plugin manager

if [ "$(uname)" == "Darwin" ]; then
	brew install antidote
else
	git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
fi
