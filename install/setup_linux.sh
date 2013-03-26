#!/bin/sh
# Quick and dirty:
# Hastly install dotfiles for current user
# TODO: Clean this mess out!

S_PATH="$HOME/.schematics"

# Backup
# TODO: Check if files exist before doing anything stupid
mkdir ~/.back
unlink ~/.vimrc
unlink ~/.vim/
mv ~/.vimrc ~/.back
mv ~/.vim ~/.back

# Make links
ln -s "$S_PATH/vim/vimrc" "$HOME/.vimrc"
ln -s "$S_PATH/vim" "$HOME/.vim"
ln -s "$S_PATH/powerline" "$HOME/.config/powerline"
# We love links

# Install these sexy stuff I would never make on my own

# Vundle, Bundle gesture for vim
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

# I should tell you something
echo "Done."
echo
echo "Please run vim and type :BundleInstall to install necessary bundles."
echo
echo "If you want to enable Powerline, you should edit the path in your new \
.vimrc file. I can provide you some help on this location :"
echo `locate powerline | grep "powerline$"`
echo
echo "If you need to install powerline, please run:"
echo "pip install --user git+git://github.com/Lokaltog/powerline"
echo
echo "I'm no wizard."
