#!/bin/bash

# Usage: install.sh [--headless]
#   --headless (or HEADLESS=1): skip GUI apps (VS Code, Obsidian), e.g. on a dev server.
HEADLESS="${HEADLESS:-0}"
for arg in "$@"; do
    case "$arg" in
        --headless) HEADLESS=1 ;;
    esac
done

# Install basic development tools
sudo apt install -y \
    git \
    build-essential \
    python3 \
    python3-pip \
    python3-venv \
    curl \
    wget \
    gpg

# Install uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# Install the GitHub CLI tool
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
sudo apt-add-repository -y https://cli.github.com/packages
sudo apt update
sudo apt install -y gh

# ---- GUI apps (skipped in headless mode) ----
if [ "$HEADLESS" != 1 ]; then

# Install VS Code
sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install code

# Install obsidian
wget https://github.com/obsidianmd/obsidian-releases/releases/download/v1.12.7/obsidian_1.12.7_amd64.deb -O /tmp/obsidian.deb
sudo apt update
sudo apt install /tmp/obsidian.deb -y

fi

# Install zsh + the modern CLI tool stack.
# NOTE: on Ubuntu the `bat` package installs the binary as `batcat` and
# `fd-find` installs it as `fdfind`; setup_dotfiles.sh creates `bat`/`fd`
# shims so the aliases in .zshrc work.
sudo apt update
sudo apt install -y zsh fzf ripgrep bat fd-find zoxide

# eza (modern ls) is not in the default apt repos; add its official repo.
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc \
    | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" \
    | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

# starship (prompt) has no official apt repo; use its official installer.
curl -sS https://starship.rs/install.sh | sh -s -- -y

# Make zsh the default login shell.
chsh -s "$(command -v zsh)" "$USER"

# ---- Coding agents ----
# Claude Code (installs to ~/.local/bin, already on PATH via .zprofile).
curl -fsSL https://claude.ai/install.sh | bash

# pi
curl -fsSL https://pi.dev/install.sh | sh
