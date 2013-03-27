#!/bin/bash
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
[ "$_DEBUG" == "on" ] && echo "Debugging mod enabled"

###############################################################################
# Cleaning method
# Backup old configuration files, remove links
cleaning ()
{
    # TODO: What has to be done
    return
}

# [GIT]
# Linking needed files
installGit ()
{
    echo "[GIT]"
    echo "  Linking git configuration files..."
    ln -s $SCH_PATH/git/gitconfig $HOME/.gitconfig
    return
}

# [POWERLINE]
# Installing powerline with pip
# Linking needed files, copying fonts
# REQUIRES: python-pip, vim-nox or any vim compiled with python
installPowerline ()
{
    # TODO: Check if python-pip is installed

    echo "[POWERLINE]"
    echo "  Linking powerline configuration files..."
    pip install --user git+http://github.com/Lokaltog/powerline

    # On new profiles, .config folder doesn't exists
    # TODO: clean this
    mkdir "$HOME/.config"
    mkdir "$HOME/.fonts"

    # Linking
    ln -s "$SCH_PATH/powerline" "$HOME/.config/powerline"

    # Copying fonts if necessary
    [ "$SCH_ISGRAPHICAL" == "true" ] && cp "$SCH_PATH/fonts/*" "$HOME/.fonts"
    return
}

# [VIM]
# Linking vim configuration files
# Retrieving vundle
installVim ()
{
    echo "[VIM]"
    echo "  Linking vim configuration files..."

    # TODO: Trigger a warning if vim doesn't support python
    if [ `vim --version | grep "python"` -ne "0" ]; then
        echo ""
        echo "  WARNING: vim NOT compiled with python support."
        echo "           Powerline for vim disabled"
        echo ""
    fi

    # Make links
    ln -s "$SCH_PATH/vim/vimrc" "$HOME/.vimrc"
    ln -s "$SCH_PATH/vim" "$HOME/.vim"

    # Install this sexy stuff I would never make on my own
    git clone https://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle

    echo "  Please run vim and type :"
    echo "  \":BundleInstall\" to install necessary bundles."
    return
}

###############################################################################
# [ "$INST_POW" == "true" ] && installGit
# [ "$INST_POW" == "true" ] && installPowerline
# [ "$INST_VIM" == "true" ] && installVim
exit 0
