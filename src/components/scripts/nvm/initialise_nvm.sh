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
