alias la="ls -A"
alias lla='ls -la'

alias aptup='sudo apt update && sudo apt upgrade'
alias yayup='yay -Syu'

alias dockerinit='sudo systemctl start docker.socket && sudo systemctl start docker'
alias dockerstop='sudo systemctl stop docker && sudo systemctl stop docker.socket'

alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'

alias dot='cd /home/thales/.dotfiles'

alias stown='stow --no-folding -nvt ~'
alias stowv='stow --no-folding -vt ~'

alias spotifydinit='systemctl --user start spotifyd.service'
alias spotifydstop='systemctl --user stop spotifyd.service'

alias gcalp='gcalcli --config-folder ~/.config/gcalcli/personal'
alias gcalw='gcalcli --config-folder ~/.config/gcalcli/work'
