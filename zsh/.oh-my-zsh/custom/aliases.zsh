alias python="python3"
alias pip="pip3"

alias la="ls -A"
alias lla='ls -la'

alias aptup='sudo apt update && sudo apt upgrade'

alias docker_init='sudo systemctl start docker.socket && sudo systemctl start docker'
alias docker_stop='sudo systemctl stop docker && sudo systemctl stop docker.socket'
alias pg_init='sudo systemctl start apache2'
alias pg_stop='sudo systemctl stop apache2'

alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'

alias dot='cd /home/thales/.dotfiles'

alias dbcrawler_docker='docker run --name dbcrawler -p 8888:8888 -it -e JUPYTER_ENABLE_LAB=yes --rm -d -v ~/Projects/db-crawler:/usr/src/app -w /usr/src/app thalesnunes1/db-crawler:latest ; sleep 2 ; jupyter_url=$(docker logs dbcrawler | grep -o "http:\/\/127\.0\.0\.1:8888\/lab?token=.*" | tail -1) && google-chrome $jupyter_url </dev/null &>/dev/null & ; disown'

alias create='python3 ~/Projects/Project_Initializer/create.py'
