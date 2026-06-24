#!/bin/bash
# ------------------------------------------------------------
# Symlink the tracked dotfiles into $HOME and expose the CLI
# tools under the names the aliases expect.
# ------------------------------------------------------------
set -euo pipefail

# Repo root, derived from this script's location (scripts/..).
DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# link <src-in-repo> <dest-relative-to-home>
# Backs up any existing real file to <dest>.bak, then symlinks.
link() {
    local src="$DOTFILES_DIR/$1" dest="$HOME/$2"
    mkdir -p "$(dirname "$dest")"
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        mv "$dest" "$dest.bak"
    fi
    ln -sfn "$src" "$dest"
}

link home/.zshrc            .zshrc
link home/.zprofile         .zprofile
link config/starship.toml   .config/starship.toml
link config/ripgrep/rg.conf .config/ripgrep/rg.conf

# Ubuntu renames these binaries (batcat / fdfind); expose them under
# the names used by the aliases in .zshrc.
mkdir -p "$HOME/.local/bin"
ln -sf "$(command -v batcat)" "$HOME/.local/bin/bat" 2>/dev/null || true
ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"  2>/dev/null || true

echo "Dotfiles linked. Start a new shell (or log out/in) to pick up zsh + the new config."
