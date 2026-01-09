#!/bin/bash

REPO_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -f "$HOME/.zshrc" ]; then 
    SHELL_CONFIG="$HOME/.zshrc"
elif [ -f "$HOME/.bashrc" ]; then 
    SHELL_CONFIG="$HOME/.bashrc"
else 
    SHELL_CONFIG="$HOME/.profile"
fi

EXPORT_CMD="export GIT_HELPERS=\"$REPO_PATH\""

# Checks if the variable has already been defined to avoid duplicates
if grep -q "GIT_HELPERS=" "$SHELL_CONFIG"; then 
    echo "⚠️ The GIT_HELPERS variable already exists in $SHELL_CONFIG." 
    echo "Check if the path is correct: $REPO_PATH"
else 
    # Adds to end of file 
    echo "" >> "$SHELL_CONFIG" 
    echo "# Automatic git-helpers configuration" >> "$SHELL_CONFIG" 
    echo "$EXPORT_CMD" >> "$SHELL_CONFIG" 

    echo "✅ Success! Path registered in $SHELL_CONFIG:" 
    echo "$EXPORT_CMD" 
    echo "" 
    echo "👉 To take effect now, run:" 
    echo "source $SHELL_CONFIG"
fi