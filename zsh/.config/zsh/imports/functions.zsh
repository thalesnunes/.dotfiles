function gi() {
    curl -sL https://www.toptal.com/developers/gitignore/api/$@
}

function jupyter_docker() {
    docker run --name jupyter -p 8888:8888 -it -e JUPYTER_ENABLE_LAB=yes \
        --rm -d -v "$PROJECTS"/db-crawler:/usr/src/app -w /usr/src/app \
        thalesnunes1/db-crawler:latest &&
    sleep 2 &&
    jupyter_url=$(docker logs jupyter | \
            grep -o "http:\/\/127\.0\.0\.1:8888\/lab?token=.*" | tail -1) &&
    google-chrome $jupyter_url &!
}

function gcala() {
    args=$@
    for dir in ~/.config/gcalcli/*/; do
        gcalcli --config-folder $dir $args;
    done
}

function config() {
    TOCD=$DOT
    FILE=""

    if [[ $# -eq 1 ]]; then
        PROG=$1
    else
        PROG=$(echo "all\n$(ls -l $DOT | awk '/^d/ { print $NF }')" | fzf)
    fi

    [[ -z "$PROG" ]] && return

    case $PROG in
        bin)
            TOCD="$DOT/bin/.local/bin"
            FILE=""
            ;;
        ali*)
            TOCD="$DOT/zsh/.config/zsh/imports"
            FILE="aliases.zsh"
            ;;
        func*)
            TOCD="$DOT/zsh/.config/zsh/imports"
            FILE="functions.zsh"
            ;;
        exp*)
            TOCD="$DOT/zsh/.config/zsh/imports"
            FILE="exports.zsh"
            ;;
        tok*)
            TOCD="$DOT/private/.config/zsh/imports"
            FILE="tokens.zsh"
            ;;
        snow*)
            TOCD="$HOME/.snowsql"
            FILE="config"
            ;;
        *)
            if [ -d $DOT/$PROG ]; then
                TOCD="$DOT/$PROG"
                if [ -d $TOCD/.config ]; then
                    TOCD="$TOCD/.config"
                    if [ -d $TOCD/$PROG ]; then
                        TOCD="$TOCD/$PROG"
                    fi
                fi
            fi
            files=$(ls -A1q $TOCD)
            if [ $(echo "$files" | wc -l) -eq 1 ]; then
                FILE=$files
            fi
            ;;
    esac

    cd $TOCD
    $EDITOR $FILE
    cd "$OLDPWD"
}

function proj() {

    PROJ_DIR=$PROJECTS

    if [[ $1 == "w" ]]; then
        PROJ_DIR=$WORK_PROJECTS
        pidof -q ssh-agent || ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
        if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
            source "$XDG_RUNTIME_DIR/ssh-agent.env" > /dev/null
        fi
        ssh-add ~/.ssh/id_rsa &> /dev/null
    fi

    if [[ $# -eq 1 && $1 != "w" && $1 != "a" ]]; then
        NAME=$1
    elif [[ $# -eq 2 && $1 == "w" ]]; then
        NAME=$2
    elif [[ $# -eq 1 && $1 == "a" ]]; then
        TOCD=$(find $PROJECTS $WORK_PROJECTS -maxdepth 1 -mindepth 1 -type d | fzf)
        PROJ_DIR=$(dirname $TOCD)
        NAME=$(basename $TOCD)
    else
        NAME=$(ls -1q $PROJ_DIR | fzf)
    fi

    if [[ -z "$NAME" ]] || [[ ! -d "$PROJ_DIR/$NAME" ]]; then
        return
    fi

    TOCD="$PROJ_DIR/$NAME"
    CMD=""
    if [[ -f "$TOCD/poetry.lock" ]]; then
        CMD="poetry run "
    elif [[ -f "$TOCD/Pipfile.lock" ]]; then
        CMD="pipenv run "
    fi
    CMD="$CMD$EDITOR"

    tmux_init -s $NAME -d $TOCD $CMD
}

function pretty_csv() {
    cat $1 | sed 's/,/ ,/g' | column -t -s, | bat
}

function pet_save_prev() {
    PREV=$(fc -lrn | head -n 1)
    sh -c "pet new `printf %q "$PREV"`"
}

function pet-select() {
    RBUFFER+=$(pet search)
    CURSOR=$#BUFFER
    zle redisplay
}
