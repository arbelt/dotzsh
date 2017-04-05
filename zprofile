# vim: ft=zsh

local __basedir=$(dirname -- "${${(%):-%N}:A}")

for dotfile in "${__basedir}/zprofile.d/"/*.zsh; do
    source "${dotfile}"
done

