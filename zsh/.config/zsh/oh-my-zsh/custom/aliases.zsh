alias ..='cd ..'
alias ...='cd ../..'

alias la='exa -a --color=always --group-directories-first'
alias ll='exa -l --color=always --group-directories-first'
alias lla='exa -al --color=always --group-directories-first'
alias lt='exa -aT --color=always --group-directories-first'
alias tree='exa -T --color=always'

alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'

alias dot='cd $DOT'

alias per='pipenv run'
alias por='poetry run'

alias stown='stow --no-folding -nvt ~'
alias stowv='stow --no-folding -vt ~'

alias lr='ranger'
alias lg='lazygit'

alias gcalp='gcalcli --config-folder ~/.config/gcalcli/personal'
alias gcalw='gcalcli --config-folder ~/.config/gcalcli/work'

alias dockerps='docker ps -a --format=$DOCKER_FORMAT'

alias yt_down='yt-dlp -o "~/Downloads/%(title)s.%(ext)s" -f "[ext=mp4][height<=1080]"'

alias hist="history | awk -F' ' '{ \$1=\"\"; print }' | fzf"

# HOME DIR CLEANUP
alias nvidia-settings='nvidia-settings --config="$XDG_CONFIG_HOME/nvidia/settings"'
