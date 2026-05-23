#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Creating symlinks..."

ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"

mkdir -p "$HOME/.config/starship"
ln -sf "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship/starship.toml"

ln -sf "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"

echo "Done!"
