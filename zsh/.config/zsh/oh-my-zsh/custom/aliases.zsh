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
alias projw='proj w'

alias per='pipenv run'
alias por='poetry run'

alias stown='stow --no-folding -nvt ~'
alias stowv='stow --no-folding -vt ~'

alias lr='ranger'
alias lg='lazygit'

alias gcalp='gcalcli --config-folder ~/.config/gcalcli/personal'
alias gcalw='gcalcli --config-folder ~/.config/gcalcli/work'

alias conservation_on="sudo modprobe ideapad_laptop && sudo tee /sys/bus/platform/drivers/ideapad_acpi/*/conservation_mode <<< '1'"
alias conservation_off="sudo modprobe ideapad_laptop && sudo tee /sys/bus/platform/drivers/ideapad_acpi/*/conservation_mode <<< '0'"

alias brim='setxkbmap "brim" -option -print | xkbcomp -w 0 -I"$HOME/.config/xkb" - "$DISPLAY"'
alias dockerps='docker ps -a --format=$DOCKER_FORMAT'

alias yt_down='yt-dlp -o "~/Downloads/%(title)s.%(ext)s" -f "[ext=mp4][height<=1080]"'

alias hist="history | awk -F' ' '{ \$1=\"\"; print }' | fzf --tac --no-sort"

alias snowsql='i3-msg workspace "2:Work" > /dev/null; $XDG_USER_BIN/snowsql'

# HOME DIR CLEANUP
alias nvidia-settings='nvidia-settings --config="$XDG_CONFIG_HOME/nvidia/settings"'
