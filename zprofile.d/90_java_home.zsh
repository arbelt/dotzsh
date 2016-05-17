# -*- mode:sh -*-

if [[ -x "/usr/libexec/java_home" ]]; then
    jh_candidate=$(/usr/libexec/java_home 2>/dev/null)
    if [[ -n "$jh_candidate" ]]; then
        export JAVA_HOME="$jh_candidate"
    fi
    unset jh_candidate
fi
