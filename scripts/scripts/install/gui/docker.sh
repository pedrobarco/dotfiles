#!/bin/bash
# Install docker

if [ "$(uname)" == "Darwin" ]; then
	brew install --cask docker
else
    # set up docker's apt repository
    apt-get install ca-certificates curl
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    chmod a+r /etc/apt/keyrings/docker.asc
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
        $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt update
    # install the docker packages
    apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    # create the docker group and add your user
    groupadd docker
    usermod -aG docker $USER
    echo "run \"newgrp docker\" to activate the changes to groups"
fi
