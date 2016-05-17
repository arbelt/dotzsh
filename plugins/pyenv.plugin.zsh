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
    export PATH=${PYENV_ROOT}/bin:$PATH
    if _pyenv_virtualenv_installed; then
        echo "PYENV_ROOT=${PYENV_ROOT}"
        echo "$(pyenv init --no-rehash - zsh)"
        function pyenv_prompt_info() {
            echo "$(pyenv version-name)"
        }
    fi
}

async_start_worker pyenv_worker -u -n
async_register_callback pyenv_worker _evaluator_callback
async_job pyenv_worker _find_pyenv

