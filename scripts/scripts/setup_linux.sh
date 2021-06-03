#!/bin/bash

# Install apt packages
apt install -y \
	apt-transport-https ca-certificates curl gnupg lsb-release \
	zsh vim tmux \
	git git-flow tig stow \
    tree htop jq \
	vlc tor \
	ffmpeg v4l-utils v4l2loopback-dkms

# Install nvm - node version manager
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

# Install antibody - zsh plugin manager
curl -sfL git.io/antibody | sh -s - -b /usr/local/bin

# Clone tmux tpm 
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install kubectl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Install vscodium
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg | gpg --dearmor | sudo dd of=/etc/apt/trusted.gpg.d/vscodium.gpg
echo "deb https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs/ vscodium main" | sudo tee --append /etc/apt/sources.list.d/vscodium.list

# Install spotify
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

# Install custom packages
sudo apt-get update
sudo apt-get install -y \
	docker-ce docker-ce-cli containerd.io docker-compose \
	kubectl \
	codium \
	spotify-client
	
# Change default shell to zsh
chsh -s $(which zsh)

# Mkdir zsh cache 
mkdir -p $HOME/.zsh/cache/

