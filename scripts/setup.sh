#!/bin/bash

	cd "$(dirname "$0")"
	cd ..
	DIR=$PWD

function makeLn {

	cd ~
	rm -rf scripts colors .Xresources .zshrc .zprofile .nanorc .weechat .config/dunst .config/i3 .config/mpv .config/ranger .i3blocks.conf .mpd .mpdscribble .ncmpcpp .vim .vimrc .vimperator .vimperatorrc .compton.conf .xinitrc 
	mkdir .weechat && mkdir .vim && mkdir .mpd && cd .mpd && mkdir playlists && touch mpd.db mpd.log mpd.pid mpdstate && cd ~

	ln -s $DIR/scripts ~/
	ln -s $DIR/colors ~/
	ln -s $DIR/.weechat/weechat.conf ~/.weechat/
	ln -s $DIR/.weechat/irc.conf ~/.weechat/
	ln -s $DIR/.weechat/buffers.conf ~/.weechat/
	ln -s $DIR/.config/i3 ~/.config/
	ln -s $DIR/.config/dunst ~/.config/
	ln -s $DIR/.config/ranger ~/.config/
	ln -s $DIR/.config/mpv ~/.config/
	ln -s $DIR/.xinitrc ~/
	ln -s $DIR/.Xresources ~/
	ln -s $DIR/.zprofile ~/
	ln -s $DIR/.zshrc ~/
	ln -s $DIR/.nanorc ~/
	ln -s $DIR/.i3blocks.conf ~/
	ln -s $DIR/.mpd/mpd.conf ~/.mpd/
	ln -s $DIR/.mpdscribble ~/
	ln -s $DIR/.ncmpcpp ~/
	ln -s $DIR/.vim/autoload ~/.vim/
	ln -s $DIR/.vim/colors ~/.vim/
	ln -s $DIR/.vimrc ~/
	ln -s $DIR/.vimperator ~/
	ln -s $DIR/.vimperatorrc ~/
	ln -s $DIR/.compton.conf ~/
}

function changeWp {

	nitrogen --set-zoom-fill --save $DIR/Wallpapers/comfy_reading.jpg
}

function installZsh {

        cd ~
        git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
        chsh -s /bin/zsh
}

function setupConfig {

        sudo cp $DIR/scripts/clipboard /usr/lib/urxvt/perl/
        sudo cp $DIR/fonts/* ~/usr/share/fonts/
        mkdir -p ~/.fonts/
        unzip $DIR/fonts/bitmap.zip -d Downloads/ 
        sudo cp -avr ~/Downloads/bitmap/ .fonts/
        fc-cache -fv
        rm -rf ~/Downloads/bitmap/
}

# setupConfig
installZsh
makeLn
# changeWp
