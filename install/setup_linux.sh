#!/bin/bash
# Install dotfiles for current user
#
# Youenn Piolet 2013
# <piolet.y@gmail.com>

###############################################################################
# ENVIRONMENT

# Install selection
INST_GIT="true"     # Enable Git Config Install
INST_POW="false"    # Enable Powerline Install
INST_POF="false"    # Enable Powerline Font setup
INST_VIM="true"     # Enable Vim config Install

# Dotfiles path
SCH_PATH="$HOME/.schematics"

# Backup dir in ~/.schematics/.backup.<timestamp>
_BACKUPDIR="$SCH_PATH/.backup.`date +%s`"

###############################################################################
# Link method, taking care of old files
makelink ()
{
    _SOURCE="$1"
    _DEST="$2"

    # Source doesn't exist
    if [ ! -e "$_SOURCE" ]; then
        echo "ERROR: Source file doesn't exist" 1>&2
        return 1
    fi

    # Destination exists as a symbolic link
    if [ -L "$_DEST" ]; then
        echo "  Unlinking $_DEST..."

        # Unlink and test
        rm ${_DEST}
        [ "$?" -ne "0" ] && "ERROR: Can't unlink file." 1>&2 && return 2
    fi

    # Destination exists as a file or folder
    if [ -e "$_DEST" ]; then
        echo "  Making backup dir $_DEST..."

        # Created backup folder
        mkdir -p ${_BACKUPDIR} 2>/dev/null

        # Move the file/folder and check results
        mv ${_DEST} ${_BACKUPDIR}
        [ "$?" -ne "0" ] \
            && "ERROR: Can't make backup. Please check permissions." 1>&2 \
            && return 3
    fi

    # Make the new link
    ln -s $_SOURCE $_DEST
    return 0
}

# [GIT]
# Linking needed files
installGit ()
{
    echo "[GIT]"
    echo "  Linking git configuration files..."
    makelink $SCH_PATH/git/gitconfig $HOME/.gitconfig
    echo ""
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
    mkdir "$HOME/.config" 2>/dev/null

    # Linking
    makelink "$SCH_PATH/powerline" "$HOME/.config/powerline"

    echo ""
    return
}

# [POWERLINE FONTS]
# Copying powerline supporting fonts in ~/.fonts
# Recommended: Ubuntu Mono for Powerline 11
installPowerlineFonts ()
{
    mkdir "$HOME/.fonts" 2>/dev/null

    # Copying fonts if necessary
    # TODO: Check if graphical or not
    cp "$SCH_PATH/fonts/*" "$HOME/.fonts"

    echo ""
    return
}

# [VIM]
# Linking vim configuration files
# Retrieving vundle
installVim ()
{
    echo "[VIM]"
    echo "  Linking vim configuration files..."

    # TODO: Fix line 114
    eval vim --version | grep python 1>&2>/dev/null
    if [ "$?" -ne "0" ]; then
        echo "" 2>&1
        echo "  WARNING: vim NOT compiled with python support." 2>&1
        echo "           Powerline for vim disabled" 2>&1
        echo "" 2>&1
    fi

    # Make links
    makelink "$SCH_PATH/vim/vimrc" "$HOME/.vimrc"
    makelink "$SCH_PATH/vim" "$HOME/.vim"

    # Install this sexy stuff I would never make on my own
    if [ -d "$HOME/.vim/bundle/vundle" ]; then
        echo ""
        echo "Updating vundle..."
        cd "$HOME/.vim/bundle/vundle" && git pull origin master
        echo ""
    else
        git clone https://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
    fi

    echo "  Please run vim and type :"
    echo "  \":BundleInstall\" to install necessary bundles, or"
    echo "  \":BundleUpdate\" to update bundles if already installed."
    echo ""
    return
}

###############################################################################

# Proceed installation
[ "$INST_GIT" == "true" ] && installGit
[ "$INST_POW" == "true" ] && installPowerline
[ "$INST_POF" == "true" ] && installPowerlineFonts
[ "$INST_VIM" == "true" ] && installVim

exit 0
