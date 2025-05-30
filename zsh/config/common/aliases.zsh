alias ls='ls --color=auto' # ls with typical colorizing
alias grep='grep --colour=auto' # grep with typical colorizing

if type 'eza' > /dev/null; then
    export EZA_COLORS="uu=38;5;145:gu=38;5;145:un=38;5;203:gn=38;5;203"
    alias lla='eza -ahlg --icons'
    alias ll='eza -hl --icons'
    alias la='eza -a --icons'
    alias l='eza --icons'
else
    alias lla='ls -ahlF'
    alias ll='ls -hlF'
    alias la='ls -A'
    alias l="ls -CF"
fi

if type 'ncdu' > /dev/null; then
    alias du='ncdu --color dark'
fi

if type 'nvim' > /dev/null; then
    alias vim='nvim'
fi

if type 'neovide' > /dev/null; then
    alias nvd='neovide'
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

if type 'yazi' > /dev/null; then
    alias y='yazi_wrapper'
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
