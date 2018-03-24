#!/bin/bash

# https://qiita.com/yoza/items/2f8bd33a18225754f346
# https://github.com/Shougo/dein.vim

# create required directories if not exists
# mkdir -p ~/.vim/dein/repos/github.com/Shougo/dein.vim
# git clone https://github.com/Shougo/dein.vim.git ~/.vim/dein/repos/github.com/Shougo/dein.vim
# :call dein#install()

DOT_FILES=(.vimrc .zprofile .zshrc .gitconfig .gitignore .tmux.conf)
for file in ${DOT_FILES[@]}; do
    ln -fs $HOME/projects/dotfiles/$file $HOME/$file
done
