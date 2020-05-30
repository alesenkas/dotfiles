export ZSH="$HOME/.oh-my-zsh"
export PLN_DIST="/dvp/planning-dist"
export JBOSS_HOME="$PLN_DIST/jboss-bas-8.2.1.krista44"

# Speeds up load time
# DISABLE_UPDATE_PROMPT=true

# Colorizing dirs & files
test -e ~/.dircolors && eval `dircolors ~/.dircolors`

ZSH_THEME="pure"
# ZSH_THEME="spy_noza"
# ZSH_THEME="robbyrussell_custom"

plugins=(
    git
    tmux
    mercurial
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

fpath=(~/.config/zsh/Completion $fpath)

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit
# End of lines added by compinstall

# Extended globbing
# Examples: 
#   ls *.(sh|config) - all files with extends sh or config
#   ** - recursive globbing wild-card, ^ - not operation
setopt extendedglob

# Select autocomplete results with keyboard arrows
setopt menucomplete
zstyle ':completion:*' menu select=1 _complete _ignored _approximate

# mistakes correction
setopt correctall

# custom completion
setopt complete_aliases
compdef _jb jb

# fzf configuration
export FZF_DEFAULT_OPTS="
--border
--color fg:102,fg+:15,bg+:#282A36
--color info:108,prompt:109,spinner:108,pointer:168,marker:168
"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# zsh-autosuggestions
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# pure theme clear screen fix
prompt_pure_clear_screen() {
	# enable output to terminal
	zle -I
	# clear screen and move cursor to (0, 0)
	print -n '\e[2J\e[0;0H'
	# print preprompt
	prompt_pure_preprompt_render precmd
}
zle -N clear-screen prompt_pure_clear_screen

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# aliasing
alias ls='ls --color=auto' # ls with typical colorizing
alias grep='grep --colour=auto' # grep with typical colorizing
alias ll='ls  -alF'
alias la='ls -A'
alias l="ls -CF"
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias mvn_prepare='mvn release:prepare --builder singlethreaded -Dit'
alias mvn_perform='mvn release:perform --builder singlethreaded -Dit'
alias mvn_version_set='mvn versions:set --builder singlethreaded -Dit -Ddocker-dev -DprocessAllModules=true -DprocessDependencies=true -DgenerateBackupPoms=false'
alias mvn_version_get='mvn -q -Dexec.executable=echo -Dexec.args='"'"'${project.version}'"'"' --non-recursive exec:exec'

alias dvp="cd /dvp"
alias src="cd /dvp/Sources"
alias devtool='bash /dvp/Install/dev-tools-gradle/bin/devtool'
alias krupd='bash $PLN_DIST/krupd'
alias jb='jb-auto'
alias chpasswd='smbpasswd -r krista.ru -U alesenkas'

alias logcl='log-in-colors'
alias jb.log='logcl -f $JBOSS_HOME/standalone/log/server.log'

alias zshconfig="vim ~/.zshrc"

# proxy
# export http_proxy='http://<login>:<password>@<proxy>:<port>/'
# export https_proxy=
# export ftp_proxy=

# enable 256 colors support in terminal
case "$TERM" in
  'xterm') TERM=xterm-256color;;
  'screen') TERM=screen-256color;;
  'Eterm') TERM=Eterm-256color;;
esac


#############################FUNCTIONS##########################################
log-in-colors() {
    local red=$(tput bold)$(tput setaf 1)
    local green=$(tput bold)$(tput setaf 2)
    local yellow=$(tput bold)$(tput setaf 3)
    local blue=$(tput bold)$(tput setaf 4)      
    local off=$(tput sgr0)

    # Make sure formatting is reset
    echo -ne ${off}

    tail $@ | sed -r "
      s/.*Replaced deployment.*/$green\\0$off/g
        s/(.*\\bERROR\\b.*)/$red\\0$off/g
      s/(.*\\bSEVERE\\b.*)/$red\\0$off/g
        s/(.*\\bWARN(ING)?\\b.*)/$yellow\\0$off/g
      s/(.*\\bDEBUG\\b.*)/$blue\\0$off/g        
      s/\(.*started in.*\)/$green\\0$off/g      
    "                  
    # Make sure formatting is reset
    echo -ne ${off}
}

jb-auto() {
    local krupd="$PLN_DIST/krupd" 
    local cmd
    cmd=$(bash $krupd -buildfile ~/.krupd.xml -p |
        awk -F " " 'NF == 1 {print $1}' |
        fzf --height 40% --query="$1" --exact --reverse --select-1 --exit-0) &&
    bash $krupd "$cmd"
}

vag() {
    local file
    local line

    read -r file line <<<"$(ag --nobreak --noheading $@ | fzf -0 -1 | awk -F: '{print $1, $2}')"

    if [[ -n $file ]]; then
        vim $file +$line
    fi    
}

tns() {
    if [ -z $1 ];then
      echo "usage: tns NEW_SESSION_NAME"
      return 1
    fi

    session_name=$1
    tmux new-session -d -s $session_name
    tmux switch-client -t "$session_name"
}

tss() {
    local session
    session=$(tmux list-sessions -F "#{session_name}" | \
      fzf --height 40% --reverse --query="$1" --select-1 --exit-0) &&
    tmux switch-client -t "$session"  
}

tks() {
    local session
    session=$(tmux list-sessions -F "#{session_name}" | \
      fzf --height 40% --reverse --query="$1" --select-1 --exit-0) &&
    tmux kill-session -t "$session"
}

hgf() {
    local rev
            
    rev=$(hg log --color=always --template "{label('custom.rev', rev)} [{label('custom.author', author)}] {splitlines(desc) % '{line} '}\n" "$@" |
          fzf --ansi --no-sort --reverse --tiebreak=index |
          awk -F " " '{print $1}')

    if [[ -n $rev ]]; then
        hg diff -c $rev
    fi    
}

pln_db_restore() {
    pg_restore  --host localhost --port 5432 --username "postgres" --no-owner --no-acl --dbname "planning" --verbose $@
ifiif}
