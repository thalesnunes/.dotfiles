function gi() {
    curl -sL https://www.toptal.com/developers/gitignore/api/$@ > .gitignore ;
}

function update_db() {
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

function pg_init() {
    OS=$(lsb_release -is)
    if [[ $OS == "Ubuntu" ]]; then
        sudo systemctl start apache2;
        echo "Started successfully"
    elif [[ $OS == "ManjaroLinux" ]]; then
        docker_init
        docker start pgadmin
        echo "Started successfully"
    else
        echo "OS not supported";
    fi
}

function pg_stop() {
    OS=$(lsb_release -is)
    if [[ $OS == "Ubuntu" ]]; then
        sudo systemctl stop apache2
        echo "Stopped successfully"
    elif [[ $OS == "ManjaroLinux" ]]; then
        docker stop pgadmin
        docker_stop
        echo "Stopped successfully"
    else
        echo "OS not supported";
    fi
}
