#!/usr/bin/env sh

source install_utils.sh

cd $HOME

sudo pacman -Syuu --noconfirm

if yn_pr "Do you want to install the default packages? [Y/n]: "; then
    packages_raw=$([ -f "$DOT/packages" ] && cat "$DOT/packages" || curl https://raw.githubusercontent.com/thalesnunes/.dotfiles/main/packages)
    packages=$(echo "$packages_raw" | tr "\n" " ")
    $AUR_HELPER --noconfirm -S $packages
fi

echo

if is_installed "zsh"; then
    if yn_pr "Do you want to install ohmyzsh and change shell? [Y/n]: "; then
        unset ZSH
        export ZSH="$XDG_CONFIG_HOME/zsh/oh-my-zsh"
        export ZSH_CUSTOM="$XDG_CONFIG_HOME/zsh/oh-my-zsh/custom"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM}/themes/powerlevel10k
        chsh -s "$(which zsh)"
    fi
fi

echo

if is_installed "pip"; then
    python_packages_raw=$([ -f "$DOT/python_packages" ] && cat "$DOT/python_packages" || curl https://raw.githubusercontent.com/thalesnunes/.dotfiles/main/python_packages)
    python_packages=$(echo "$python_packages_raw" | tr "\n" " ")
    if yn_pr "Do you want to install the default python packages? [Y/n]: "; then
        pip install -U $python_packages
        export ZSH_CUSTOM="$XDG_CONFIG_HOME/zsh/oh-my-zsh/custom"
        curl -sSL https://install.python-poetry.org | python -
        mkdir -p ${ZSH_CUSTOM}/plugins/poetry
        $HOME/.local/bin/poetry completions zsh > ${ZSH_CUSTOM}/plugins/poetry/_poetry
    fi
fi

echo

if is_installed "nvim"; then
    if yn_pr "Do you want to install the default nvim plugins? [Y/n]: "; then
        nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
    fi
fi

echo

if is_installed "gsettings"; then
    if yn_pr "Do you want to install the Dracula theme and icons? [Y/n]: "; then
        $AUR_HELPER --noconfirm -S dracula-gtk-theme dracula-icons-git
        gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
        gsettings set org.gnome.desktop.wm.preferences theme "Dracula"
        gsettings set org.gnome.desktop.interface icon-theme "Dracula"
    fi
fi

echo
echo "Done!"
