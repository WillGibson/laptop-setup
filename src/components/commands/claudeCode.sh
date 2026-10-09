#!/bin/bash

: "${configOnly:=}"
: "${basePath:=}"

ensure_claude_code_is_installed() {
    echo_heading "Install Claude Code"
    if [ "${configOnly}" != "true" ]; then
        curl -fsSL https://claude.ai/install.sh | bash
    fi
    # $HOME must expand at shell runtime, not when this script runs
    # shellcheck disable=SC2016
    append_to_zshrc_parts 'export PATH="$HOME/.local/bin:$PATH"'
    mkdir -p "$HOME/.claude"
    cat > "$HOME/.claude/settings.json" << 'EOF'
{
    "model": "opus[1m]",
    "disableRemoteControl": true,
    "env": {
        "CLAUDE_CODE_DISABLE_MOUSE_CLICKS": "1"
    },
    "permissions": {
        "disableBypassPermissionsMode": "disable",
        "deny": [
          "Bash(*--no-verify*)",
          "Bash(*aws *)",
          "Bash(*core.hooksPath*)",
          "Bash(*gh*api*)",
          "Bash(*git*branch*-D*)",
          "Bash(*git*clean*-f*)",
          "Bash(*git*commit*)",
          "Bash(*git*merge*)",
          "Bash(*git*push*)",
          "Bash(*git*rebase*)",
          "Bash(*git*reset*--hard*)",
          "Bash(*git*tag*-d*)",
          "Edit(./.env*)",
          "Read(./.env*)"
        ]
      },
    "hooks": {
        "PreToolUse": [
            {
                "matcher": "Bash",
                "hooks": [
                    {
                        "type": "command",
                        "command": "bash $HOME/.claude/deny-dangerous-repo-commands.sh",
                        "timeout": 10
                    }
                ]
            }
        ]
    },
    "statusLine": {
        "type": "command",
        "command": "sh $HOME/.claude/statusline-command.sh"
    },
    "extraKnownMarketplaces": {
        "anthropic-tools": {
            "source": {
                "source": "github",
                "repo": "anthropics/claude-code-skills"
            }
        },
        "anthropic-agent-skills": {
            "source": {
                "source": "github",
                "repo": "anthropics/skills"
            }
        }
    },
    "spinnerVerbs": {
        "mode": "replace",
        "verbs": [
            "Thinking"
        ]
    },
    "effortLevel": "high"
}
EOF
    ensure_symlink_exists "${basePath}/components/scripts/claude/statusline-command.sh" "$HOME/.claude/statusline-command.sh"
    ensure_symlink_exists "${basePath}/components/scripts/claude/deny-dangerous-repo-commands.sh" "$HOME/.claude/deny-dangerous-repo-commands.sh"
}
