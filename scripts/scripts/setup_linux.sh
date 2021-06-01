#!/bin/bash

# Install apt packages
apt install -y \
	zsh vim tmux \
	git git-flow tig stow \
    zsh tree htop jq \
	vlc tor \
	v4l2loopback-dkms \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	lsb-release


# Install snap packages
snap install spotify discord
snap install kubectl --classic

# Install nvm - node version manager
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

# Install antibody - zsh plugin manager
curl -sfL git.io/antibody | sh -s - -b /usr/local/bin

# Clone tmux tpm 
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install vscodium
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg | gpg --dearmor | sudo dd of=/etc/apt/trusted.gpg.d/vscodium.gpg

echo 'deb https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs/ vscodium main' | sudo tee --append /etc/apt/sources.list.d/vscodium.list

# Install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y \
	codium \
	docker-ce \
       	docker-ce-cli \
	containerd.io \
	docker-compose 

# Change default shell to zsh
chsh -s $(which zsh)

# Mkdir zsh cache 
mkdir -p $HOME/.zsh/cache/

