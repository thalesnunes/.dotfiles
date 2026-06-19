# Plugin directory
typeset -g ZSH_PLUGIN_DIR="$XDG_DATA_HOME/zsh/plugins"

# Plugin loader
function _plugin_load {
    local repo=$1 name=$2 file=$3
    local dir="$ZSH_PLUGIN_DIR/$name"
    if [[ ! -d $dir ]]; then
        git clone --depth 1 "https://github.com/$repo/$name.git" "$dir" 2>/dev/null
    fi
    if [[ -d $dir && -f $dir/$file ]]; then
        source "$dir/$file"
    fi
}


# zsh-completions -- adds completions to fpath
_plugin_load zsh-users zsh-completions zsh-completions.plugin.zsh


# zsh-autosuggestions
_plugin_load zsh-users zsh-autosuggestions zsh-autosuggestions.zsh


# FZF
eval "$(fzf --zsh)"


# fzf-tab (replaces completion menu with FZF)
_plugin_load Aloxaf fzf-tab fzf-tab.plugin.zsh

# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# Make completion case-insensitive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# Complete on empty line
zstyle ':completion:*' insert-tab false
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# To make fzf-tab follow FZF_DEFAULT_OPTS.
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# custom fzf binds
zstyle ':fzf-tab:*' fzf-bindings 'tab:toggle+down'


# Powerlevel10k prompt theme
_plugin_load romkatv powerlevel10k powerlevel10k.zsh-theme


# Ensure curl_templates dir is in fpath before compinit (for ct completion)
export CT_TEMPLATES_DIR="$XDG_DATA_HOME/zsh/curl_templates"
[[ -d $CT_TEMPLATES_DIR ]] && fpath=("$CT_TEMPLATES_DIR" $fpath)


# compinit
autoload -Uz compinit
compinit -d "$ZSH_COMPDUMP"
compdef _ct ct


# fast-syntax-highlighting -- must be last plugin loaded
_plugin_load z-shell fast-syntax-highlighting fast-syntax-highlighting.plugin.zsh


# zsh-history-substring-search
_plugin_load zsh-users zsh-history-substring-search zsh-history-substring-search.zsh

# Clear autosuggestions on history search
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-substring-search-up history-substring-search-down)


# Powerlevel10k config
source "$ZDOTDIR/.p10k.zsh"
