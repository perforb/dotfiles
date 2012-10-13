#!/bin/bash

DOT_FILES=(.zshrc .zprofile .zshrc.osx .gitconfig .gitignore .tmux.conf .perltidyrc)
for file in ${DOT_FILES[@]}; do
    ln -s $HOME/dotfiles/$file $HOME/$file
done

LIB_FILES=(git-completion.sh)
for file in ${LIB_FILES[@]}; do
    ln -s $HOME/dotfiles/lib/$file $HOME/$file
done
