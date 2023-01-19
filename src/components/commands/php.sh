#!/bin/bash

ensure_php_is_installed() {
    installApplicationHomebrewStyle "php@8.0"
    if [ "${configOnly}" == "true" ]; then
        echo_line "ConfigOnly: Skipping install of PHP"
        return
    fi
    brew link --force --overwrite php@8.0
    brew services restart php
    brew unlink php && brew link php
}
