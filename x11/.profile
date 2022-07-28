# Adding python and other scripts to PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$PYTHON_BIN_PATH"
export PATH="$PATH:$HOME/.poetry/bin"

# XDG default directories
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_TEMPLATES_DIR="$HOME/Modelos"
export XDG_PUBLICSHARE_DIR="$HOME/Public"
export XDG_DOCUMENTS_DIR="$HOME/Documentos"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Imagens"
export XDG_VIDEOS_DIR="$HOME/Videos"

# EDITOR & VISUAL
if [ -x "$(command -v nvim)" ]; then
    export EDITOR=/usr/bin/nvim
    export VISUAL=/usr/bin/nvim
else
    export EDITOR=/usr/bin/vim
    export VISUAL=/usr/bin/vim
fi

# BROWSER
if [ -x "$(command -v brave)" ]; then
    export BROWSER=/usr/bin/brave
else
    export BROWSER=/usr/bin/firefox
fi

# Set less as manpager with bat coloring
export MANPAGER="sh -c 'col -bx | bat --theme \"Monokai Extended\" -l man -p'"

# User dotfiles and projects directories
export DOT="$HOME/.dotfiles"
export PROJECTS="$HOME/projects"


##### HOME DIR CLEANUP #####

# Cargo
export CARGO_HOME="$XDG_DATA_HOME/cargo"

# Docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

# GNUpg
export GNUPGHOME="$XDG_DATA_HOME/gnupg"

# Go
export GOPATH="$XDG_DATA_HOME/go"

# GTK-2
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"

# Jupyter
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"

# Less
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"

# Java
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"

# Poetry
export POETRY_HOME="$XDG_DATA_HOME/poetry"

# ZSH
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$XDG_STATE_HOME/zsh/history"
export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump-$HOST"

# URXVT
export RXVT_SOCKET="$XDG_RUNTIME_DIR/urxvtd"


# MISC
export QT_QPA_PLATFORMTHEME="qt5ct"
