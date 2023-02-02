#!/bin/bash

ensure_identity_related_environment_variables_are_set() {
    echo_line "\nEnsure identity related environment variables are set"
    if [ -z "$GIT_USER_NAME" ]; then
        echo_line "\nPlease export GIT_USER_NAME=\"<your name>\""
        exitSetup=1
    else
        git config --global --replace-all user.name "$GIT_USER_NAME"
    fi

    if [ -z "$GIT_USER_EMAIL" ]; then
        echo_line "\nPlease export GIT_USER_EMAIL=\"<your email address>\""
        echo_line "\nNote that there are privacy concerns about this so use a private one where possible"
        exitSetup=1
    else
        git config --global --replace-all user.email "$GIT_USER_EMAIL"
    fi

    if [ -z "$SSH_USER_EMAIL" ]; then
        echo_line "\nPlease export SSH_USER_EMAIL=\"<your email address>\""
        exitSetup=1
    fi

    if [ -n "$exitSetup" ]; then
        exit 1
    fi
}

ensure_identity_related_environment_variables_are_set_in_zshrc() {
    append_to_zshrc_parts "export GIT_USER_NAME=\"$GIT_USER_NAME\""
    append_to_zshrc_parts "export GIT_USER_EMAIL=\"$GIT_USER_EMAIL\"" 1
    append_to_zshrc_parts "export SSH_USER_EMAIL=\"$SSH_USER_EMAIL\"" 1
}
