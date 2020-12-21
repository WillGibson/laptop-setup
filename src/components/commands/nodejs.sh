#!/bin/bash

ensure_nvm_is_installed() {
    installApplicationHomebrewStyle "nvm"
    if [ ! -d ~/.nvm ]; then
        mkdir ~/.nvm
    fi
    append_to_zshrc_parts "source ${basePath}/components/zshrc/nvm_switcher.sh"

    # So we can use it right away...
    export NVM_DIR="$HOME/.nvm"
    # Todo: Figure out why this started blowing up on "that" laptop...
    #  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
}
