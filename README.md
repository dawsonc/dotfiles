# Dotfiles

Files for setting up a new Ubuntu install.

To run on a fresh install:

```
wget https://raw.githubusercontent.com/dawsonc/dotfiles/main/bootstrap.sh -O - | bash
```

## Shell setup

`scripts/install.sh` installs **zsh** plus a modern CLI tool stack and makes zsh
the default login shell:

- `eza` (ls), `bat` (cat), `fd` (find), `ripgrep` (grep), `fzf` (fuzzy finder),
  `zoxide` (smart cd), and the `starship` prompt.
- Everything is from apt or an official apt repo (`eza` uses the gierens repo),
  **except `starship`**, which has no official apt repo and is installed via its
  official `starship.rs/install.sh` script.

`scripts/setup_dotfiles.sh` symlinks the tracked configs into place (backing up any
existing files to `*.bak`):

- `home/.zshrc` → `~/.zshrc`
- `home/.zprofile` → `~/.zprofile`
- `config/starship.toml` → `~/.config/starship.toml`
- `config/ripgrep/rg.conf` → `~/.config/ripgrep/rg.conf`

On Ubuntu the `bat`/`fd-find` packages install their binaries as `batcat`/`fdfind`,
so the setup script also creates `~/.local/bin/{bat,fd}` shims. A CLI cheat sheet is
printed on every interactive shell (run `cheat` to show it again).