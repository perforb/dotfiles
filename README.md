# dotfiles

My dotfiles for zsh on macOS and Linux.

## Requirements

- zsh, git and curl
- [mise](https://mise.jdx.dev) — installs every other tool

## Setup

### 1. Install mise

    curl https://mise.run | sh

This puts `mise` in `~/.local/bin` on both macOS and Linux (`brew install mise` also works on macOS).

### 2. Clone and run installer

    git clone https://github.com/perforb/dotfiles.git ~/projects/public/dotfiles
    cd ~/projects/public/dotfiles
    ./install.sh

`install.sh` is safe to re-run. It:

- links the config files into `$HOME`, moving existing files aside as `<file>.bak.<timestamp>`
- clones zsh-syntax-highlighting and zsh-autosuggestions into `~/.local/share/zsh/plugins`
- runs `mise install` for the tools in `mise/global.toml`
  (fzf, zoxide, starship, fd, bat, eza, uv, gh, Node, Python, Terraform, AWS CLI)

`mise/global.toml` is linked to `~/.config/mise/config.toml`.
It is not named `mise/config.toml` because mise would treat that path as a project config inside this repo.

### 3. Use zsh

On Linux, make zsh the login shell if it is not already:

    chsh -s "$(command -v zsh)"

Then open a new terminal. Sections of `.zshrc` whose tools are missing are skipped, so the shell starts even before `mise install` finishes.

### 4. Add machine-local settings

Identity and machine-specific settings are not tracked. Each file is loaded when present:

| File | Purpose |
|------|---------|
| `~/.gitconfig.local` | `[user]` name and email (required: commits are refused without it) |
| `~/.zshrc.local` | PATH, tokens and other per-machine shell settings |
| `~/.vimrc.local` | Extra vim settings |
| `~/.config/mise/config.local.toml` | Extra tools or version overrides (wins over `config.toml`) |

Minimal `~/.gitconfig.local`:

    [user]
      name = Your Name
      email = 12345678+username@users.noreply.github.com

To commit with a different identity under a directory, add an `includeIf` there:

    [includeIf "gitdir:~/projects/public/"]
      path = ~/.gitconfig.personal

## Structure

    dotfiles/
    ├── install.sh
    ├── zsh/
    │   └── .zshrc
    ├── starship/
    │   └── starship.toml
    ├── mise/
    │   └── global.toml
    ├── git/
    │   └── .gitconfig
    └── vim/
        └── .vimrc

## Key bindings

| Key | Action |
|-----|--------|
| `CTRL-R` | Search command history |
| `CTRL-T` | Search files |
| `CTRL-N` | Jump to a recent directory (zoxide) |
| `TAB` / `CTRL-]` | Accept autosuggestion (TAB completes when there is none) |
