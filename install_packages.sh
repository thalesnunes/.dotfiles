#!/usr/bin/env bash

source install_utils.sh

cd $HOME

$DOTFILES_BIN/upd

if yn_pr "Do you want to install the default packages? [Y/n]: "; then
    packages_raw=$([ -f "$DOT/packages" ] && cat "$DOT/packages" || curl https://raw.githubusercontent.com/thalesnunes/.dotfiles/main/packages)
    packages=$(echo "$packages_raw" | tr "\n" " ")
    $INSTALL $packages
fi

echo

if is_installed "zsh"; then
    if yn_pr "Do you want to change shell and install z4h? [Y/n]: "; then
        mkdir -p "$XDG_CACHE_HOME/zsh"
        mkdir -p "$XDG_STATE_HOME/zsh"
        zsh -c "echo 'Done!'"
    fi
fi

echo

if is_installed "pip"; then
    if yn_pr "Do you want to install the default python packages? [Y/n]: "; then
        python_packages_raw=$([ -f "$DOT/python_packages" ] && cat "$DOT/python_packages" || curl https://raw.githubusercontent.com/thalesnunes/.dotfiles/main/python_packages)
        python_packages=$(echo "$python_packages_raw" | tr "\n" " ")
        pip install --break-system-packages -U $python_packages
        for package in $([ -f "$DOT/pipx_packages" ] && cat "$DOT/pipx_packages" || curl https://raw.githubusercontent.com/thalesnunes/.dotfiles/main/pipx_packages); do
            pipx install "$package"
        done
        pipx inject ranger-fm pynvim
    fi
fi

echo

if is_installed "nvim"; then
    if yn_pr "Do you want to install the default nvim plugins? [Y/n]: "; then
        nvim --headless "+Lazy! sync" +qa
    fi
fi

echo

if is_installed "gsettings"; then
    if yn_pr "Do you want to install the Dracula theme and icons? [Y/n]: "; then
        sudo git clone https://github.com/dracula/gtk /usr/share/themes/Dracula
        sudo git clone https://github.com/m4thewz/dracula-icons /usr/share/icons/Dracula
        gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
        gsettings set org.gnome.desktop.wm.preferences theme "Dracula"
        gsettings set org.gnome.desktop.interface icon-theme "Dracula"
    fi
fi

echo

if yn_pr "Do you want to install calibre? [Y/n]: "; then
    if is_installed "strat"; then
        strat -r arch bash -c "sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin"
    else
        sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin
    fi
fi

echo
echo "Done!"
