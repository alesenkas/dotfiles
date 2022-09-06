ls-visible() {
    zle kill-whole-line
    echo ""
    exa -hgl --icons
    zle accept-line
}
zle -N ls-visible

tree-visible-2() {
    zle kill-whole-line
    echo ""
    exa -T -L2 --icons
    zle accept-line
}
zle -N tree-visible-2

ls-all() {
    zle kill-whole-line
    echo ""
    exa -ahgl --icons    
    zle accept-line
}
zle -N ls-all

tree-all-2() {
    zle kill-whole-line
    echo ""
    exa -aT -L2 --icons
    zle accept-line
}
zle -N tree-all-2

bindkey '^F' ls-visible
bindkey '\ef' tree-visible-2
bindkey '^K' ls-all
bindkey '\ek' tree-all-2

