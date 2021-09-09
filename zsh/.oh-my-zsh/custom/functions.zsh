function gi() {
    curl -sL https://www.toptal.com/developers/gitignore/api/$@ >> .gitignore ;
}

function updatedb() {
    # cd ~/Projects/db-crawler/scripts
    # for file in `ls | sort`;
    # do
    #     echo "Running $file"
    #     pipenv run python "$file"
    # done
    # echo "Finished running"
    # cd ~
    cd ~/Projects/db-crawler
    echo "Starting daily update"
    for file in `ls -1 scripts | sed -e 's/\..*$//'`;
    do
        echo "\nRunning $file";
        pipenv run python -c "from scripts import $file";
    done
    echo "\nFinished updating"
    cd "$OLDPWD"
}

function dolph() {
    dolphin $@ &!
}

function pginit() {
    OS=$(lsb_release -is)
    case $OS in
        Ubuntu)
            sudo systemctl start apache2;
            echo "Started successfully"
            google-chrome-stable 'localhost/pgadmin4' &!
            ;;
        ManjaroLinux)
            dockerinit
            docker start pgadmin
            echo "Started successfully"
            sleep 1
            google-chrome-stable 'localhost' &!
            ;;
        *)
            echo "OS not supported"
            ;;
    esac
}

function pgstop() {
    OS=$(lsb_release -is)
    case $OS in
        Ubuntu)
            sudo systemctl stop apache2
            echo "Stopped successfully"
            ;;
        ManjaroLinux)
            docker stop pgadmin
            dockerstop
            echo "Stopped successfully"
            ;;
        *)
            echo "OS not supported"
            ;;
    esac
}

function create() {
    cd ~/Projects/Project_Initializer/
    pipenv run python3 ~/Projects/Project_Initializer/create.py $@
    cd "$OLDPWD"
}

function gcala() {
    args=$@
    for dir in ~/.config/gcalcli/*/; do
        gcalcli --config-folder $dir $args;
    done
}

function dbcrawler() {
    cd ~/Projects/db-crawler
    terminal -e jupyter console --kernel=dbcrawler
    pipenv run nvim
    cd "$OLDPWD"
}

function dbconsole() {
    cd ~/Projects/db-crawler
    jupyter console --kernel=dbcrawler
}

function dbcrawler_docker() {
    docker run --name dbcrawler -p 8888:8888 -it -e JUPYTER_ENABLE_LAB=yes \
        --rm -d -v ~/Projects/db-crawler:/usr/src/app -w /usr/src/app \
        thalesnunes1/db-crawler:latest
    sleep 2
    jupyter_url=$(docker logs dbcrawler | grep -o "http:\/\/127\.0\.0\.1:8888\/lab?token=.*" | tail -1)
    google-chrome $jupyter_url &!
}

function config() {
    DOT="$HOME/.dotfiles"
    TOCD=$DOT
    FILE=""
    PROG=$1
    case $PROG in
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
                        files=$(ls -1q $TOCD)
                        if [ $(echo $files | wc -l) -eq 1 ]; then
                            FILE=$files
                        fi
                    fi
                fi
            fi
            ;;
    esac
    cd $TOCD
    nvim $FILE
    cd "$OLDPWD"
}
