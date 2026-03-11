#!/bin/bash

ensure_asdf_is_installed() {
    if [ "${configOnly}" != "true" ]; then
        rm -f "$HOME/.tool-versions"
        installApplicationHomebrewStyle "asdf"
    fi
    source "$(brew --prefix asdf)/libexec/asdf.sh"
    append_to_zshrc_parts 'source $(brew --prefix asdf)/libexec/asdf.sh'
    chmod +x "$(brew --prefix asdf)/libexec/asdf.sh"
}

installApplicationWithAsdf() {
    local applicationName="$1"

    if [[ "$2" != "" ]];then
        local versionPrefix=":$2"
        echo "$2"
        echo "$versionPrefix"
    fi

    echo_heading "Installing ${applicationName} with asdf"

    command="asdf plugin add ${applicationName}"
    echo_line "\n${command}"
    $command

    command="asdf set ${applicationName} latest${versionPrefix} --home"
    echo_line "\n${command}"
    $command

    sort "$HOME/.tool-versions"
}
