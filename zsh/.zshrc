export ZSH="$HOME/.oh-my-zsh"

# colorizing dirs & files
test -e ~/.dircolors && eval `dircolors ~/.dircolors`

ZSH_THEME="spy_noza"

plugins=(
    git
    tmux
    mercurial
    extract
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# custom completion
fpath=(~/.config/zsh/completion $fpath)
setopt complete_aliases
if [[ -f "~/.config/zsh/work_completion" ]]; then
    fpath=(~/.config/zsh/work_completion $fpath)
    compdef _jb jb
fi

# lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

# the following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit


# extended globbing
# examples: 
#   ls *.(sh|config) - all files with extends sh or config
#   ** - recursive globbing wild-card, ^ - not operation
setopt extendedglob

# select autocomplete results with keyboard arrows
setopt menucomplete
zstyle ':completion:*' menu select=1 _complete _ignored _approximate

# mistakes correction
setopt correctall

# fzf configuration
export FZF_DEFAULT_OPTS="
--border
--color fg:102,fg+:15,bg+:#2B2B2B
--color info:108,prompt:109,spinner:108,pointer:168,marker:168
"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# zsh-autosuggestions
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# custom configurations
ZSH_CONFIG_DIR="$HOME/.config/zsh"
# local specific config
[ -f "$ZSH_CONFIG_DIR/local.zsh" ] && source "$ZSH_CONFIG_DIR/local.zsh"
# functions
[ -f "$ZSH_CONFIG_DIR/common/functions.zsh" ] && source "$ZSH_CONFIG_DIR/common/functions.zsh"
# aliasing
[ -f "$ZSH_CONFIG_DIR/common/aliases.zsh" ] && source "$ZSH_CONFIG_DIR/common/aliases.zsh"
# work env
[ -f "$ZSH_CONFIG_DIR/work/env.zsh" ] && source "$ZSH_CONFIG_DIR/work/env.zsh"
# work functions
[ -f "$ZSH_CONFIG_DIR/work/functions.zsh" ] && source "$ZSH_CONFIG_DIR/work/functions.zsh"
# work aliases
[ -f "$ZSH_CONFIG_DIR/work/aliases.zsh" ] && source "$ZSH_CONFIG_DIR/work/aliases.zsh"

# enable 256 colors support in terminal
case "$TERM" in
  'xterm') TERM=xterm-256color;;
  'screen') TERM=screen-256color;;
  'Eterm') TERM=Eterm-256color;;
esac
