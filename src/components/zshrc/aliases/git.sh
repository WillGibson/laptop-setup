#!/bin/bash

alias cb="current_branch"
alias gac="gaa && gc"
alias gcqa="gc --amend --no-edit"
alias gcd="gco development"
alias gcwhatever='gaa && gc -m "Whatever $(date)" && ggpush'
alias ggauthwill='git commit --amend --author="Will Gibson <will@biffbangpow.com>"'
alias glog="git log --branches --tags --graph --oneline --decorate"
alias ghist="git log --pretty=format:\"%h %ad | %s%d %an\" --graph --date=short"
alias git-delete-all-local-branches-except-master-develop-and-current='git branch | grep -v "master" | grep -v "develop" | xargs git branch -D'
