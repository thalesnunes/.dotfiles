# Home dir cleanup
mkdir -p "$XDG_CACHE_HOME"/zsh
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="${XDG_CONFIG_HOME:-$HOME/.config}/zsh/oh-my-zsh"

# Themeing
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE="nerdfont-complete"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git zsh-autosuggestions zsh-syntax-highlighting poetry)

export KEYTIMEOUT=1

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f "$XDG_CONFIG_HOME/zsh/p10k.zsh" ]] || source "$XDG_CONFIG_HOME/zsh/p10k.zsh"
# source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
