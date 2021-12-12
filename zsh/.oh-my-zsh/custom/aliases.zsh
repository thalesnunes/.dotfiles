alias ..='cd ..'
alias ...='cd ../..'

alias la='exa -a --color=always --group-directories-first'
alias ll='exa -l --color=always --group-directories-first'
alias lla='exa -al --color=always --group-directories-first'
alias lt='exa -aT --color=always --group-directories-first'

alias aptup='sudo apt update && sudo apt upgrade'
alias yayup='yay -Syu'

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

alias conservation_on="sudo modprobe ideapad_laptop && sudo tee /sys/bus/platform/drivers/ideapad_acpi/*/conservation_mode <<< '1'"
alias conservation_off="sudo modprobe ideapad_laptop && sudo tee /sys/bus/platform/drivers/ideapad_acpi/*/conservation_mode <<< '0'"
alias brim='setxkbmap "brim" -option -print | xkbcomp -w 0 -I"$HOME/.config/xkb" - "$DISPLAY"'
