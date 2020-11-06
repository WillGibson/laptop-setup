#!/bin/bash

# shellcheck disable=SC2164
basePath="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )/../../"

alias gac="gaa && gc"
alias gcqa="gc --amend --no-edit"
alias gcd="gco development"
alias gcwhatever='gaa && gc -m "Whatever $(date)" && ggpush'
alias glog="git log --branches --tags --graph --oneline --decorate"
alias ghist="git log --pretty=format:\"%h %ad | %s%d %an\" --graph --date=short"
alias git-delete-all-local-branches-except-main-develop-and-current='git branch | grep -v "master" | grep -v "main" | grep -v "develop" | xargs git branch -D'
alias gtc="${basePath}scripts/git/gtc.sh"
