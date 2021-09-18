function gi() {
    curl -sL https://www.toptal.com/developers/gitignore/api/$@ >> .gitignore ;
}

function create() {
    cd ~/Projects/Project_Initializer/
    pipenv run python3 ~/Projects/Project_Initializer/create.py $@
    cd "$OLDPWD"
}

function dbcrawler_docker() {
    docker run --name dbcrawler -p 8888:8888 -it -e JUPYTER_ENABLE_LAB=yes \
        --rm -d -v ~/Projects/db-crawler:/usr/src/app -w /usr/src/app \
        thalesnunes1/db-crawler:latest &&
    sleep 2 &&
    jupyter_url=$(docker logs dbcrawler | grep -o "http:\/\/127\.0\.0\.1:8888\/lab?token=.*" | tail -1) &&
    google-chrome $jupyter_url &!
}

function config() {
    DOT="$HOME/.dotfiles"
    TOCD=$DOT
    FILE=""
    PROG=$1
    case $PROG in
        bin)
            TOCD="$DOT/bin/.local/bin"
            FILE=""
            ;;
        poly*)
            TOCD="$DOT/polybar/.config/polybar/forest"
            FILE=""
            ;;
        ali*)
            TOCD="$DOT/zsh/.oh-my-zsh/custom"
            FILE="aliases.zsh"
            ;;
        func*)
            TOCD="$DOT/zsh/.oh-my-zsh/custom"
            FILE="functions.zsh"
            ;;
        exp*)
            TOCD="$DOT/zsh/.oh-my-zsh/custom"
            FILE="exports.zsh"
            ;;
        tok*)
            TOCD="$DOT/zsh/.oh-my-zsh/custom"
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

    PROJ=$PROJECTS
    if [[ $# -eq 1 ]]; then
        TOCD=$1
    else
        TOCD=$(ls -1q $PROJ | fzf)
    fi

    if [[ -z "$TOCD" ]]; then
        exit 0
    fi

    TOCD="$PROJ/$TOCD"
    CMD=""
    if [[ -f "$TOCD/poetry.lock" ]]; then
        CMD="poetry run "
    elif [[ -f "$TOCD/Pipfile.lock" ]]; then
        CMD="pipenv run "
    fi
    CMD="$CMD$EDITOR"

    selected_name=$(basename "$TOCD" | tr . _)
    case $selected_name in
        db-crawler)
            selected_name="crawler"
            ;;
        gcal_notifier)
            selected_name="gcal"
            ;;
        labidw-*)
            selected_name="lambda"
            ;;
    esac

    tmux_running=$(pgrep tmux)
    if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
        tmux new-session -s $selected_name -c $TOCD $CMD
        exit 0
    fi

    if ! tmux has-session -t $selected_name 2> /dev/null; then
        tmux new-session -ds $selected_name -c $TOCD $CMD
    fi

    if [[ -z $TMUX ]]; then
        tmux attach-session -t $selected_name
    else
        tmux switch-client -t $selected_name
    fi
}
