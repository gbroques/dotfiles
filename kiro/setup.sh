#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -d "$HOME/Work" ]; then
    ln -sf "$SCRIPT_DIR/mcp-configs/mcp.work.json" "$HOME/.kiro/settings/mcp.json"
    echo "Configured Kiro for work environment"
else
    ln -sf "$SCRIPT_DIR/mcp-configs/mcp.personal.json" "$HOME/.kiro/settings/mcp.json"
    echo "Configured Kiro for personal environment"
fi
