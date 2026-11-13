#!/usr/bin/env bash

set -euo pipefail

source "$DOT/install_utils.sh"

cd "$HOME"

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

if is_installed "earlyoom"; then
    if yn_pr "Do you want to configure RAM peak safeguards (zram and earlyoom)? [Y/n]: "; then
        if [ ! -f "/etc/systemd/zram-generator.conf" ] || [ ! -f "/etc/default/earlyoom" ]; then
            log "Root configuration files not found in /etc."
            if yn_pr "Do you want to copy root dotfiles now (./install_dotfiles.sh --root)? [Y/n]: "; then
                "$DOT/install_dotfiles.sh" --root
            fi
        fi

        if [ -x "/usr/lib/systemd/system-generators/zram-generator" ]; then
            sudo systemctl daemon-reload
            sudo systemctl start dev-zram0.swap 2>/dev/null || true
            log "Configured and activated zram swap"
        fi

        if ! systemctl is-enabled earlyoom &>/dev/null; then
            sudo systemctl enable --now earlyoom
            log "Enabled and started earlyoom service"
        else
            sudo systemctl restart earlyoom
            log "Restarted earlyoom service with updated configuration"
        fi
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
log "Done!"
