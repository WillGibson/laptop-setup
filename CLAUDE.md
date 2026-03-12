# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A MacOS laptop setup automation tool. It installs and configures development tools idempotently using Homebrew and asdf. Designed to be re-run periodically to keep everything up to date.

## Running the setup

```bash
# Export required env vars first
export GIT_USER_NAME="<your name>" \
    GIT_USER_EMAIL="<your (maybe private GitHub) email address>" \
    SSH_USER_EMAIL="<your email address>"

# Full setup
./src/setup.sh

# Config-only run (skips installs, just writes config/zshrc parts)
./src/setup.sh -c
```

## Configuration

- `.config.json` controls which tool groups are installed (gitignored — copy from `.config.json.example`)
- `includeAllByDefault: false` means only groups explicitly set to `true` are installed
- `additionalCommands.pre` / `additionalCommands.post` run custom commands before/after the main process

## Changelog

Update `CHANGELOG.md` whenever you change the behaviour of this tool. Group changes under an `## [Unreleased]` section at the top — the user will set the version number and date when releasing.

## Architecture

`src/setup.sh` is the main entry point. It sources all component files from `src/components/commands/` then runs a linear sequence of install steps guarded by `include "<groupName>"` checks.

**Key abstractions in `src/components/commands/`:**
- `filter.sh` — `include()` reads `.config.json` via `jq` to decide whether to install a group
- `homebrew.sh` — `installApplicationHomebrewStyle()` installs or upgrades a Homebrew formula/cask
- `asdf.sh` — `installApplicationWithAsdf()` adds an asdf plugin and sets the latest version globally
- `zshrc.sh` — `append_to_zshrc_parts()` / `append_to_zshrc()` write to `~/.zshrc_parts_from_laptop_setup.sh` which is sourced from `~/.zshrc`
- `miscellaneous.sh` — `echo_heading`, `echo_line`, `run_command_but_dont_exit_on_error`, etc.

**Shell aliases** are defined in `src/components/zshrc/aliases/` and sourced into the shell at the end of each run.

**Custom scripts** live in `src/components/scripts/` (git helpers, docker cleanup, kubernetes namespace switcher, etc.) and are referenced from zshrc parts.
