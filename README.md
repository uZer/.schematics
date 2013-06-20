Dotfile Schematics
==================

Nothing more than my boring dotfiles and terminal configurations.
Easy install script included. Designed for Debian Wheezy.

![ZSH Prompt](https://raw.github.com/uZer/.schematics/master/screenshots/[PuTTY].Prompt.on.remote.server.png)

### All in one installation

    sudo apt-get install vim-nox python-pip git ssh zsh
    cd
    git clone http://github.com/uZer/.schematics.git
    ~/.schematics/install/setup_linux.sh

    vim
    # and type :BundleInstall, then quit !

    vim ~/.gitconfig
    # and change your personal information

    # If you're happy with zsh
    chsh
    # and change for /bin/zsh


### This bundle contains
- vim configuration files
- github aliases and name configuration
- powerline installation script and configuration files
- powerline font patch
- solarized themes easy install script
- zsh configuration with Oh My ZSH and Powerline
- LSColors for powerline

(Soon)
- Gnome-terminal solarized theme auto-install
- Terminal profile autoconf
- Wheezy GTK themes autoinstall


### If you want to use these configuration files
You should first install the following packages before using Dotfile Schematics:
- vim compiled linking python libraries. You can use a pre-compiled version like
  vim-nox for example.
- python and python-pip installation files support
- of course git, ssh, zsh

Powerline for zsh may slow a little bit your prompt. Check notes about it in the
official powerline documentation


### Post installation recommandations
After installation, you should change the content of ~/.gitconfig with your
contact informations (instead of mine...).
Also run vim and type the following command:

    :BundleInstall

This will download and install the remaining bundles

![ZSH Vim](https://raw.github.com/uZer/.schematics/master/screenshots/[PuTTY].Vim.on.remote.server.png)


