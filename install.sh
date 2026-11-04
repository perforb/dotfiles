#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Creating symlinks..."

ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"

mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"

mkdir -p "$HOME/.config/mise"
ln -sf "$DOTFILES_DIR/mise/global.toml" "$HOME/.config/mise/config.toml"

ln -sf "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"

ln -sf "$DOTFILES_DIR/vim/.vimrc" "$HOME/.vimrc"

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
