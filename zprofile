# vim: ft=zsh

local __basedir=$(dirname -- "${${(%):-%N}:A}")

echo "${__basedir}"

for dotfile in "${__basedir}/zprofile.d/"/*.zsh; do
    echo "${dotfile}"
    source "${dotfile}"
done

