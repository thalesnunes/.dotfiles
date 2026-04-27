# curl_templates

Local Zsh-based curl template runner created from `../curl.txt`.

## Files

- `ct`: main runner (`list`, `run`, `pick`, `help`)
- `common.zsh`: shared helper functions
- `tpl-*.zsh`: one executable script per curl command type

## Prerequisites

- `zsh`
- `jq`
- `fzf` (only for interactive `pick`)

## Usage

```bash
# list templates
./curl_templates/ct list

# run by name
./curl_templates/ct run ttd-single-agent-ask stg "what is gsv?"

# interactive picker
./curl_templates/ct pick

# template-specific help
./curl_templates/ct help timbr-answer
```

## Optional shell integration

Add this to `~/.zshrc`:

```zsh
CT_TEMPLATES_DIR="/home/thales/work_projects/talk-to-data-single-agent/curl_templates"
alias ct="$CT_TEMPLATES_DIR/ct"
```

Then restart shell and run:

```bash
ct list
ct pick
```

## Zsh completion

Add this after your `ct` alias in `~/.zshrc`:

```zsh
# adjust this path if you move curl_templates elsewhere
CT_TEMPLATES_DIR="/home/thales/work_projects/talk-to-data-single-agent/curl_templates"
fpath=("$CT_TEMPLATES_DIR" $fpath)

# if your shell already runs compinit, keep only the compdef line
autoload -Uz compinit
compinit
compdef _ct ct
```

Open a new shell (or `source ~/.zshrc`) and test:

```bash
ct <TAB>
ct run <TAB>
ct help <TAB>
```
