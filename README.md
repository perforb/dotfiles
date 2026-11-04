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
zsh plugins (zsh-syntax-highlighting, zsh-autosuggestions) are cloned into `~/.local/share/zsh/plugins` by `install.sh`.

### 3. Clone and run installer

    git clone https://github.com/perforb/dotfiles.git ~/projects/public/dotfiles
    cd ~/projects/public/dotfiles
    ./install.sh

Existing files are moved aside as `<file>.bak.<timestamp>` before being replaced with symlinks.

### 4. Install runtimes and CLIs via mise

    mise install

Versions are defined in `mise/global.toml` (Node, Python, Terraform, AWS CLI and the shell tools), linked to `~/.config/mise/config.toml`.
It is not named `mise/config.toml` because mise would treat that path as a project config inside this repo.

### 5. Add machine-local settings

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
