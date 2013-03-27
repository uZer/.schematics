#!/bin/bash
# Quick and dirty:
# Hastly install dotfiles for current user
# TODO: Clean this mess out!

###############################################################################
# ENVIRONMENT
SCH_PATH="$HOME/.schematics" # Dotfiles
SCH_ISGRAPHICAL="true" # True if X is installed (powerline font configuration)

INST_GIT="false"
INST_POW="false"
INST_VIM="false"

# Backup dir in ~/.schematics/.backup.<timestamp>
_BACKUPDIR="$SCH_PATH/.backup.`date +%s`"

_DEBUG="on" # Debug mod
[ "$_DEBUG" == "on" ] && echo "Debugging mod enabled"

###############################################################################
# Global cleaning method
# Backup old configuration files, remove links
cleaning ()
{
    # TODO: What has to be done
    return
}

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
        [ ! `unlink "$_DEST"` ] \
        && "ERROR: Can't unlink file. Pease check permissions." 1>&2 \
        && return 2
    fi

    # Destination exists as a file or folder
    if [ -e "$_DEST" ]; then
        echo "  Making backup dir $_DEST..."

        # Created backup folder
        mkdir -p $_BACKUPDIR 2>/dev/null

        # Move the file/folder and check results
        [ ! `mv $_DEST $_BACKUPDIR` ] \
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

    return
}

installPowerlineFonts ()
{
    mkdir "$HOME/.fonts" 2>/dev/null

    # Copying fonts if necessary
    # TODO: Check if graphical or not
    cp "$SCH_PATH/fonts/*" "$HOME/.fonts"

    return
}

# [VIM]
# Linking vim configuration files
# Retrieving vundle
installVim ()
{
    echo "[VIM]"
    echo "  Linking vim configuration files..."

    # TODO: Fix line 114j
    if [ `vim --version | grep "python"` -ne "0" ]; then
        echo "" 2>&1
        echo "  WARNING: vim NOT compiled with python support." 2>&1
        echo "           Powerline for vim disabled" 2>&1
        echo "" 2>&1
    fi

    # Make links
    makelink "$SCH_PATH/vim/vimrc" "$HOME/.vimrc"
    makelink "$SCH_PATH/vim" "$HOME/.vim"

    # Install this sexy stuff I would never make on my own
    git clone https://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle

    echo "  Please run vim and type :"
    echo "  \":BundleInstall\" to install necessary bundles."
    return
}

###############################################################################
[ "$INST_GIT" == "true" ] && installGit
[ "$INST_POW" == "true" ] && installPowerline
[ "$INST_POF" == "true" ] && installPowerlineFonts
[ "$INST_VIM" == "true" ] && installVim
exit 0
