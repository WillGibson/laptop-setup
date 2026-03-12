#!/bin/bash

: "${configOnly:=}"

ensure_claude_code_is_installed() {
    echo_heading "Install Claude Code"
    if [ "${configOnly}" != "true" ]; then
        curl -fsSL https://claude.ai/install.sh | bash
    fi
    append_to_zshrc_parts 'export PATH="$HOME/.local/bin:$PATH"'
    mkdir -p "$HOME/.claude"
    cat > "$HOME/.claude/settings.json" << 'EOF'
{
    "spinnerVerbs": {
        "mode": "replace",
        "verbs": ["Thinking"]
    }
}
EOF
}
