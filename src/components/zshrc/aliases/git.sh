#!/bin/bash

# shellcheck disable=SC2164
basePath="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )/../../"

alias gac="gaa && gc"
alias gcqa="gc --amend --no-edit"
alias gcd="gco development"
alias gcwhatever='gaa && gc -m "Whatever $(date)" && ggpush'
alias glog="glola"
alias ghist="git log --graph --pretty='%Cred%h%Creset - %Cgreen%cI%Creset -%C(auto)%d%Creset %s %C(bold blue)<%an>%Creset'"
alias git-delete-all-local-branches-except-main-develop-and-current='git branch | grep -v "master" | grep -v "main" | grep -v "develop" | xargs git branch -D'
alias gmm="${basePath}scripts/git/gmm.sh"
alias gtc="${basePath}scripts/git/gtc.sh"
alias gtp="git commit --allow-empty -m 'Trigger pipeline' && ggpush"
