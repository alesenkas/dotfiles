############## COMMON ##############

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

vag() {
    local file
    local line

    read -r file line <<<"$(ag --nobreak --noheading $@ | fzf -0 -1 | awk -F: '{print $1, $2}')"

    if [[ -n $file ]]; then
        vim $file +$line
    fi    
}


############## TMUX ##############

tns() {
    if [ -z $1 ];then
      echo "usage: tns NEW_SESSION_NAME"
      return 1
    fi

    session_name=$1
    tmux new-session -d -s $session_name
    tmux switch-client -t "$session_name" &>/dev/null || tmux attach-session -t "$session_name"  
}

tss() {
    local session
    session=$(tmux list-sessions -F "#{session_name}" | \
      fzf --height 40% --reverse --query="$1" --select-1 --exit-0) &&
    tmux switch-client -t "$session" &>/dev/null || tmux attach-session -t "$session" 
}

tks() {
    local session
    session=$(tmux list-sessions -F "#{session_name}" | \
      fzf --height 40% --reverse --query="$1" --select-1 --exit-0) &&
    tmux kill-session -t "$session"
}


############## HG ##############

hgf() {
    local rev
            
    rev=$(hg log --color=always --template "{label('custom.rev', rev)} [{label('custom.author', author)}] {splitlines(desc) % '{line} '}\n" "$@" |
          fzf --ansi --no-sort --reverse --tiebreak=index |
          awk -F " " '{print $1}')

    if [[ -n $rev ]]; then
        hg diff -c $rev
    fi    
}