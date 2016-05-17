if ((! ${ASYNC_INIT_DONE})); then
    async_init
fi

_set_docker_machine_env() {
    local output=$3
    eval "${output}"
}

_get_docker_machine_env() {
    [[ `docker-machine status` -eq "Running" ]] && (docker-machine env)
}

if hash docker-machine >/dev/null 2>&1; then
    async_start_worker dockermachine_worker -u -n
    async_register_callback dockermachine_worker _set_docker_machine_env
    async_job dockermachine_worker _get_docker_machine_env
fi

