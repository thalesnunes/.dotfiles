#!/usr/bin/env bash

DOTFILES_DIR="$(realpath $(dirname ${BASH_SOURCE}))"
DOTFILES_BIN="$DOTFILES_DIR/bin/.local/bin"
INSTALL="$DOTFILES_BIN/inst"

function yn_pr() {
    while true; do
        read -p "$1" yn
        case $yn in
            [Yy]* | "" ) return 0;;
            [Nn]* ) return 1;;
        esac
        echo "Not a valid answer!"
    done
}

function is_installed() {
    if ! command -v "$1" &> /dev/null; then
        echo "The '$1' package is not installed."
        yn_pr "Do you want to install '$1'? [Y/n]: " && $INSTALL $1 || return 1
    fi
    return 0
}

function install_aur_helper() {
    $INSTALL git base-devel
    git clone https://aur.archlinux.org/$AUR_HELPER-bin.git
    cd $AUR_HELPER-bin
    makepkg -si
    cd ..
    sudo rm -rf $AUR_HELPER-bin
}

PM_INSTALLED="$($DOTFILES_BIN/which_installer)"
echo "The installed package manager is '$PM_INSTALLED'."
case $PM_INSTALLED in
    paru|yay)
        echo "AUR helper already installed."
        ;;
    *)
        yn_pr "Would you like to install an AUR helper? [Y/n]: " && read -p "Which AUR helper: " AUR_HELPER && install_aur_helper
        ;;
esac

is_installed "curl"

[ -f "$DOTFILES_DIR/misc/.profile" ] && source "$DOTFILES_DIR/misc/.profile" || eval "$(curl https://raw.githubusercontent.com/thalesnunes/.dotfiles/main/misc/.profile)"
