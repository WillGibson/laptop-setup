#!/bin/bash

ensure_git_name_and_email_are_set() {
    if [ -z "$GIT_USER_NAME" ]; then
        fancy_echo "Please export GIT_USER_NAME=\"<your name>\""
        exit 1
    else
        git config --global user.name "$GIT_USER_NAME"
    fi
    if [ -z "$GIT_USER_EMAIL" ]; then
        fancy_echo "Please export GIT_USER_EMAIL=\"<your email address>\""
        exit 1
    else
        git config --global user.email "$GIT_USER_EMAIL"
    fi
}
