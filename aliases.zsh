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

