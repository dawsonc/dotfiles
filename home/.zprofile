# ~/.zprofile
# ------------------------------------------------------------
# Login-shell config (environment + PATH).
# Runs once for login shells. Keep interactive things (aliases,
# prompt) out of here.
# ------------------------------------------------------------

# ---- Homebrew (optional) ------------------------------------
# A no-op on a fresh apt-only machine; picks up brew if installed
# (macOS, or Linuxbrew on Ubuntu).
for b in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
  [ -x "$b" ] && eval "$("$b" shellenv)" && break
done

# ---- User binaries ------------------------------------------
# Personal scripts (~/bin) and tool-installed binaries (~/.local/bin).
if [ -d "$HOME/bin" ]; then
  export PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# ---- Default tools ------------------------------------------
# Used by git, many CLI tools, and the VS Code terminal.
# Falls back to a terminal editor where VS Code isn't installed
# (e.g. a headless server over plain ssh).
if command -v code >/dev/null 2>&1; then
  export EDITOR="code --wait"
elif command -v vim >/dev/null 2>&1; then
  export EDITOR="vim"
else
  export EDITOR="nano"
fi
export VISUAL="$EDITOR"

# ---- ripgrep defaults ---------------------------------------
# Make rg respect .gitignore and be friendlier by default.
# You can override per-command with flags.
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/rg.conf"

# ---- bat theme/paging ---------------------------------------
# "bat" is a cat replacement with syntax highlight.
export BAT_THEME="ansi"
export BAT_PAGER="less -FR"
