# Options
setopt glob_dots
setopt numeric_glob_sort
setopt no_auto_menu
setopt no_beep
setopt append_history
setopt extended_history
setopt hist_no_store
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt share_history

# History
HISTFILE="$XDG_STATE_HOME/zsh/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

# Completion cache
ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump-$HOST"

# Source imports (includes private: tokens, private_aliases, private_functions)
for file in "$ZDOTDIR"/imports/*(ND); do
    source "$file"
done
