#!/usr/bin/env sh

AUR_HELPER="paru"

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

        if [ $1 = $AUR_HELPER ]; then
            yn_pr "Do you want to install '$AUR_HELPER'? [Y/n]: " && install_aur_helper || exit 0
            return 0
        fi

        is_installed $AUR_HELPER
        yn_pr "Do you want to install '$1' with '$AUR_HELPER'? [Y/n]: " && $AUR_HELPER --noconfirm -S $1 || return 1
        return 0
    else
        return 0
    fi
}

function install_aur_helper() {
    sudo pacman --noconfirm -S --needed git base-devel
    git clone https://aur.archlinux.org/$AUR_HELPER-bin.git
    cd $AUR_HELPER-bin
    makepkg -si
    cd ..
    sudo rm -rf $AUR_HELPER-bin
}

is_installed $AUR_HELPER
is_installed "curl"

[ -f "$HOME/.dotfiles/x11/.profile" ] && source "$HOME/.dotfiles/x11/.profile" || eval "$(curl https://raw.githubusercontent.com/thalesnunes/.dotfiles/main/x11/.profile)"
