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
        ${EDITOR:-nvim} $file +$line
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

############## VCS ##############

start_thg() {
    if [[ $(ps|grep "thg") ]]; then
        \thg
    else
        ((\thg>/dev/null 2&>/dev/null) &)
    fi
}

chstat() {
    for dir in *(/); do
        if [[ -d "$dir/.hg" ]]; then
            ch=$(hg status $dir | wc -c)
            if [[ $ch > 0 ]]; then
                echo $fg_bold[yellow]"hg: "$fg_bold[green]$dir$reset_color
                hg status $dir | cat
                echo ""
            fi
        fi
        if [[ -d "$dir/.git" ]]; then
            ch=$(git -C $dir status --porcelain | wc -c)
            if [[ $ch > 0 ]]; then
                echo $fg_bold[yellow]"git: "$fg_bold[green]$dir$reset_color
                git -C $dir status --short
                echo ""
            fi
        fi
    done
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

gitf() {
    local commit
    commit=$(git log --graph --color=always --pretty="format:%C(yellow)%h%C(reset) [%C(#06989A)%an <%ae>%C(reset)%C(#555753)..%as%C(reset)] %s" "$@" |
             fzf --ansi --no-sort --reverse --tiebreak=index --preview-window=down:hidden --preview="(echo {} | grep -o '[a-f0-9]\{7\}') && (echo {} | grep -o '[a-f0-9]\{7\}' | xargs git show --name-status | batcat --color=always)" --bind 'alt-v:toggle-preview' |
             grep -o '[a-f0-9]\{7\}' |
             head -1)

    if [[ -n $commit ]]; then
        git show $commit
    fi
}

