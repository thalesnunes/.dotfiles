function gi() {
    curl -sL https://www.toptal.com/developers/gitignore/api/$@
}

function jupyter_docker() {
    docker run --name jupyter -p 8888:8888 -it -e JUPYTER_ENABLE_LAB=yes \
        --rm -d -v ~/Projects/db-crawler:/usr/src/app -w /usr/src/app \
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
            TOCD="$DOT/zsh/.config/oh-my-zsh/custom"
            FILE="aliases.zsh"
            ;;
        func*)
            TOCD="$DOT/zsh/.config/oh-my-zsh/custom"
            FILE="functions.zsh"
            ;;
        exp*)
            TOCD="$DOT/zsh/.config/oh-my-zsh/custom"
            FILE="exports.zsh"
            ;;
        tok*)
            TOCD="$DOT/zsh/.config/oh-my-zsh/custom"
            FILE="tokens.zsh"
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

    if [[ $# -eq 1 ]]; then
        NAME=$1
    else
        NAME=$(ls -1q $PROJECTS | fzf)
    fi

    if [[ -z "$NAME" ]] || [[ ! -d "$PROJECTS/$NAME" ]]; then
        return
    fi

    TOCD="$PROJECTS/$NAME"
    CMD=""
    if [[ -f "$TOCD/poetry.lock" ]]; then
        CMD="poetry run "
    elif [[ -f "$TOCD/Pipfile.lock" ]]; then
        CMD="pipenv run "
    fi
    CMD="$CMD$EDITOR"

    tmuxinit -s $NAME -d $TOCD $CMD
}

function pretty_csv() {
    cat $1 | sed 's/,/ ,/g' | column -t -s, | bat
}
