
if (($+commands[scmpuff])); then
    eval "$(scmpuff init --aliases=false -s)"
    alias gs='scmpuff_status'
fi
