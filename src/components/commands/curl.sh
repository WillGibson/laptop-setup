#!/bin/bash

ensure_curl_is_installed() {
    installApplicationHomebrewStyle "curl"
    append_to_zshrc_parts 'export PATH="/usr/local/opt/curl/bin:$PATH"'
}
