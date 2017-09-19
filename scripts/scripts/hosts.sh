#!/bin/bash

wget https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
sudo cp hosts /etc/hosts
rm hosts
cd ~
