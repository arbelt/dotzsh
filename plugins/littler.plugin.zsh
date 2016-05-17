function r() {
    if [[ -z "$_littler_path" ]]; then
        _littler_path=`Rscript -e 'cat(system.file("bin/R", package = "littler"))'`
        if [[ -x "${_littler_path}" ]]; then
            local _littler_bin_dir="$(dirname ${_littler_path})"
            local _r_path="$(which R)"
            export path=("${_littler_bin_dir}" $path)
#             rdef=`cat <<EOF
#                 function r() {
#                     "$_littler_path" \\$@
#                 }
# EOF
#             `
#             eval "$rdef"
#             unset rdef
            hash r=$_littler_path
            hash R=$_r_path
            unset -f r
            disable r
            command r "$@"
        else
            return 1
        fi
    fi
}

