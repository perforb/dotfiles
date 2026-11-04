# dotfiles

My dotfiles for macOS (Apple Silicon).

## Requirements

- macOS (Apple Silicon)
- [Homebrew](https://brew.sh)

## Setup

### 1. Install Homebrew

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"

### 2. Install dependencies

    brew install mise gh
    curl -LsSf https://astral.sh/uv/install.sh | sh

Shell tools (fzf, zoxide, starship, fd, bat, eza) are installed by mise in step 4.

### 3. Clone and run installer

    git clone https://github.com/perforb/dotfiles.git ~/projects/public/dotfiles
    cd ~/projects/public/dotfiles
    ./install.sh

### 4. Install runtimes and CLIs via mise

    mise install

Versions are defined in `mise/global.toml` (Node, Python, Terraform, AWS CLI and the shell tools), linked to `~/.config/mise/config.toml`.
It is not named `mise/config.toml` because mise would treat that path as a project config inside this repo.

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
| `CTRL-N` | Navigate directories |
| `CTRL-]` | Accept autosuggestion |
