#!/bin/bash

ensure_jenv_is_installed() {
    installApplicationHomebrewStyle "jenv"
    append_to_zshrc_parts 'export PATH="$HOME/.jenv/bin:$PATH"'
    append_to_zshrc_parts 'eval "$(jenv init -)"' 1
}
