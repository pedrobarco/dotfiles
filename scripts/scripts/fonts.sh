#!/bin/bash

fonts=(
    "UbuntuMono"
    "Meslo"
    "JetBrainsMono"
    "SpaceMono"
)

fdir="$HOME/.fonts"
mkdir -p "$fdir"

for font in "${fonts[@]}"
do
    curl -LO "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/$font.zip"
    unzip "$font.zip" -d "$fdir/$font"
    rm -rf "$font.zip"
done

if [ "$(uname)" == "Darwin" ]; then
    ddir="$HOME/Library/Fonts"
    cp -r $fdir/* $ddir
fi
