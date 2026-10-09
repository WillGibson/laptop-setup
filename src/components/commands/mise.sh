#!/bin/bash

: "${configOnly:=}"

ensure_mise_is_installed() {
    installApplicationHomebrewStyle "mise"
    # shellcheck disable=SC2016
    append_to_zshrc_parts 'eval "$(mise activate zsh)"'
}

installApplicationWithMise() {
    local applicationName="$1"

    echo_heading "Installing ${applicationName} with mise"

    if [ "${configOnly}" == "true" ]; then
        echo_line "ConfigOnly: Skipping install of ${applicationName}"
        return
    fi

    command="mise use --global ${applicationName}@latest"
    echo_line "\n${command}"
    $command
}
