#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

BACKUP_SUFFIX=".bak.$(date +%Y%m%d%H%M%S)"

# Link $1 (in this repo) to $2, moving an existing real file aside first
link() {
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    mv "$dest" "$dest$BACKUP_SUFFIX"
    echo "  backed up $dest -> $dest$BACKUP_SUFFIX"
  fi
  ln -sfn "$src" "$dest"
}

echo "Creating symlinks..."

link "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
link "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"
link "$DOTFILES_DIR/mise/global.toml" "$HOME/.config/mise/config.toml"
link "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
link "$DOTFILES_DIR/vim/.vimrc" "$HOME/.vimrc"

echo "Fetching zsh plugins..."

ZSH_PLUGINS_DIR="$HOME/.local/share/zsh/plugins"
mkdir -p "$ZSH_PLUGINS_DIR"
for repo in zsh-users/zsh-syntax-highlighting zsh-users/zsh-autosuggestions; do
  dest="$ZSH_PLUGINS_DIR/${repo#*/}"
  if [ -d "$dest/.git" ]; then
    git -C "$dest" pull --ff-only --quiet
  else
    git clone --depth 1 --quiet "https://github.com/$repo.git" "$dest"
  fi
done

echo "Done!"
