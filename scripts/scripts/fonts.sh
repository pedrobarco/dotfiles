#!/bin/bash

custom_font_dir="../../fonts"
font_path=$([[ "$(uname)" == "Darwin" ]] \
    && echo ~/Library/Fonts \
    || echo ~/.fonts)

# Nerd fonts
echo "Installing nerd fonts..."
git clone https://github.com/ryanoasis/nerd-fonts --depth=1
cd nerd-fonts
./install.sh Hack
./install.sh Meslo

# Custom fonts
echo "Installing custom fonts..."
mkdir -p $font_path
cp $custom_font_dir/* $font_path
