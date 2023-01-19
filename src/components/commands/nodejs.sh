#!/bin/bash

ensure_nvm_is_installed() {
    installApplicationHomebrewStyle "nvm"
    if [ ! -d ~/.nvm ]; then
        mkdir ~/.nvm
    fi
    append_to_zshrc_parts "source ${basePath}/components/zshrc/nvm_switcher.sh"

    # So we can use it right away...
    # Extract this to reduce duplication...
    if [ -f "/opt/homebrew/opt/nvm/nvm.sh" ]; then
        local nvmLocation="/opt/homebrew/opt/nvm"
    else
        local nvmLocation="/usr/local/opt/nvm"
    fi
    [ -s "${nvmLocation}/nvm.sh" ] && \. "${nvmLocation}/nvm.sh"  # This loads nvm
    [ -s "${nvmLocation}/etc/bash_completion.d/nvm" ] && \. "${nvmLocation}/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
}
