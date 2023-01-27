#!/bin/bash

ensure_nvm_is_installed() {
    installApplicationHomebrewStyle "nvm"
    if [ ! -d ~/.nvm ]; then
        mkdir ~/.nvm
    fi
    nvmScriptPath="${basePath}/components/scripts/nvm"
    append_to_zshrc_parts "source ${nvmScriptPath}/initialise_nvm.sh"
    append_to_zshrc_parts "source ${nvmScriptPath}/nvm_switcher.sh" 1

    # So we can use it right away...
    source "${nvmScriptPath}/initialise_nvm.sh"
}
