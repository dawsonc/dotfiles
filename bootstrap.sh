#!/bin/bash
# Usage: bootstrap.sh [--headless]   (--headless skips GUI apps; see scripts/install.sh)

# Update software
sudo apt update && sudo apt upgrade -y

# Install git and clone dotfiles repo
sudo apt install -y git
#cd ~
#git clone https://github.com/dawsonc/dotfiles.git ~/dotfiles

# Run the dotfiles installation and setup scripts
#cd ~/dotfiles
chmod +x ./scripts/*
./scripts/install.sh "$@"
./scripts/setup_dotfiles.sh
