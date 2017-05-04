# -*- mode:sh -*-
# vim: ft=zsh

if (($+commands[docker-machine])); then
    alias dma='eval "$(docker-machine env)"'
fi

if (($+commands[exa])); then
    alias ls='exa'
    alias l='exa -lg'
    alias la='exa -lga'
elif [[ "$(which ls)" = $commands[gls] ]]; then
    alias ls='ls -G --color=auto'
fi

if hash R >/dev/null 2>&1; then
    alias R='nocorrect command R --no-save'
fi

if hash mvim>/dev/null 2>&1; then
    alias vim='mvim -v'
fi


# Additional commands
#
function use_conda() {
    typeset -gU path
    if [[ -d "${HOME}/anaconda/bin" ]]; then
        path=("${HOME}/anaconda/bin" $path)
    fi
    export path
}

function unset_pyenv() {
    typeset -gU path
    export path=("${(@)path:#${HOME}\/.pyenv\/shims}")
}

if [[ -x "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ]]; then
    alias subl='"/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"'
fi

VSCODE_BIN="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
[[ -x "${VSCODE_BIN}" ]] && alias code="\"${VSCODE_BIN}\""

