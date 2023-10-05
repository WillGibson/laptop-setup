#!/bin/bash

set -e

currentBranch="$(git rev-parse --abbrev-ref HEAD)"
mainBranch="main"

if [ "$(git branch | grep 'main')" == "" ]; then
    mainBranch="master"
fi

if [ "$(git stash list)" != "" ]; then
    echo "There are existing stash entries, unable to continue"
    exit 1
fi

echo "Merging ${mainBranch} branch into ${currentBranch}..."

git stash
git checkout "${mainBranch}"
git pull
git checkout -
git merge "${mainBranch}"
if [ "$(git stash list)" != "" ]; then
    git stash pop
fi
