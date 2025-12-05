#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -d "$HOME/Work" ]; then
    # Use local config if it exists, otherwise use tracked config
    if [ -f "$SCRIPT_DIR/mcp-configs/mcp.work.local.json" ]; then
        ln -sf "$SCRIPT_DIR/mcp-configs/mcp.work.local.json" "$HOME/.kiro/settings/mcp.json"
        echo "Configured Kiro for work environment (using local config)"
    else
        ln -sf "$SCRIPT_DIR/mcp-configs/mcp.work.json" "$HOME/.kiro/settings/mcp.json"
        echo "Configured Kiro for work environment"
    fi
else
    # Use local config if it exists, otherwise use tracked config
    if [ -f "$SCRIPT_DIR/mcp-configs/mcp.personal.local.json" ]; then
        ln -sf "$SCRIPT_DIR/mcp-configs/mcp.personal.local.json" "$HOME/.kiro/settings/mcp.json"
        echo "Configured Kiro for personal environment (using local config)"
    else
        ln -sf "$SCRIPT_DIR/mcp-configs/mcp.personal.json" "$HOME/.kiro/settings/mcp.json"
        echo "Configured Kiro for personal environment"
    fi
fi
