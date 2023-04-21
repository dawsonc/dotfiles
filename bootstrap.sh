#!/bin/bash

# Update software
sudo apt update && sudo apt upgrade -y

# Install git and clone dotfiles repo
sudo apt install -y git
cd ~
git clone https://github.com/dawsonc/bootstrap.git

# Run the dotfiles installation and setup scripts
cd ~/dotfiles
./scripts/install.sh
./scripts/setup_dotfiles.sh
