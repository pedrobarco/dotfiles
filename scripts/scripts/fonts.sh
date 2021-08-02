#!/bin/bash

# Nerd fonts
echo "Installing nerd fonts..."
git clone https://github.com/ryanoasis/nerd-fonts --depth=1
cd nerd-fonts
./install.sh Hack
./install.sh Meslo
cd ..
rm -rf fonts

# Bitmap fonts
echo "Installing bitmap fonts..."
git clone https://github.com/Tecate/bitmap-fonts.git
sudo cp -avr bitmap-fonts/bitmap/ /usr/share/fonts
rm -rf bitmap-fonts

xset fp+ /user/share/fonts/bitmap
fc-cache -fv
