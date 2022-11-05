#!/bin/bash

fonts=(
    "UbuntuMono"
    "Meslo"
    "JetBrainsMono"
)

fdir="$HOME/.fonts"
for font in "${fonts[@]}"
do
    curl -LO "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/$font.zip"
    unzip "$font.zip" -d "$fdir/$font"
    rm -rf "$font.zip"
done

if [ "$(uname)" == "Darwin" ]; then
    ln -s $fdir "~/Library/Fonts/Custom"
fi
