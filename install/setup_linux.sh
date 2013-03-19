#!/bin/sh
# Quick and dirty:
# Hastly install dotfiles for current user
# TODO: Clean this mess out!

S_PATH="/home/$USER/.schematics"

# Backup
mkdir ~/.back
unlink ~/.vimrc
unlink ~/.vim/
mv ~/.vimrc ~/.back
mv ~/.vim ~/.back

# Make links
ln -s "$S_PATH/vim/vimrc" "/home/$USER/.vimrc"
ln -s "$S_PATH/vim" "/home/$USER/.vim"
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
