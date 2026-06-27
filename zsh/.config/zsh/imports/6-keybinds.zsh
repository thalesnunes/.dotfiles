######## Key bindings ##########
# Ensure emacs keymap (no vi)
bindkey -e

# Home
bindkey "${terminfo[khome]}" beginning-of-line
bindkey '\e[1~' beginning-of-line
bindkey '\e[H' beginning-of-line
bindkey '\eOH' beginning-of-line

# End
bindkey "${terminfo[kend]}" end-of-line
bindkey '\e[4~' end-of-line
bindkey '\e[F' end-of-line
bindkey '\eOF' end-of-line

# Ctrl+Backspace (sends ^H in foot)
bindkey '^H' backward-kill-word

# Delete (erase next char)
bindkey "${terminfo[kdch1]}" delete-char
bindkey '\e[3~' delete-char

# Ctrl+Delete (erase next word)
bindkey '\e[3;5~' kill-word     # Standard xterm/foot sequence
bindkey '\e[3^' kill-word       # Alternative fallback

# Up / Down for history substring search
bindkey "${terminfo[kcuu1]}" history-substring-search-up
bindkey "${terminfo[kcud1]}" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down

# Alt+i opens current command in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^[i' edit-command-line

# Ctrl+s searches pet snippets (function defined in imports/2-functions.zsh)
zle -N pet-select
[[ -o interactive && -n $TTY ]] && stty -ixon <$TTY >$TTY
bindkey '^s' pet-select
