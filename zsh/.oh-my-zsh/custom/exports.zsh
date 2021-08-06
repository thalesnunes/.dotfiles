export DOCKER_FORMAT="ID\t{{.ID}}\nNAME\t{{.Names}}\nIMAGE\t{{.Image}}\nPORTS\t{{.Ports}}\nCOMMAND\t{{.Command}}\nCREATED\t{{.CreatedAt}}\nSTATUS\t{{.Status}}\n"
export PROJECTS='/home/thales/Projects'
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$PYTHON_BIN_PATH"

if [ -x "$(command -v nvim)" ]; then
    export EDITOR='/usr/bin/nvim'
    export VISUAL='/usr/bin/nvim'
else
    export EDITOR='/usr/bin/vim'
    export VISUAL='/usr/bin/vim'
fi
