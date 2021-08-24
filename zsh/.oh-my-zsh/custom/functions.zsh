function gi() {
    curl -sL https://www.toptal.com/developers/gitignore/api/$@ >> .gitignore ;
}

function updatedb() {
    cd ~/Projects/db-crawler/scripts
    for file in `ls | sort`;
    do
        echo "Running $file"
        pipenv run python "$file"
    done
    echo "Finished running"
    cd ~
}

function dolph() {
    dolphin $@ &!
}

function pginit() {
    OS=$(lsb_release -is)
    if [[ $OS == "Ubuntu" ]]; then
        sudo systemctl start apache2;
        echo "Started successfully"
        google-chrome-stable 'localhost/pgadmin4' &!
    elif [[ $OS == "ManjaroLinux" ]]; then
        dockerinit
        docker start pgadmin
        echo "Started successfully"
        sleep 1
        google-chrome-stable 'localhost' &!
    else
        echo "OS not supported";
    fi
}

function pgstop() {
    OS=$(lsb_release -is)
    if [[ $OS == "Ubuntu" ]]; then
        sudo systemctl stop apache2
        echo "Stopped successfully"
    elif [[ $OS == "ManjaroLinux" ]]; then
        docker stop pgadmin
        dockerstop
        echo "Stopped successfully"
    else
        echo "OS not supported";
    fi
}

function create() {
    cd ~/Projects/Project_Initializer/
    pipenv run python3 ~/Projects/Project_Initializer/create.py $@
    cd ~
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
    pipenv run nvim .
}
