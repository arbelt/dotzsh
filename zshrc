# -*- mode:sh -*-

setopt extendedglob

# autoload -Uz compdump

export ZPLUG_HOME="${HOME}/.zplug"
source "${ZPLUG_HOME}/init.zsh"

export ZSH="${ZPLUG_HOME}/repos/robbyrussell/oh-my-zsh"

# Set ZSH_CACHE_DIR to the path where cache files should be created
# or else we will use the default cache/
if [[ -z "$ZSH_CACHE_DIR" ]]; then
  export ZSH_CACHE_DIR="$ZSH/cache"
fi

zplug "zplug/zplug", at:"2.1.0"
zplug "mafredri/zsh-async", nice:11

# zplug "robbyrussell/oh-my-zsh", use:"oh-my-zsh.zsh", nice:-10
zplug "robbyrussell/oh-my-zsh", use:"lib/*.zsh", nice:14, ignore:"oh-my-zsh.zsh"
zplug "plugins/git", from:oh-my-zsh, if:"(( $+commands[git] ))", nice:15
zplug "plugins/osx", from:oh-my-zsh, nice:15
zplug "plugins/fasd", from:oh-my-zsh, nice:15, \
    if:"(( $+commands[fasd] ))"
zplug "plugins/bundler", from:oh-my-zsh, nice:15
zplug "plugins/docker-compose", from:oh-my-zsh, nice:15, \
    if:"(( $+commands[docker-compose] ))"
zplug "junegunn/fzf", use:"shell/*.zsh", nice:15, if:"(( $+commands[fzf] ))"
# zplug "zsh-users/zsh-completions", as:plugin, nice:15

# Rehash GNU utils as default
# zplug "plugins/gnu-utils", from:oh-my-zsh, as:plugin, nice:9, hook-load:"__gnu_utils"

# zplug "plugins/git-extras", from:oh-my-zsh, if:"(( $+commands[git] ))",nice:15
# zplug "plugins/git-prompt", from:oh-my-zsh, if:"(( $+commands[git] ))", nice:15

zplug "sindresorhus/pure", nice:16

zplug "arbelt/dotzsh", use:'plugins/*.zsh', as:plugin, nice:12
zplug "arbelt/dotzsh", use:'aliases.zsh', as:plugin, nice:19
# zplug "~/.dotfiles/zsh/aliases.zsh", from:local, nice:19

# Syntax highlighting likes to be loaded last
#
zplug "zsh-users/zsh-syntax-highlighting", nice:17

if ! zplug check; then
    zplug install
fi

zplug load

if (($+commands[gr])); then
    unalias gr
    . <(gr completion)
fi

return 0

