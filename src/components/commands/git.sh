#!/bin/bash

ensure_git_name_and_email_are_set() {
        echo_line "\nEnsure Git name and email are set"
    if [ -z "$GIT_USER_NAME" ]; then
        echo_line "\nPlease export GIT_USER_NAME=\"<your name>\""
        exit 1
    else
        git config --global user.name "$GIT_USER_NAME"
    fi
    if [ -z "$GIT_USER_EMAIL" ]; then
        echo_line "\nPlease export GIT_USER_EMAIL=\"<your email address>\""
        exit 1
    else
        git config --global user.email "$GIT_USER_EMAIL"
    fi
}

ensure_git_name_and_email_env_vars_are_exported_in_zshrc() {
    append_to_zshrc_parts "export GIT_USER_NAME=\"$GIT_USER_NAME\""
    append_to_zshrc_parts "export GIT_USER_EMAIL=\"$GIT_USER_EMAIL\"" 1
}
