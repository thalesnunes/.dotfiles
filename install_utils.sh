#!/usr/bin/env bash

set -euo pipefail

export DOT="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
export DOTFILES_BIN="$DOT/bin/.local/bin"
export INSTALL="$DOTFILES_BIN/inst"
export DOTFILES_LOG="${DOTFILES_LOG:-$DOT/install.log}"

log() {
    local msg="[$(date '+%Y-%m-%d %H:%M:%S')] $*"
    echo "$msg" | tee -a "$DOTFILES_LOG"
}

log_error() {
    local msg="[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: $*"
    echo "$msg" | tee -a "$DOTFILES_LOG" >&2
}

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
        log "The '$1' package is not installed."
        yn_pr "Do you want to install '$1'? [Y/n]: " && $INSTALL "$1" || return 1
    fi
    return 0
}

function install_aur_helper() {
    $INSTALL git base-devel
    git clone "https://aur.archlinux.org/$AUR_HELPER-bin.git"
    cd "$AUR_HELPER-bin"
    makepkg -si
    cd ..
    sudo rm -rf "$AUR_HELPER-bin"
}

PM_INSTALLED="$($DOTFILES_BIN/which_installer)"
log "The installed package manager is '$PM_INSTALLED'."
case $PM_INSTALLED in
    paru|yay)
        log "AUR helper already installed."
        ;;
    *)
        yn_pr "Would you like to install an AUR helper? [Y/n]: " && read -p "Which AUR helper: " AUR_HELPER && install_aur_helper
        ;;
esac

is_installed "curl"

source_path="zsh/.config/zsh/.zshenv"

if [ -f "$DOT/$source_path" ]; then
    source "$DOT/$source_path"
else
    eval "$(curl -fsSL "https://raw.githubusercontent.com/thalesnunes/.dotfiles/main/$source_path")"
fi
