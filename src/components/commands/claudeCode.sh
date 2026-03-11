#!/bin/bash

ensure_claude_code_is_installed() {
    echo_heading "Install Claude Code"
    if [ "${configOnly}" != "true" ]; then
        curl -fsSL https://claude.ai/install.sh | bash
    fi
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