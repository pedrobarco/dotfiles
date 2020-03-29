#!/bin/bash

# Copy hosts file from StevenBlack
echo "Updating hosts file to StevenBlack hosts..."
wget -O /etc/hosts https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
