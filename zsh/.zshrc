export ZSH="$HOME/.oh-my-zsh"

# colorizing dirs & files
test -e ~/.dircolors && eval `dircolors ~/.dircolors`

ZSH_THEME="spy_noza"

plugins=(
    git
    tmux
    mercurial
    extract
    clipboard
    rust
    fzf-tab
    zsh-autosuggestions
    fast-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# custom completion
fpath=(~/.config/zsh/completion $fpath)
setopt complete_aliases
if [[ -d "$HOME/.config/zsh/work_completion" ]]; then
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

# fzf-tab autocomplete
#
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# not show zsh completion menu
zstyle ':completion:*' menu no
# set fzf-tab completion menu min height
zstyle ':fzf-tab:complete:*' fzf-min-height 15
# complete preview
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --tree --level=3 --color=always --icons --group-directories-first $realpath'
zstyle ':fzf-tab:complete:*' fzf-preview '([[ -d $realpath ]] && eza -1 --color=always --icons --group-directories-first $realpath) \
    || ([[ -f $realpath && $(file --brief --mime $realpath) == *image/* ]] && chafa -s ${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES} $realpath) \
    || ([[ -f $realpath && -r $realpath ]] && batcat --decorations=always --style="header" --color=always --line-range=:500 $realpath)'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview '[[ $group == "[process ID]" ]] \
    && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap
zstyle ':fzf-tab:complete:git:*' fzf-flags --preview-window=hidden
zstyle ':fzf-tab:complete:*:options' fzf-flags --preview-window=hidden
zstyle ':fzf-tab:complete:*:argument-1' fzf-flags --preview-window=hidden

# use FZF_DEFAULT_OPTS
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

# mistakes correction
setopt correctall

# start ssh-agent
if [[ -x "$(command -v keychain)" ]]; then
    eval $(keychain --eval --quiet github)
fi

# fzf configuration
export FZF_DEFAULT_OPTS="
--border
--color fg:102,fg+:15,bg+:#282828
--color info:108,prompt:109,spinner:108,pointer:168,marker:168
"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zsh-autosuggestions
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# nvm
export NVM_DIR="$HOME/.nvm"
export NVM_SYMLINK_CURRENT=true
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# sdkman
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# zoxide
if type 'zoxide' > /dev/null; then
  eval "$(zoxide init zsh)"
fi

# custom configurations
ZSH_CONFIG_DIR="$HOME/.config/zsh"
# local specific config
[ -f "$ZSH_CONFIG_DIR/local.zsh" ] && source "$ZSH_CONFIG_DIR/local.zsh"
# env
[ -f "$ZSH_CONFIG_DIR/common/env.zsh" ] && source "$ZSH_CONFIG_DIR/common/env.zsh"
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

# open the current command in $EDITOR
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^X' edit-command-line
