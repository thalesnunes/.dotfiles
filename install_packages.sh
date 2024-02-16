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
    if yn_pr "Do you want to install the default python packages? [Y/n]: "; then
        python_packages_raw=$([ -f "$DOT/python_packages" ] && cat "$DOT/python_packages" || curl https://raw.githubusercontent.com/thalesnunes/.dotfiles/main/python_packages)
        python_packages=$(echo "$python_packages_raw" | tr "\n" " ")
        pip install -U $python_packages
        for package in $([ -f "$DOT/pipx_packages" ] && cat "$DOT/pipx_packages" || curl https://raw.githubusercontent.com/thalesnunes/.dotfiles/main/pipx_packages); do
            pipx install "$package"
        done
        pipx inject ranger-fm pynvim
        export ZSH_CUSTOM="$XDG_CONFIG_HOME/zsh/oh-my-zsh/custom"
        mkdir -p ${ZSH_CUSTOM}/plugins/poetry
        $XDG_USER_BIN/poetry completions zsh > ${ZSH_CUSTOM}/plugins/poetry/_poetry
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
        sudo git clone https://github.com/dracula/gtk /usr/share/themes/Dracula
        sudo git clone https://github.com/m4thewz/dracula-icons /usr/share/icons/Dracula
        gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
        gsettings set org.gnome.desktop.wm.preferences theme "Dracula"
        gsettings set org.gnome.desktop.interface icon-theme "Dracula"
    fi
fi

echo
echo "Done!"
