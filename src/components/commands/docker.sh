#!/bin/bash

ensure_docker_not_running() {
    if docker version | grep --quiet "Server: Docker Engine"; then
        echo "Error: Please quit Docker before running the setup."
        exit 1
    fi
}
