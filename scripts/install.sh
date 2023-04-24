#!/bin/bash

# Install basic development tools
sudo apt install -y \
    git \
    build-essential \
    python3 \
    python3-pip \
    python3-venv

# Install the GitHub CLI tool
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
sudo apt-add-repository -y https://cli.github.com/packages
sudo apt update
sudo apt install -y gh

# Install VS Code
sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install code

# Install neovim
sudo apt install -y neovim

# Install chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# Install obsidian
wget https://github.com/obsidianmd/obsidian-releases/releases/download/v1.1.16/obsidian_1.1.16_amd64.snap -O /tmp/obsidian.snap
snap install /tmp/obsidian.snap --dangerous --classic