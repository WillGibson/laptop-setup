#!/bin/bash

# Todo: Remove this in favour of asdf
ensure_rvm_is_installed() {
    curl -sSL https://rvm.io/mpapis.asc | gpg --import -
    curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
    curl -sSL https://get.rvm.io | bash -s stable
    append_to_zshrc_parts "source \"$HOME/.rvm/scripts/rvm\""
}
