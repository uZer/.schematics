Dotfile Schematics
==================

Nothing more than my boring dotfiles and terminal configurations.

Easy install script using:

    ~/.schematics/install/setup_linux.sh


### This bundle contains
- vim configuration files
- github aliases and name configuration
- powerline installation script and configuration files
- solarized themes easy install script

### If you want to use this configuration files
You should first install the following packages before using Dotfile Schematics:
- vim compiled linking python libraries. You can use a pre-compiled version like
  vim-nox for example.
- python and python-pip installation files support
- git, ssh, zsh

Tested on Debian Wheezy

### Post installation recommandations
After installation, you should change the content of ~/.gitconfig with your
contact informations (instead of mine...).
Also run vim and type the following command:

    :BundleInstall

This will download the remaining bundles


### All in one installation

    sudo apt-get install vim-nox python-pip git ssh zsh
    cd
    git clone git://github.com/uZer/.schematics.git
    ~/.schematics/install/setup_linux.sh

    vim
    # and type :BundleInstall, then :q!

    vim ~/.gitconfig
    # and change your personal information


