#!/usr/bin/env bash

set -euo pipefail

source "$DOT/install_utils.sh"

cd "$HOME"

$DOT/upd

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

if is_installed "zsh"; then
    if yn_pr "Do you want to change shell and create zsh deps? [Y/n]: "; then
        if [ ! -d "$XDG_CACHE_HOME/zsh" ]; then
            mkdir -p "$XDG_CACHE_HOME/zsh"
            log "Created $XDG_CACHE_HOME/zsh"
        fi
        if [ ! -d "$XDG_STATE_HOME/zsh" ]; then
            mkdir -p "$XDG_STATE_HOME/zsh"
            log "Created $XDG_STATE_HOME/zsh"
        fi
    fi
    if yn_pr "Do you want to add ZDOTDIR to /etc/zsh/zshenv? [Y/n]: "; then
        if ! grep -q 'ZDOTDIR' /etc/zsh/zshenv 2>/dev/null; then
            sudo mkdir -p "/etc/zsh"
            echo '[ -d "$HOME/.config/zsh" ] && export ZDOTDIR=$HOME/.config/zsh' | sudo tee -a /etc/zsh/zshenv > /dev/null
            log "Added ZDOTDIR to /etc/zsh/zshenv"
        else
            log "ZDOTDIR already configured in /etc/zsh/zshenv, skipping."
        fi
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
        pipx inject ranger-fm pynvim
    fi
fi

echo

if is_installed "gsettings"; then
    if yn_pr "Do you want to install the Dracula theme and icons? [Y/n]: "; then
        if [ ! -d "/usr/share/themes/Dracula" ]; then
            sudo git clone https://github.com/dracula/gtk /usr/share/themes/Dracula
            log "Cloned Dracula GTK theme"
        else
            log "Dracula GTK theme already present, pulling latest..."
            sudo git -C /usr/share/themes/Dracula pull
        fi

        if [ ! -d "/usr/share/icons/Dracula" ]; then
            sudo git clone https://github.com/m4thewz/dracula-icons /usr/share/icons/Dracula
            log "Cloned Dracula icons"
        else
            log "Dracula icons already present, pulling latest..."
            sudo git -C /usr/share/icons/Dracula pull
        fi

        gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
        gsettings set org.gnome.desktop.wm.preferences theme "Dracula"
        gsettings set org.gnome.desktop.interface icon-theme "Dracula"

        rm -rf "$HOME/.config/assets"
        rm -rf "$HOME/.config/gtk-4.0"
        mkdir -p "$HOME/.config/gtk-4.0"

        cp -r /usr/share/themes/Dracula/assets/ "$HOME/.config/"
        cp /usr/share/themes/Dracula/gtk-4.0/gtk.css "$HOME/.config/gtk-4.0/gtk.css"
        cp /usr/share/themes/Dracula/gtk-4.0/gtk-dark.css "$HOME/.config/gtk-4.0/gtk-dark.css"
        log "Dracula theme applied"
    fi
fi

echo

if ! command -v calibre > /dev/null 2>&1; then
    if yn_pr "Do you want to install calibre? [Y/n]: "; then
        log "Installing calibre..."
        if is_installed "strat"; then
            strat -r arch bash -c "sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin"
        else
            sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin
        fi
    fi
else
    log "calibre already installed, skipping."
fi

echo
log "Done!"
