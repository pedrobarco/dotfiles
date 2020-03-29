#!/bin/bash

git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

git clone https://github.com/Tecate/bitmap-fonts.git
sudo cp -avr bitmap-fonts/bitmap/ /usr/share/fonts
xset fp+ /user/share/fonts/bitmap
fc-cache -fv

rm -rf bitmap-fonts