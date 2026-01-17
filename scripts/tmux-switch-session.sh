#!/bin/sh
# Handle clicks on sessions and windows in status bar
[ -z "$1" ] && exit 0

# If it starts with 'w' followed by number, it's a window index
if echo "$1" | grep -qE '^w[0-9]+$'; then
    WIN="${1#w}"
    tmux select-window -t ":$WIN"
    exit 0
fi

# Otherwise it's a session name (possibly truncated to 15 chars)
SESSION=$(tmux list-sessions -F '#{session_name}' | grep "^$1" | head -1)
[ -n "$SESSION" ] && tmux switch-client -t "=$SESSION"
