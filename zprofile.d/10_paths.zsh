
if [[ -x "/usr/libexec/path_helper" ]]; then
    PATH=""
    MANPATH=""
    eval "$(/usr/libexec/path_helper -s)"
fi

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

path=(
    # "/Applications/LibreOffice.app/Contents/MacOS"
    "$HOME/bin"
    "$HOME/.cabal/bin"
    "$HOME/.cask/bin"
    "$HOME/.cargo/bin"
    # "$HOME/.evm/bin"
    "$HOME/scripts"
    "/Applications/git-annex.app/Contents/MacOS"
    # "/Applications/Racket v6.0/bin"
    "/opt/stata12"
    /usr/local/{bin,sbin}
    $path
)

# path=($^path(N))

export path

