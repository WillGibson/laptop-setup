#!/bin/sh

# Sourced by the git hooks alongside it.
#
# Refuses the operation when it is being driven by an AI agent rather than a
# human, then hands over to the repo's own hook so project tooling still runs.
#
# This is the backstop for Claude Code's permission rules. Those match the
# command as a string, so "git  commit", "git -c foo=bar commit" and
# "/opt/homebrew/bin/git-commit" all slip past them. Git runs this no matter how
# the command was spelled, pathed, aliased or wrapped in a script.

block_agents_then_chain_to_repo_hook() {
    hookName="$(basename "$0")"

    case "${hookName}" in
        prepare-commit-msg) blockedAction="Committing" ;;
        pre-push) blockedAction="Pushing" ;;
        pre-rebase) blockedAction="Rebasing" ;;
        *) blockedAction="This" ;;
    esac

    if [ -n "${CLAUDECODE:-}" ] || [ -n "${CLAUDE_CODE_ENTRYPOINT:-}" ] || [ -n "${AI_AGENT:-}" ]; then
        echo "" >&2
        echo "  ${blockedAction} is a human's job, and an AI agent is driving this shell." >&2
        echo "  Blocked by ${hookName} in ~/.git_hooks_from_laptop_setup." >&2
        echo "  Do it yourself in your own terminal." >&2
        echo "" >&2
        exit 1
    fi

    repoHook="$(git rev-parse --git-dir)/hooks/${hookName}"
    if [ -x "${repoHook}" ]; then
        exec "${repoHook}" "$@"
    fi

    exit 0
}
