#!/bin/bash
DOT_FILES=(.zshrc .zprofile .zshrc.linux .zshrc.osx .gitconfig .gitignore .tmux.conf .perltidyrc)
for file in ${DOT_FILES[@]}; do
    ln -s $HOME/dotfiles/$file $HOME/$file
done
