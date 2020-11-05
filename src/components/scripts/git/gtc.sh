#!/bin/bash

set -e

commitMessage="$*"
if [ "$commitMessage" == "" ]; then
    echo "Please enter a commit message"
    exit 1
fi
branch=$(git rev-parse --abbrev-ref HEAD)
git pull origin "$branch" && \
git add . && \
git commit -m "$commitMessage" && \
git push origin "$branch"
