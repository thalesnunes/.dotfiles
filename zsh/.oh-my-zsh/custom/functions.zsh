function gi() { curl -sL https://www.toptal.com/developers/gitignore/api/$@ > .gitignore ;}

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
