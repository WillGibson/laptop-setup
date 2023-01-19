#!/bin/bash

export NVM_DIR="$HOME/.nvm"

# Extract this to reduce duplication...
if [ -f "/opt/homebrew/opt/nvm/nvm.sh" ]; then
    local nvmLocation="/opt/homebrew/opt/nvm"
else
    local nvmLocation="/usr/local/opt/nvm"
fi
[ -s "${nvmLocation}/nvm.sh" ] && \. "${nvmLocation}/nvm.sh"  # This loads nvm
[ -s "${nvmLocation}/etc/bash_completion.d/nvm" ] && \. "${nvmLocation}/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

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
