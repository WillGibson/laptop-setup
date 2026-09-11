#!/bin/bash

: "${basePath:=}"

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
    ensure_git_hooks_block_ai_agents
}

# Git enforces these itself, so they hold however an AI agent spells the command.
# Claude Code's deny rules only match the command as a string, which "git  commit"
# or "git -c foo=bar commit" walk straight past.
ensure_git_hooks_block_ai_agents() {
    echo_line "\nEnsure git hooks block AI agents from committing, pushing and rebasing"
    ensure_symlink_exists "${basePath}/components/scripts/git/hooks" "${HOME}/.git_hooks_from_laptop_setup"
    git config --global core.hooksPath "${HOME}/.git_hooks_from_laptop_setup"
}
