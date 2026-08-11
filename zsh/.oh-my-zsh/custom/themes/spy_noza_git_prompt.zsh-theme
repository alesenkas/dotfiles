local ret_status="%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})"


# show up to 3 parent dirs, except ~, resolve all other dir aliases
function collapse_pwd {
    local curr_pwd=$(pwd | sed -e "s,^$HOME,~,")
    local relevant_slashes=$(expr $(echo $curr_pwd| tr -d -c /|wc -c) - 1)
    echo $curr_pwd| cut -d / -f$(($relevant_slashes>0?$relevant_slashes:1))-
}

PROMPT='%{${fg_bold[cyan]}%}$(collapse_pwd) $(git_super_status)$(hg_prompt_info)${ret_status}%{${reset_color}%} '

# %{\e[1 q%} restore cursor shape and behavior (blinking block)
PROMPT=$'%{\e[1 q%}'$PROMPT
RPROMPT=''

# RPS1="${ret_status}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}[ %{$fg[magenta]%} "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[blue]%}] %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SEPARATOR=""
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[yellow]%}%{|󰕚 %G%}"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[red]%}%{| %G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[blue]%}%{|󰎂 %G%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[blue]%}%{|- %G%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{↓%G%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{↑%G%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%}%{|? %G%}"
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg_bold[blue]%}%{|󱃭 %G%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}%{  %G%}"
ZSH_THEME_GIT_PROMPT_UPSTREAM_SEPARATOR="->"
# ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%} %{$fg[yellow]%}󰕚 %{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}"

ZSH_THEME_HG_PROMPT_PREFIX="%{$fg_bold[blue]%}[󰴻 %{$fg[magenta]%} "
ZSH_THEME_HG_PROMPT_SUFFIX="%{$fg_bold[blue]%}] %{$reset_color%}"
ZSH_THEME_HG_PROMPT_DIRTY="%{$fg[blue]%} %{$fg[yellow]%}󰕚 %{$reset_color%}"
ZSH_THEME_HG_PROMPT_CLEAN="%{$fg[blue]%}"


