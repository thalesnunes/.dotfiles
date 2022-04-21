alias ..='cd ..'
alias ...='cd ../..'

alias la='exa -a --color=always --group-directories-first'
alias ll='exa -l --color=always --group-directories-first'
alias lla='exa -al --color=always --group-directories-first'
alias lt='exa -aT --color=always --group-directories-first'
alias tree='exa -T --color=always'

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
