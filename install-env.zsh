#!/usr/bin/env zsh

# 1. Native Zsh resolution for the absolute directory of the script
REPO_PATH="${0:A:h}"

# 2. Definition of the default macOS configuration file
SHELL_CONFIG="$HOME/.zshrc"

# 3. Ensures the file exists (common in clean macOS installations)
if [[ ! -f "$SHELL_CONFIG" ]]; then
    touch "$SHELL_CONFIG"
fi

EXPORT_CMD="export GIT_HELPERS=\"$REPO_PATH\""

# 4. Idempotency check to avoid duplicates
if grep -q "GIT_HELPERS=" "$SHELL_CONFIG"; then
    print "⚠️ The GIT_HELPERS variable already exists in $SHELL_CONFIG."
    print "Check if the path is correct: $REPO_PATH"
else
    # 5. Adds the configuration to the end of the file
    print "\n# Automatic git-helpers configuration" >> "$SHELL_CONFIG"
    print "$EXPORT_CMD" >> "$SHELL_CONFIG"

    print "✅ Success! Path registered in $SHELL_CONFIG:"
    print "$EXPORT_CMD\n"
    print "👉 To take effect now, run:"
    print "source $SHELL_CONFIG"
fi
