#!/bin/bash

ensure_git_name_and_email_are_set_for_this_run() {
    echo_line "\nEnsure Git name and email are set for this run"
    git config --global user.name "$GIT_USER_NAME"
    git config --global user.email "$GIT_USER_EMAIL"
}

ensure_git_is_installed() {
    echo_heading "Install Git"
    installApplicationHomebrewStyle "git" 1
    git config --global pull.ff only
    ensure_symlink_exists "${basePath}/components/static_files/.gitignore_global" ~/.gitignore_global
    git config --global core.excludesfile ~/.gitignore_global
    installApplicationHomebrewStyle "git-lfs" 1
}
