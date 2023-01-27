#!/bin/bash

ensure_php_is_installed() {
    installApplicationHomebrewStyle "php"
    if [ "${configOnly}" == "true" ]; then
        echo_line "ConfigOnly: Skipping install of PHP"
        return
    fi
    brew services stop php
    brew unlink php && brew link php
    brew services start php
}
