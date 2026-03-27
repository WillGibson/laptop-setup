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
    "spinnerVerbs": {
        "mode": "replace",
        "verbs": ["Thinking"]
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
        }
    }
}
EOF
    ensure_symlink_exists "${basePath}/components/scripts/claude/statusline-command.sh" "$HOME/.claude/statusline-command.sh"
}
