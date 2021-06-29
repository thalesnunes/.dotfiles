function gi() { curl -sL https://www.toptal.com/developers/gitignore/api/$@ > .gitignore ;}

function update_db() {
    cd ~/Projects/db-crawler/scripts
    echo "Running crawler-db.py"
    pipenv run python crawler-db.py
    echo "Running crawler-dias-uteis.py"
    pipenv run python crawler-dias-uteis.py
    echo "Running crawler-refresh.py"
    pipenv run python crawler-refresh.py
    echo "Finished running"
    cd ~
}
