#!/bin/bash

alias dss="docker-sync start"
alias dsc="docker-sync clean"
alias dv="docker volume"
alias docker-cleanup="~/linux-setup-will-01/DockerScripts/docker-cleanup"
alias docker-brutal-cleanup="~/linux-setup-will-01/DockerScripts/docker-brutal-cleanup"
alias docker-pull-all="docker images |grep -v REPOSITORY|awk '{print $1}'|xargs -L1 docker pull"
alias docker-really-brutal-cleanup="~/linux-setup-will-01/DockerScripts/docker-really-brutal-cleanup"
alias docker-disk-usage="sudo ~/Sites/BiffBangPow/docker-disk-usage/bin/docker-disk-usage --detailed --include-mounts"
alias sda="source docker/aliases"
