# -*- mode:sh -*-

_first_existing() {
    for arg; do
        [[ -e "${arg}" ]] && echo -n "${arg}" && break
    done
}

_pyenv_virtualenv_installed() {
    hash pyenv-virtualenv >/dev/null 2>&1
}

pyenvdirs=("${HOME}/.pyenv/" "/usr/local/opt/pyenv" "/opt/pyenv")

pyenvdir=$(_first_existing $pyenvdirs[@])

if [[ ! -d "$pyenvdir" ]]; then
    exit 0
fi

PYENV_ROOT=$pyenvdir
export PATH=${PYENV_ROOT}/bin:$PATH

eval "$(pyenv init --no-rehash - zsh)"

if _pyenv_virtualenv_installed; then
    eval "$(pyenv virtualenv-init --no-rehash - zsh)"
fi

function pyenv_prompt_info() {
    echo "$(pyenv version-name)"
}

unset pyenvdir
