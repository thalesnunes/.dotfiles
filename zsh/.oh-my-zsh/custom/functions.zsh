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
