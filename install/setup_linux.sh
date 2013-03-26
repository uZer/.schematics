#!/bin/sh
# Quick and dirty:
# Hastly install dotfiles for current user
# TODO: Clean this mess out!

###############################################################################
# ENVIRONMENT
SCH_PATH="$HOME/.schematics" # Dotfiles
SCH_ISGRAPHICAL="true" # True if X is installed (powerline font configuration)

INST_POW="true"
INST_VIM="true"

_DEBUG="on" # Debug mod
[ "$_DEBUG" == "on" ] &&  echo "Debugging mod enabled"

###############################################################################
# Cleaning method
# Backup old configuration files, remove links
function cleaning()
{
    # TODO: What has to be done
}


# Install powerline with pip
# REQUIRES: python-pip
function installPowerline()
{
    pip install --user git+http://github.com/Lokaltog/powerline

    # On new profiles, .config folder doesn't exists
    # TODO: clean this
    mkdir $HOME/.config

    # Linking
    ln -s "$S_PATH/powerline" "$HOME/.config/powerline"

    # Copying fonts if necessary
    test [[]]
    ln -s "$S_PATH/fonts" "$HOME/.fonts"

}

# Install vim configuration files
# Retrieve vundle
function installVim()
{
    # Make links
    ln -s "$S_PATH/vim/vimrc" "$HOME/.vimrc"
    ln -s "$S_PATH/vim" "$HOME/.vim"

    # Install this sexy stuff I would never make on my own
    git clone https://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle

    echo "Please run vim and type :BundleInstall to install necessary bundles."
}

# Link all configuration files
function install()
{
    [ "$INST_POW" == "true" ] && installPowerline()
    [ "$INST_VIM" == "true" ] && installVim()
}
