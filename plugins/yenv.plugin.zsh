# -*- mode:sh -*-

if ((! ${ASYNC_INIT_DONE})); then
    async_init
fi


_first_existing() {
    for arg; do
        [[ -e "${arg}" ]] && echo -n "${arg}" && break
    done
}

_pyenv_virtualenv_installed() {
    hash pyenv-virtualenv >/dev/null 2>&1
}

_evaluator_callback() {
    local output="$3"
    eval "${output}"
}

_find_pyenv() {
    local pyenvdirs=("${HOME}/.pyenv/" "/usr/local/opt/pyenv" "/opt/pyenv")

    local pyenvdir=$(_first_existing $pyenvdirs[@])

    if [[ ! -d "$pyenvdir" ]]; then
        return 0
    fi

    export PYENV_ROOT=$pyenvdir
    [[ -d "${PYENV_ROOT}"/bin ]] && export PATH="${PYENV_ROOT}":$PATH
    if _pyenv_virtualenv_installed; then
        echo "$(pyenv init - zsh)"
        function pyenv_prompt_info() {
            echo "$(pyenv version-name)"
        }
    fi
}

_find_rbenv() {
    rbenvdirs=("${HOME}/.rbenv/" "/usr/local/opt/rbenv" "/opt/rbenv")

    rbenvdir=$(_first_existing $rbenvdirs[@])

    if [[ ! -d "$rbenvdir" ]]; then
        return 0
    fi

    export RBENV_ROOT=$rbenvdir
    [[ -d "${RBENV_ROOT}/bin" ]] && export PATH=${RBENV_ROOT}/bin:$PATH

    hash rbenv &>/dev/null || return 0

    echo "$(rbenv init - zsh)"

    function rbenv_prompt_info() {
        echo "$(rbenv version-name)"
    }
}

_find_nodenv() {
    hash nodenv &>/dev/null && echo "$(nodenv init - zsh)"
}

async_start_worker yenv_worker -u -n
async_register_callback yenv_worker _evaluator_callback
async_job yenv_worker _find_pyenv
async_job yenv_worker _find_rbenv
async_job yenv_worker _find_nodenv

