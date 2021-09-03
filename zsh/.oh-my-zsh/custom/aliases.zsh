alias python="python3"
alias pip="pip3"

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

alias dbcrawler_docker='docker run --name dbcrawler -p 8888:8888 -it -e JUPYTER_ENABLE_LAB=yes --rm -d -v ~/Projects/db-crawler:/usr/src/app -w /usr/src/app thalesnunes1/db-crawler:latest ; sleep 2 ; jupyter_url=$(docker logs dbcrawler | grep -o "http:\/\/127\.0\.0\.1:8888\/lab?token=.*" | tail -1) && google-chrome $jupyter_url </dev/null &>/dev/null & ; disown'

alias polyconfig='cd ~/.config/polybar/forest'
alias roficonfig='cd ~/.config/rofi'
alias i3config='nvim ~/.config/i3/config'
alias nvimconfig='nvim ~/.vimrc'
alias aliasconfig='nvim ~/.oh-my-zsh/custom/aliases.zsh'
alias exportconfig='nvim ~/.oh-my-zsh/custom/exports.zsh'
alias functionconfig='nvim ~/.oh-my-zsh/custom/functions.zsh'
alias tokenconfig='nvim ~/.oh-my-zsh/custom/tokens.zsh'

alias stown='stow --no-folding -nvt ~'
alias stowv='stow --no-folding -vt ~'

alias spotifydinit='systemctl --user start spotifyd.service'
alias spotifydstop='systemctl --user stop spotifyd.service'

alias gcalp='gcalcli --config-folder ~/.config/gcalcli/personal'
alias gcalw='gcalcli --config-folder ~/.config/gcalcli/work'

alias conservation_on="sudo modprobe ideapad_laptop && sudo tee /sys/bus/platform/drivers/ideapad_acpi/*/conservation_mode <<< '1'"
alias conservation_off="sudo modprobe ideapad_laptop && sudo tee /sys/bus/platform/drivers/ideapad_acpi/*/conservation_mode <<< '0'"
