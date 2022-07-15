# Adding python and other scripts to PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$PYTHON_BIN_PATH"

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

# Setting editor depending on installed applications
if [ -x "$(command -v nvim)" ]; then
    export EDITOR='nvim'
    export VISUAL='nvim'
else
    export EDITOR='vim'
    export VISUAL='vim'
fi

# Set less as manpager with bat coloring
export MANPAGER="sh -c 'col -bx | bat --theme \"Monokai Extended\" -l man -p'"

# User dotfiles and projects directories
export DOT="$HOME/.dotfiles"
export PROJECTS="$HOME/projects"

# FZF dracula colorscheme
export FZF_DEFAULT_OPTS="--color=fg:#f8f8f2,hl:#bd93f9 "\
"--color=fg+:#f8f8f2,hl+:#bd93f9 "\
"--color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 "\
"--color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4 "

# ZSH time command format
export TIMEFMT='%J   %U  user %S system'$'\n'\
'cpu %%:                     %P'$'\n'\
'elapsed time:              %E'$'\n'\
'max memory:                %M MB'$'\n'\
'avg shared (code):         %X KB'$'\n'\
'avg unshared (data/stack): %D KB'$'\n'\
'total (sum):               %K KB'$'\n'\
'page faults from disk:     %F'$'\n'\
'other page faults:         %R'

# Docker ps more informative format
export DOCKER_FORMAT="ID\t{{.ID}}\n"\
"NAME\t{{.Names}}\n"\
"IMAGE\t{{.Image}}\n"\
"PORTS\t{{.Ports}}\n"\
"COMMAND\t{{.Command}}\n"\
"CREATED\t{{.CreatedAt}}\n"\
"STATUS\t{{.Status}}\n"

# BAT theme
export BAT_THEME='Dracula'

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
export HISTFILE="$XDG_STATE_HOME"/zsh/history
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
