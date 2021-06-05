#!/bin/bash

# Powerline fonts
echo "Installing powerline patched fonts..."
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# Bitmap fonts
echo "Installing bitmap fonts..."
git clone https://github.com/Tecate/bitmap-fonts.git
sudo cp -avr bitmap-fonts/bitmap/ /usr/share/fonts
rm -rf bitmap-fonts

xset fp+ /user/share/fonts/bitmap
fc-cache -fv
