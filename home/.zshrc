# ~/.zshrc
# ------------------------------------------------------------
# Interactive-shell config (prompt, aliases, completion, tools).
# Runs for every interactive shell.
# ------------------------------------------------------------

# ---- History -------------------------------------------------
HISTFILE="$HOME/.zsh_history"
HISTSIZE=20000
SAVEHIST=20000

setopt APPEND_HISTORY           # Append to history file
setopt SHARE_HISTORY            # Share history across terminals
setopt HIST_IGNORE_ALL_DUPS     # Remove older duplicates
setopt HIST_REDUCE_BLANKS       # Trim superfluous blanks

# ---- Completion ----------------------------------------------
autoload -Uz compinit
compinit

# Case-insensitive completion.
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# ---- Key bindings --------------------------------------------
bindkey -e  # Emacs-style bindings

# ---- Tool defaults -------------------------------------------
# eza: modern ls. Use icons only if you have a Nerd Font.
alias ls='eza'
alias ll='eza -lh'
alias la='eza -a'
alias tree='eza --tree'

# bat: cat replacement.
alias cat='bat --paging=never'

# fd/rg: fast find + grep.
alias find='fd'
alias grep='rg'

# Git helpers (minimal).
alias gs='git status'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate'

# ---- fzf ------------------------------------------------------
# Load fzf keybindings/completion wherever they happen to live.
# Ubuntu (apt) ships them under /usr/share/doc/fzf/examples; macOS
# (Homebrew) ships them under $(brew --prefix)/opt/fzf/shell.
for f in \
  /usr/share/doc/fzf/examples/key-bindings.zsh \
  /usr/share/doc/fzf/examples/completion.zsh \
  "$(brew --prefix 2>/dev/null)/opt/fzf/shell/key-bindings.zsh" \
  "$(brew --prefix 2>/dev/null)/opt/fzf/shell/completion.zsh"; do
  [ -f "$f" ] && source "$f"
done

# Make fzf use fd for file listing (faster than find).
if command -v fd >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# Preview files with bat in fzf when possible.
# (Used by some fzf widgets.)
if command -v bat >/dev/null 2>&1; then
  export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
fi

# ---- zoxide ---------------------------------------------------
# Smart "cd" replacement: z <dir>
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# ---- Starship prompt ------------------------------------------
# Prompt is last so it sees environment and git status correctly.
if command -v starship >/dev/null 2>&1; then
  export STARSHIP_CONFIG="$HOME/.config/starship.toml"
  eval "$(starship init zsh)"
fi

# ---- Local environment ---------------------------------------
# Sourced if present (e.g. installed by uv / other tools).
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# ---- CLI cheat sheet -----------------------------------------
# Quick reminder of the custom tooling; printed on every interactive
# shell. Type `cheat` to show it again.
cheat() {
  cat <<'EOF'
🛠  custom CLI cheat sheet   (type `cheat` to show again)
  ls / ll / la   eza — modern ls          tree     eza --tree
  cat            bat — syntax-highlight    find     fd — fast find
  grep           rg  — ripgrep             z DIR    zoxide smart cd
  Ctrl-T         fzf file picker           Ctrl-R   fzf history search
  gs / gd / gl   git status / diff / log
EOF
}
[[ -o interactive ]] && cheat
