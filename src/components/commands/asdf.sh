#!/bin/bash

: "${configOnly:=}"

ensure_asdf_is_installed() {
    if [ "${configOnly}" != "true" ]; then
        rm -f "$HOME/.tool-versions"
        installApplicationHomebrewStyle "asdf"
    fi
    append_to_zshrc_parts 'export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"'
}
