export GOPATH="${HOME}/go"

path=(
    "${GOPATH}/bin"
    $path
    /usr/local/opt/go/libexec/bin
)

# path=($^path(N))

export path

