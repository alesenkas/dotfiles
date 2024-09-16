#!/bin/bash

function _info {
    echo "$(tput setaf 2)$1$(tput sgr0)"
}

function _notify {
    echo "$(tput setaf 3)$1$(tput sgr0)"
}

function _ex {
    echo "$(tput setaf 1)$1$(tput sgr0)"
    exit 1
}

function _rmf {
    path=$1
    if [[ -f $path ]]; then
        rm $path
        _notify "remove file \"$path\""
    fi
}

function _rmd {
    path=$1
    if [[ -e $path ]]; then
        rm -rf $path
        _notify "remove directory \"$path\""
    fi
}

function _cleanup {
    _info "CLEANUP"

    _rmf "$HOME/.dircolors"

    _rmf "$HOME/.tmux.conf"
    _rmd "$HOME/.tmux"

    _rmd "$HOME/.vim"

    _rmf "$HOME/.config/xfce4/terminal/terminalrc"
    _rmd "$HOME/.local/share/xfce4/terminal/colorschemes"

    _rmd "$HOME/.config/zsh"
    _rmd "$HOME/.oh-my-zsh/custom/themes"
    _rmf "$HOME/.zshrc"

    _rmd "$HOME/.config/nvim"
    _rmd "$HOME/.config/bat"
    _rmd "$HOME/.config/git"
    _rmd "$HOME/.config/ideavim"
    _rmf "$HOME/.config/sublime-text-3/Packages/User/Preferences.sublime-settings"

}

function _install_default_env {
    _cleanup

    _info "INSTALL DEFAULT ENVIRONMENT"

    _info "Dircolors"
    ln -sv "$PWD/other/.dircolors" "$HOME/.dircolors"

    _info "Tmux"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    ln -sv "$PWD/tmux/.tmux.conf" "$HOME/.tmux.conf"

    _info "Vim"
    mkdir -p "$HOME/.vim"
    ln -sv "$PWD/.vim/ftdetect" "$HOME/.vim/ftdetect"
    ln -sv "$PWD/.vim/ident" "$HOME/.vim/ident"
    ln -sv "$PWD/.vim/syntax" "$HOME/.vim/syntax"
    ln -sv "$PWD/.vim/vimrc" "$HOME/.vim/vimrc"


    _info "Xfce4 terminal"
    mkdir -p "$HOME/.config/xfce4/terminal"
    ln -sv "$PWD/xfce4-terminal/terminalrc" "$HOME/.config/xfce4/terminal/terminalrc"
    mkdir -p "$HOME/.local/share/xfce4/terminal"
    ln -sv "$PWD/xfce4-terminal/themes" "$HOME/.local/share/xfce4/terminal/colorschemes"

    _info "ZSH"
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        _ex "required installing oh-my-zsh"
    fi
    mkdir -p "$HOME/.oh-my-zsh/custom"
    ln -sv "$PWD/zsh/.oh-my-zsh/custom/themes" "$HOME/.oh-my-zsh/custom/themes"
    mkdir -p "$HOME/.config/zsh"
    ln -sv "$PWD/zsh/config/common" "$HOME/.config/zsh/common"
    ln -sv "$PWD/zsh/config/completion" "$HOME/.config/zsh/completion"
    ln -sv "$PWD/zsh/.zshrc" "$HOME/.zshrc"

    _info "Nvim"
    ln -sv "$PWD/config/nvim" "$HOME/.config"

    _info "Bat"
    ln -sv "$PWD/config/bat" "$HOME/.config"

    _info "Git"
    ln -sv "$PWD/config/git" "$HOME/.config"

    _info "IdeaVim"
    ln -sv "$PWD/config/ideavim" "$HOME/.config"

    _info "Zed"
    ln -sv "$PWD/config/zed" "$HOME/.config"

    _info "Sublime Text"
    mkdir -p "$HOME/.config/sublime-text-3/Packages/User"
    ln -sv "$PWD/config/sublime-text/Packages/User/Preferences.sublime-settings" "$HOME/.config/sublime-text-3/Packages/User/Preferences.sublime-settings"
}

function _install_work_env {
    _cleanup
    _install_default_env

    _info "INSTALL WORK ENVIRONMENT"

    mkdir -p "$HOME/.config/zsh/work"
    cp "$PWD/zsh/config/work/env.zsh" "$HOME/.config/zsh/work/env.zsh"
    ln -sv "$PWD/zsh/config/work/aliases.zsh" "$HOME/.config/zsh/work/aliases.zsh"
    ln -sv "$PWD/zsh/config/work/functions.zsh" "$HOME/.config/zsh/work/functions.zsh"
    ln -sv "$PWD/zsh/config/work_completion" "$HOME/.config/zsh/work_completion"
}


MODE=$1

case "$MODE" in
    "cleanup")
        _cleanup
    ;;
    "work")
        _install_work_env
    ;;
    *)
        _install_default_env
    ;;
esac

_info "SUCCESS"
