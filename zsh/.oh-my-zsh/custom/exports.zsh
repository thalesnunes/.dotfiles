export DOCKER_FORMAT="ID\t{{.ID}}\nNAME\t{{.Names}}\nIMAGE\t{{.Image}}\nPORTS\t{{.Ports}}\nCOMMAND\t{{.Command}}\nCREATED\t{{.CreatedAt}}\nSTATUS\t{{.Status}}\n"
export PROJECTS='/home/thales/Projects'
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$PYTHON_BIN_PATH"

if [ -x "$(command -v nvim)" ]; then
    export EDITOR='nvim'
    export VISUAL='nvim'
else
    export EDITOR='vim'
    export VISUAL='vim'
fi
