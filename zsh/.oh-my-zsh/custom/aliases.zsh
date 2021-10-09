alias ..='cd ..'
alias ...='cd ../..'

alias la='ls -A'
alias lla='ls -la'

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
