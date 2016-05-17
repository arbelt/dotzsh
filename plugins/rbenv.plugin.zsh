# -*- mode:sh -*-

_first_existing() {
    for arg; do
        [[ -e "${arg}" ]] && echo -n "${arg}" && break
    done
}

rbenvdirs=("${HOME}/.rbenv/" "/usr/local/opt/rbenv" "/opt/rbenv")

rbenvdir=$(_first_existing $rbenvdirs[@])

if [[ ! -d "$rbenvdir" ]]; then
    exit 0
fi

export RBENV_ROOT=$rbenvdir
export PATH=${RBENV_ROOT}/bin:$PATH

eval "$(rbenv init --no-rehash - zsh)"

function rbenv_prompt_info() {
    echo "$(rbenv version-name)"
}

unset rbenvdir