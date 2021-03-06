#!/bin/bash

# Wrap up some git commands into one to try and avoid
# race conditions during trunk based development

set -e

commitMessage="$*"
if [ "$commitMessage" == "" ]; then
    echo "Please enter a commit message"
    exit 1
fi

branch=$(git rev-parse --abbrev-ref HEAD)

if [ "$(git ls-remote --heads origin "$branch")" == "" ]; then
    echo "Branch not pushed yet, nothing to pull."
else
    echo "Pull from remote..."
    git pull origin "$branch"
fi

echo "Add all local changes..." && \
git add --all && \
echo "Commit..." && \
git commit -m "$commitMessage" && \
echo "Push..." && \
git push origin "$branch"
