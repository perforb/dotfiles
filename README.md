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

    brew install mise fzf zsh-syntax-highlighting zsh-autosuggestions starship fd bat eza gh
    $(brew --prefix)/opt/fzf/install
    curl -LsSf https://astral.sh/uv/install.sh | sh

### 3. Install Nerd Font

    brew install --cask font-hack-nerd-font

iTerm2 → Settings → Profiles → Text → Font → `Hack Nerd Font Mono`

### 4. Clone and run installer

    git clone https://github.com/perforb/dotfiles.git ~/projects/public/dotfiles
    cd ~/projects/public/dotfiles
    ./install.sh

### 5. Install runtimes via mise

    mise use --global python@latest
    mise use --global node@lts
    mise use --global terraform@latest

## Structure

    dotfiles/
    ├── install.sh
    ├── zsh/
    │   └── .zshrc
    ├── starship/
    │   └── starship.toml
    └── git/
        └── .gitconfig

## Key bindings

| Key | Action |
|-----|--------|
| `CTRL-R` | Search command history |
| `CTRL-T` | Search files |
| `CTRL-N` | Navigate directories |
| `CTRL-]` | Accept autosuggestion |
