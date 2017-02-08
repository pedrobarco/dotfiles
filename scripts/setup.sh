#!/bin/bash

function makeLn {

	cd ~
	rm -rf scripts colors .Xresources .zshrc .zprofile .nanorc .weechat .config/dunst .config/i3 .config/mpv .config/ranger .i3blocks.conf .mpd .mpdscribble .ncmpcpp .vim .vimrc .vimperator .vimperatorrc .compton.conf .xinitrc 
	mkdir .weechat && mkdir .vim && mkdir .mpd && cd .mpd && mkdir playlists && touch mpd.db mpd.log mpd.pid mpdstate && cd ~

	ln -s ~/Dropbox/Dotfiles/scripts ~/
	ln -s ~/Dropbox/Dotfiles/colors ~/
	ln -s ~/Dropbox/Dotfiles/.weechat/weechat.conf ~/.weechat/
	ln -s ~/Dropbox/Dotfiles/.weechat/irc.conf ~/.weechat/
	ln -s ~/Dropbox/Dotfiles/.weechat/buffers.conf ~/.weechat/
	ln -s ~/Dropbox/Dotfiles/.config/i3 ~/.config/
	ln -s ~/Dropbox/Dotfiles/.config/dunst ~/.config/
	ln -s ~/Dropbox/Dotfiles/.config/ranger ~/.config/
	ln -s ~/Dropbox/Dotfiles/.config/mpv ~/.config/
	ln -s ~/Dropbox/Dotfiles/.xinitrc ~/
	ln -s ~/Dropbox/Dotfiles/.Xresources ~/
	ln -s ~/Dropbox/Dotfiles/.zprofile ~/
	ln -s ~/Dropbox/Dotfiles/.zshrc ~/
	ln -s ~/Dropbox/Dotfiles/.nanorc ~/
	ln -s ~/Dropbox/Dotfiles/.i3blocks.conf ~/
	ln -s ~/Dropbox/Dotfiles/.mpd/mpd.conf ~/.mpd/
	ln -s ~/Dropbox/Dotfiles/.mpdscribble ~/
	ln -s ~/Dropbox/Dotfiles/.ncmpcpp ~/
	ln -s ~/Dropbox/Dotfiles/.vim/autoload ~/.vim/
	ln -s ~/Dropbox/Dotfiles/.vim/colors ~/.vim/
	ln -s ~/Dropbox/Dotfiles/.vimrc ~/
	ln -s ~/Dropbox/Dotfiles/.vimperator ~/
	ln -s ~/Dropbox/Dotfiles/.vimperatorrc ~/
	ln -s ~/Dropbox/Dotfiles/.compton.conf ~/
}

function changeWp {

	nitrogen --set-zoom-fill --save ~/Dropbox/Dotfiles/Wallpapers/comfy_reading.jpg
}

function installZsh {

        cd ~
        git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
        chsh -s /bin/zsh
        mkdir -p ~/.oh-my-zsh/custom/themes/
        cd ~/.oh-my-zsh/custom/themes/
        wget https://raw.github.com/S1cK94/minimal/master/minimal.zsh-theme
        cd ~
}

function setupConfig {

        sudo cp scripts/urxvtclip /usr/lib/urxvt/perl/clipboard
        sudo cp ~/Dropbox/Dotfiles/fonts/*.otf ~/usr/share/fonts/OTF/
        unzip ~/Dropbox/Dotfiles/fonts/bitmap.zip -d Downloads/ 
        sudo cp -avr ~/Downloads/bitmap/ /usr/share/fonts
        fc-cache -fv
        rm -rf ~/Downloads/bitmap/
}

setupConfig
installZsh
makeLn
changeWp
