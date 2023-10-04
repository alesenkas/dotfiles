local ret_status="%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})"


# show up to 3 parent dirs, except ~, resolve all other dir aliases
function collapse_pwd {
    local curr_pwd=$(pwd | sed -e "s,^$HOME,~,")
    local relevant_slashes=$(expr $(echo $curr_pwd| tr -d -c /|wc -c) - 1)
    echo $curr_pwd| cut -d / -f$(($relevant_slashes>0?$relevant_slashes:1))-
}

PROMPT='%{${fg_bold[cyan]}%}$(collapse_pwd) $(git_prompt_info)$(hg_prompt_info)${ret_status}%{${reset_color}%} '

# RPS1="${ret_status}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}[ git:%{$fg[magenta]%} "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[blue]%}] %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%} %{$fg[yellow]%}󰕚 %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}"

ZSH_THEME_HG_PROMPT_PREFIX="%{$fg_bold[blue]%}[󰴻 hg:%{$fg[magenta]%} "
ZSH_THEME_HG_PROMPT_SUFFIX="%{$fg_bold[blue]%}] %{$reset_color%}"
ZSH_THEME_HG_PROMPT_DIRTY="%{$fg[blue]%} %{$fg[yellow]%}󰕚 %{$reset_color%}"   
ZSH_THEME_HG_PROMPT_CLEAN="%{$fg[blue]%}"
