#!/bin/bash

# PreToolUse hook for Claude Code. Blocks git and gh commands that publish work
# or destroy it, however they happen to be spelled.
#
# Claude Code's permission globs match the raw command string, so "git  commit",
# "git -c user.name=x commit", "/opt/homebrew/bin/git commit" and "git-commit"
# all walk straight past a deny rule of "Bash(*git commit*)". This normalises
# the command first, then matches.
#
# This is still string matching, so it is a speed bump rather than a wall - the
# git hooks in components/scripts/git/hooks are what actually enforce the rule
# for git. Nothing enforces gh, which reaches GitHub over the API without
# touching a local repo, so for gh this script is the only guard there is.

set -uo pipefail

deny() {
    jq -n --arg reason "$1" '{
        hookSpecificOutput: {
            hookEventName: "PreToolUse",
            permissionDecision: "deny",
            permissionDecisionReason: $reason
        }
    }'
    exit 0
}

commandText="$(jq -r '.tool_input.command // ""')"
[[ -z "${commandText}" ]] && exit 0

# Quote removal turns g"it" commit into git commit; the tr collapses the
# newlines and tabs that would otherwise break up "git commit".
# shellcheck disable=SC1003
normalised="$(printf '%s' "${commandText}" | tr '\n\t' '  ' | tr -d '"'"'"'\\')"
# Absolute paths to git, and the dashed form git-commit, become plain "git x".
normalised="$(printf '%s' "${normalised}" | sed -E 's#/[^[:space:]]*/git#git#g; s#/[^[:space:]]*/gh([^a-z-])#gh\1#g; s#(^|[^[:alnum:]_-])git-([a-z][a-z-]*)#\1git \2#g')"
normalised="$(printf '%s' "${normalised}" | sed -E 's/[[:space:]]+/ /g')"

# Strip git's global options so "git -c core.hooksPath=/dev/null commit" is seen
# as "git commit". Repeat until nothing more is stripped.
while :; do
    stripped="$(printf '%s' "${normalised}" | sed -E 's/(^|[^[:alnum:]_-])git +(-c +[^ ]+|-C +[^ ]+|--no-pager|--paginate|--git-dir[= ][^ ]+|--work-tree[= ][^ ]+|--exec-path[= ][^ ]+|--namespace[= ][^ ]+|--literal-pathspecs|--no-replace-objects) +/\1git /g')"
    [[ "${stripped}" == "${normalised}" ]] && break
    normalised="${stripped}"
done

git_does() {
    [[ "${normalised}" =~ (^|[^[:alnum:]_-])git\ $1($|[^[:alnum:]_-]) ]]
}

# Anything that disables the git hooks is blocked outright, because those hooks
# are the backstop this script is admitting it cannot be.
[[ "${normalised}" == *core.hooksPath* ]] && deny "Overriding core.hooksPath is blocked - the git hooks are there deliberately."
[[ "${normalised}" == *--no-verify* ]] && deny "--no-verify skips the git hooks and is blocked."
[[ "${normalised}" =~ (^|[^[:alnum:]_-])git\ (commit|push)( |$).*\ -[a-z]*n([ =]|$) ]] && deny "-n is --no-verify here, which skips the git hooks and is blocked."

# gh api writes commits, merges and releases straight to GitHub without ever
# running git, so none of the git hooks see it.
[[ "${normalised}" =~ (^|[^[:alnum:]_-])gh\ api($|[^[:alnum:]_-]) ]] && deny "gh api can write to GitHub without touching a local repo, so it is blocked. Ask me to show you the command and run it yourself."

git_does "(commit|commit-tree)" && deny "Committing is yours to do, not mine. Stage the changes and commit them yourself."
git_does "push" && deny "Pushing is yours to do, not mine."
git_does "merge" && deny "Merging is yours to do, not mine."
git_does "rebase" && deny "Rebasing is yours to do, not mine."
git_does "(am|cherry-pick|revert|filter-branch|filter-repo|fast-import)" && deny "Commands that write history are blocked."

git_does "reset" && [[ "${normalised}" =~ --(hard|merge|keep) ]] && deny "git reset --hard discards work that is not recoverable. Do it yourself if you mean it."
git_does "clean" && [[ "${normalised}" =~ (-[a-z]*f|--force) ]] && deny "git clean -f deletes untracked files permanently. Do it yourself if you mean it."
git_does "branch" && [[ "${normalised}" =~ (-[a-zA-Z]*D|--delete) ]] && deny "Deleting branches is yours to do, not mine."
git_does "tag" && [[ "${normalised}" =~ (-[a-z]*d|--delete) ]] && deny "Deleting tags is yours to do, not mine."

exit 0
