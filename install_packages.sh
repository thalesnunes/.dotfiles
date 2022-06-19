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

sudo pacman -Syuu

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

if yn_pr "Do you want to install the default packages? [Y/n]: "; then
    yay -S $packages
fi

echo

if is_installed "zsh"; then
    if yn_pr "Do you want to install ohmyzsh and change shell? [Y/n]: "; then
        unset ZSH
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.config/oh-my-zsh/custom}/plugins/zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.config/oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.config/oh-my-zsh/custom}/themes/powerlevel10k
        chsh -s "$(which zsh)"
    fi
fi

echo

if is_installed "pip"; then
    python_packages=$(cat python_packages | tr "\n" " ")
    if yn_pr "Do you want to install the default python packages? [Y/n]: "; then
        pip install -U $python_packages
        curl -sSL https://install.python-poetry.org | python -
        mkdir ${ZSH_CUSTOM:-$HOME/.config/oh-my-zsh/custom}/plugins/poetry
        $HOME/.local/bin/poetry completions zsh > ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/poetry/_poetry
    fi
fi

if is_installed "nvim"; then
    if yn_pr "Do you want to install the default nvim plugins? [Y/n]: "; then
        nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
    fi
fi

echo
echo "Done!"
