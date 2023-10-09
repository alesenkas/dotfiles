alias ls='ls --color=auto' # ls with typical colorizing
alias grep='grep --colour=auto' # grep with typical colorizing

if type 'exa' > /dev/null; then
    export EXA_COLORS="uu=38;5;145:gu=38;5;145:un=38;5;203:gn=38;5;203"
    alias lla='exa -ahlg --icons'
    alias ll='exa -hl --icons'
    alias la='exa -a --icons'
    alias l='exa --icons'
else
    alias lla='ls -ahlF'
    alias ll='ls -hlF'
    alias la='ls -A'
    alias l="ls -CF"
fi

if type 'batcat' > /dev/null; then
    alias bat='batcat'
fi

if type '/opt/sublime_merge/sublime_merge' > /dev/null; then
    alias sm='/opt/sublime_merge/sublime_merge'
fi

if type \thg > /dev/null; then
    alias thg='start_thg'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias mvn_prepare='mvn release:prepare --builder singlethreaded -Dit'
alias mvn_perform='mvn release:perform --builder singlethreaded -Dit'
alias mvn_version_set='mvn versions:set --builder singlethreaded -Dit -Ddocker-dev -DprocessAllModules=true -DprocessDependencies=true -DgenerateBackupPoms=false'
alias mvn_version_get='mvn -q -Dexec.executable=echo -Dexec.args='"'"'${project.version}'"'"' --non-recursive exec:exec'

alias logcl='log-in-colors'

alias localconfig="vim $ZSH_CONFIG_DIR/local.zsh"
alias zshconfig="vim ~/.zshrc"
