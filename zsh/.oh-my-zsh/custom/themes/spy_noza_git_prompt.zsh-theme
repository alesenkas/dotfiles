local ret_status="%(?:%B%F{green}%f%b:%B%F{red}%f%b)"

# show up to 3 parent dirs, except ~, resolve all other dir aliases
function collapse_pwd {
    local curr_pwd=$(pwd | sed -e "s,^$HOME,~,")
    local relevant_slashes=$(expr $(echo $curr_pwd | tr -d -c / | wc -c) - 1)
    echo $curr_pwd | cut -d / -f$(($relevant_slashes>0?$relevant_slashes:1))-
}

# restore cursor shape and behavior (blinking block)
function _reset_cursor {
    print -n '\e[1 q'
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd _reset_cursor

PROMPT='%B%F{cyan}$(collapse_pwd)%f%b $(git_super_status)$(hg_prompt_info)'"${ret_status} "
RPROMPT=''

ZSH_THEME_GIT_PROMPT_PREFIX="%B%F{blue}[ %b%F{magenta} "
ZSH_THEME_GIT_PROMPT_SUFFIX="%B%F{blue}] %f%b"
ZSH_THEME_GIT_PROMPT_SEPARATOR=""
ZSH_THEME_GIT_PROMPT_BRANCH="%B%F{magenta}"
ZSH_THEME_GIT_PROMPT_STAGED="%b%F{yellow}|󰕚 "
ZSH_THEME_GIT_PROMPT_CONFLICTS="%b%F{red}| "
ZSH_THEME_GIT_PROMPT_CHANGED="%b%F{blue}|󰎂 "
ZSH_THEME_GIT_PROMPT_DELETED="%b%F{blue}|󰧧 "
ZSH_THEME_GIT_PROMPT_BEHIND=" ↓"
ZSH_THEME_GIT_PROMPT_AHEAD=" ↑"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%b%F{cyan}| "
ZSH_THEME_GIT_PROMPT_STASHED="%B%F{blue}| "
ZSH_THEME_GIT_PROMPT_CLEAN="%B%F{green}  "
ZSH_THEME_GIT_PROMPT_UPSTREAM_SEPARATOR="->"

ZSH_THEME_HG_PROMPT_PREFIX="%B%F{blue}[󰴻 %b%F{magenta} "
ZSH_THEME_HG_PROMPT_SUFFIX="%B%F{blue}] %f%b"
ZSH_THEME_HG_PROMPT_DIRTY="%b%F{blue} %F{yellow}󰕚 %f"
ZSH_THEME_HG_PROMPT_CLEAN="%b%F{blue}"
