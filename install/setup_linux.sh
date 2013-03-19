#!/bin/sh
# Quick and dirty:
# Hastly install dotfiles for current user
# TODO: Clean this out!

S_PATH="~/.schematics"

# Backup
mkdir ~/.back
unlink ~/.vimrc
unlink ~/.vim/
mv ~/.vimrc ~/.back
mv ~/.vim ~/.back

# Make links
ln -s $S_PATH/vim/vimrc ~/.vimrc
ln -s $S_PATH/vim ~/.vim
