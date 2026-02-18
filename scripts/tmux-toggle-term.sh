#!/usr/bin/env bash
# Toggle a bottom terminal pane in the current tmux window.
# States: doesn't exist → create | visible → hide | hidden → show

SOCK="${TMUX%%,*}"
T="tmux -S $SOCK"

SESSION="$($T display-message -p '#{session_name}')"
WINDOW="$($T display-message -p '#{window_index}')"
SHELL_WINDOW_NAME="shell"

# Check if the "shell" window exists in this session
SHELL_WINDOW_ID="$($T list-windows -t "$SESSION" -F '#{window_id} #{window_name}' \
  | awk -v name="$SHELL_WINDOW_NAME" '$2 == name {print $1; exit}')"

PANE_COUNT="$($T display-message -p '#{window_panes}')"

if [[ -n "$SHELL_WINDOW_ID" ]]; then
  # Hidden shell window exists — join it back as a bottom pane
  $T join-pane -f -v -s "$SHELL_WINDOW_ID" -l 15% -t "$SESSION:$WINDOW"
elif [[ "$PANE_COUNT" -ge 3 ]]; then
  # Find the bottom pane by position and break it out
  BOTTOM_PANE="$($T list-panes -t "$SESSION:$WINDOW" -F '#{pane_index} #{pane_top}' \
    | sort -k2 -n | tail -1 | cut -d' ' -f1)"
  $T break-pane -d -s "$SESSION:$WINDOW.$BOTTOM_PANE" -n "$SHELL_WINDOW_NAME"
else
  # No shell pane exists — create one at the bottom
  DIR="$($T display-message -p '#{pane_current_path}')"
  $T split-window -f -v -l 15% -c "$DIR"
fi
