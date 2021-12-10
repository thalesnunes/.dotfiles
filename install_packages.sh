#!/usr/bin/env sh

function yn_pr() {
    while true; do
        read -p "$1" yn
        case $yn in
            [Yy]* | "" ) return 0;;
            [Nn]* ) return 1;;
        esac
    done
}

function is_installed() {
    if ! command -v "$1" &> /dev/null; then
        echo "The '$1' package is not installed."
        echo "Please install '$1' so the process can continue"
        return 1
    fi
}

if ! is_installed "yay"; then
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    sudo rm -rf yay
fi

if [ ! -d "$HOME/.dotfiles" ]; then
    cd ~
    git clone https://github.com/thalesnunes/.dotfiles
fi

cd "$HOME/.dotfiles"

packages=$(cat packages | tr "\n" " ")

yn_pr "Do you want to install the default packages? [Y/n]: " && yay -S $packages

echo

is_installed "pip"

python_packages=$(cat python_packages | tr "\n" " ")
yn_pr "Do you want to install the default python packages? [Y/n]: " && pip install -U $python_packages

echo
echo "Done!"
