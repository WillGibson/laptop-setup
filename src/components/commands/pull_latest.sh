#!/bin/bash

pull_latest_laptop_setup_code() {
    echo_heading "Ensure laptop-setup up to date"
    # shellcheck disable=SC2154
    if [ ! -f "${basePath}/../.git" ]; then
        echo_line "\nPulling latest code\n"
        currentDirectory=$(pwd)
        cd "${basePath}/../" || exit
        git config pull.ff only
        git pull origin "$(git rev-parse --abbrev-ref HEAD)"
        cd "${currentDirectory}" || exit
    else
        echo_line "\nNot pulling as this is not a Git repository"
    fi
}
