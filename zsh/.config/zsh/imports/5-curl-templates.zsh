export CT_TEMPLATES_DIR="$XDG_DATA_HOME/zsh/curl_templates"
fpath=("$CT_TEMPLATES_DIR" $fpath)
compdef _ct ct
