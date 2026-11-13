#!/usr/bin/env bash

set -euo pipefail

source "$DOT/install_utils.sh"

cd "$HOME"

$DOT/bin/.local/bin/upd

if yn_pr "Do you want to install the default packages? [Y/n]: "; then
    log "Installing system packages..."
    packages_raw=$([ -f "$DOT/packages_arch" ] && cat "$DOT/packages_arch" || curl -fsSL https://raw.githubusercontent.com/thalesnunes/.dotfiles/main/packages_arch)
    packages=$(echo "$packages_raw" | tr "\n" " ")
    $INSTALL $packages

    if [ -x "$(command -v apt)" ]; then
        log "Installing Ubuntu packages..."
        packages_raw=$([ -f "$DOT/packages_ubuntu" ] && cat "$DOT/packages_ubuntu" || curl -fsSL https://raw.githubusercontent.com/thalesnunes/.dotfiles/main/packages_ubuntu)
        packages=$(echo "$packages_raw" | tr "\n" " ")
        sudo apt install -y $packages
    fi
fi

echo

if is_installed "pip"; then
    if yn_pr "Do you want to install the default python packages? [Y/n]: "; then
        log "Installing Python packages..."
        python_packages_raw=$([ -f "$DOT/python_packages" ] && cat "$DOT/python_packages" || curl -fsSL https://raw.githubusercontent.com/thalesnunes/.dotfiles/main/python_packages)
        python_packages=$(echo "$python_packages_raw" | tr "\n" " ")
        pip install --break-system-packages -U $python_packages

        log "Installing pipx packages..."
        for package in $([ -f "$DOT/pipx_packages" ] && cat "$DOT/pipx_packages" || curl -fsSL https://raw.githubusercontent.com/thalesnunes/.dotfiles/main/pipx_packages); do
            if ! pipx list 2>/dev/null | grep -q "^$package"; then
                pipx install "$package"
                log "Installed pipx package: $package"
            else
                log "pipx package '$package' already installed, skipping."
            fi
        done
    fi
fi

echo
log "Done!"
