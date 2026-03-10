#!/bin/bash

# Todo: Remove this in favour of asdf
export NVM_DIR="$HOME/.nvm"

pathToThisScript="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

source "${pathToThisScript}/initialise_nvm.sh"

# Automatically flip node version on CD if there a .nvmrc file in the repo
autoload -U add-zsh-hook
load-nvmrc() {
    if [ -f ".nvmrc" ]; then
        local nvmrc_path="$(nvm_find_nvmrc)"
        if [ -n "$nvmrc_path" ]; then
            nvm install
        else
            nvm use --lts
        fi
    else
        nvm use default
    fi
}
load-nvmrc
add-zsh-hook chpwd load-nvmrc
