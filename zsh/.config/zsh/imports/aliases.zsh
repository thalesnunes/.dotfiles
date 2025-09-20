alias ..='cd ..'
alias ...='cd ../..'

alias la='eza -a --color=always --group-directories-first'
alias ll='eza -l --color=always --group-directories-first'
alias lla='eza -al --color=always --group-directories-first'
alias lt='eza -aT --color=always --group-directories-first'
alias tree='eza -T --color=always'

alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'

alias dot='cd $DOT'
alias idot='$DOT/install_dotfiles.sh'
alias projw='proj w'

alias per='pipenv run'
alias por='poetry run'

alias stown='stow --no-folding -nvt ~'
alias stowv='stow --no-folding -vt ~'

alias lr='ranger'
alias slr='sudo $XDG_USER_BIN/ranger'
alias lg='lazygit'

alias gcalp='gcalcli --config-folder ~/.config/gcalcli/personal'
alias gcalw='gcalcli --config-folder ~/.config/gcalcli/work'

alias conservation_on="sudo modprobe ideapad_laptop && sudo tee /sys/bus/platform/drivers/ideapad_acpi/*/conservation_mode <<< '1'"
alias conservation_off="sudo modprobe ideapad_laptop && sudo tee /sys/bus/platform/drivers/ideapad_acpi/*/conservation_mode <<< '0'"

alias brim='setxkbmap "brim" -option -print | xkbcomp -w 0 -I"$HOME/.config/xkb" - "$DISPLAY"'
alias dockerps='docker ps -a --format=$DOCKER_FORMAT'

alias yt_down='yt-dlp -o "~/Downloads/%(title)s.%(ext)s" -f "[ext=mp4][height<=1080]"'

alias hist="history | awk -F' ' '{ \$1=\"\"; print }' | fzf --tac --no-sort"

# alias snowsql='swaymsg workspace number 3 > /dev/null; strat -r ubuntu $XDG_USER_BIN/snowsql'
alias rge="rg --hidden --sort=path -g '!**/.git/**' -g '!**/deployment/**' -g '!**/archive/**' -g '!**/release/**' -g '!**/ddl/**' -i"
alias cc="unset ANTHROPIC_API_KEY && CLAUDE_CONFIG_DIR=\"$XDG_CONFIG_HOME/claude\" NODE_EXTRA_CA_CERTS='/etc/ca-certificates/trust-source/Upwork_Global_Root_CA.p11-kit' claude"

# HOME DIR CLEANUP
alias nvidia-settings='nvidia-settings --config="$XDG_CONFIG_HOME/nvidia/settings"'
