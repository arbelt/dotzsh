
_scmpuff_installed() {
    hash scmpuff >/dev/null 2>&1
}

if _scmpuff_installed; then
    eval "$(scmpuff init - )"
fi
