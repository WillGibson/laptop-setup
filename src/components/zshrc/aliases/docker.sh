#!/bin/bash

# shellcheck disable=SC2164
basePath="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )/../../"

alias docker-cleanup="${basePath}scripts/docker/docker-cleanup"
alias docker-brutal-cleanup="${basePath}scripts/docker/docker-brutal-cleanup"
alias docker-pull-all="docker images |grep -v REPOSITORY|awk '{print $1}'|xargs -L1 docker pull"
alias docker-really-brutal-cleanup="${basePath}scripts/docker/docker-really-brutal-cleanup"

