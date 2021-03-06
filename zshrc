# -*- mode:sh -*-

setopt extendedglob

# autoload -Uz compdump

export ZPLUG_HOME="${HOME}/.zplug"
source "${ZPLUG_HOME}/init.zsh"

zplugs=()

if [[ -s "${HOME}/.zshrc.local" ]]; then
    source "${HOME}/.zshrc.local"
fi

export ZSH="${ZPLUG_HOME}/repos/robbyrussell/oh-my-zsh"

# Set ZSH_CACHE_DIR to the path where cache files should be created
# or else we will use the default cache/
if [[ -z "$ZSH_CACHE_DIR" ]]; then
  export ZSH_CACHE_DIR="$ZSH/cache"
fi

# zplug "zplug/zplug", at:"2.1.0"
# zplug "zplug/zplug", at:"master"
# zplug "zplug/zplug"
zplug "mafredri/zsh-async", at:v1.5.1, as:plugin, defer:1

# zplug "robbyrussell/oh-my-zsh", use:"oh-my-zsh.zsh", defer:2
zplug "robbyrussell/oh-my-zsh", use:"lib/*.zsh", defer:2
zplug "plugins/git", from:oh-my-zsh, if:"(( $+commands[git] ))", defer:2
zplug "plugins/osx", from:oh-my-zsh, defer:2
zplug "plugins/fasd", from:oh-my-zsh, defer:2, \
    if:"(( $+commands[fasd] ))"
zplug "plugins/bundler", from:oh-my-zsh, defer:2
zplug "plugins/docker-compose", from:oh-my-zsh, defer:2, \
    if:"(( $+commands[docker-compose] ))"
zplug "plugins/gitignore", from:oh-my-zsh, defer:2
zplug "junegunn/fzf", use:"shell/*.zsh", defer:3, if:"(( $+commands[fzf] ))", as:plugin, lazy:false
zplug "zsh-users/zsh-completions", as:plugin, defer:2

zplug "shenwei356/csvtk", from:gh-r, \
    as:command

# zplug "lukasmartinelli/pgclimb", from:gh-r, \
    # as:command

# Rehash GNU utils as default
# zplug "plugins/gnu-utils", from:oh-my-zsh, as:plugin, nice:9, hook-load:"__gnu_utils"

# zplug "plugins/git-extras", from:oh-my-zsh, if:"(( $+commands[git] ))",nice:15
# zplug "plugins/git-prompt", from:oh-my-zsh, if:"(( $+commands[git] ))", nice:15

zplug "sindresorhus/pure", defer:3

zplug "arbelt/dotzsh", use:'plugins/scmpuff.plugin.zsh', as:plugin, defer:3
zplug "arbelt/dotzsh", use:'aliases.zsh', as:plugin, defer:3
# zplug "~/.dotfiles/zsh/aliases.zsh", from:local, nice:19
# zplug "~/.fzf.zsh", from:local, defer:3, if:"[ -s ~/.fzf.zsh ]", lazy:false

zplug "simonwhitaker/gibo", use:'gibo-completion.zsh', as:plugin, \
    if:"(( $+commands[gibo] ))", defer:2

# Syntax highlighting likes to be loaded last
#
zplug "zsh-users/zsh-syntax-highlighting", defer:3

if ! zplug check; then
    zplug install
fi

zplug load

if (($+commands[gr])); then
    unalias gr
    . <(gr completion)
fi

if (($+commands[yarn])); then
    export PATH="$PATH:$(yarn global bin)"
    export PATH="$PATH:${HOME}/.config/yarn/global/node_modules/.bin"
fi

GDAL2_BIN_PATH="/usr/local/opt/gdal2/bin"
if [[ -d "$GDAL2_BIN_PATH" ]]; then
    export PATH="$GDAL2_BIN_PATH:$PATH"
fi

return 0

eval $(/usr/libexec/path_helper -s)

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
