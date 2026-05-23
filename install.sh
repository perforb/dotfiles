#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Creating symlinks..."

ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"

mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"

ln -sf "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"

ln -sf "$DOTFILES_DIR/vim/.vimrc" "$HOME/.vimrc"

echo "Done!"
