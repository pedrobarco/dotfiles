#!/bin/bash

fonts=(
    "UbuntuMono"
    "Meslo"
    "JetBrainsMono"
)

fdir="$HOME/.fonts"
for font in "${fonts[@]}"
do
    curl -LO "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.1/$font.zip"
    unzip "$font.zip" -d "$fdir/$font"
    rm -rf "$font.zip"
done

if [ "$(uname)" == "Darwin" ]; then
    ln -s $fdir "~/Library/Fonts/Custom"
fi
