#!/bin/sh
# Quick and dirty:
# Hastly install dotfiles for current user
# TODO: Clean this mess out!

S_PATH="/home/$USER/.schematics"

# Backup
# TODO: Check if files exist before doing anything stupid
mkdir ~/.back
unlink ~/.vimrc
unlink ~/.vim/
mv ~/.vimrc ~/.back
mv ~/.vim ~/.back

# Make links
ln -s "$S_PATH/vim/vimrc" "/home/$USER/.vimrc"
ln -s "$S_PATH/vim" "/home/$USER/.vim"
# We love links

# Install these sexy stuff I would never make on my own

# Vundle, Bundle gesture for vim
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

# I should tell you something
echo "Done."
echo
echo "Please run vim and type :BundleInstall to install necessary bundles."

