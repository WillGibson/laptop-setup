#!/bin/bash

set -e

currentBranch="$(git rev-parse --abbrev-ref HEAD)"
mainBranch="main"

if [ "$(git branch | grep 'main')" == "" ]; then
    mainBranch="master"
fi

echo "Merging ${mainBranch} branch into ${currentBranch}..."

git stash
git checkout "${mainBranch}"
git pull
git checkout -
git stash pop
git merge "${mainBranch}"
