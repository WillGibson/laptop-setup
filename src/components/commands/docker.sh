#!/bin/bash

ensure_docker_not_running() {
        echo_line "\nEnsure Docker is not running"
    if docker version 2>/dev/null | grep --quiet "Server: Docker Engine"; then
        echo_line "\nError: Please quit Docker before running the setup."
        exit 1
    fi
}

ensure_docker_is_installed() {
    append_to_zshrc_parts "export DOCKER_BUILDKIT=0"
    installApplicationHomebrewStyle "docker" 0 "--cask"
}
