#!/bin/sh
# Set the tmux prefix based on HOW the attaching client connected, not on which
# machine this is — the same box is used at the physical console and over
# ssh/mosh, so the choice has to be made per connection:
#
#   reached over ssh/mosh -> prefix Ctrl-s
#   physical console      -> prefix Ctrl-a, with Ctrl-s left UNBOUND so it
#                            passes straight through to the tmux running inside
#                            a nested ssh/mosh session.
#
# Detection walks the client's process ancestry looking for sshd / mosh-server.
# This is immune to the signals that failed before: $SSH_CONNECTION (empty
# under mosh, stale when the server outlives its ssh session) and `uname`
# (a remote box here is also macOS).
#
# Invoked from .tmux.conf:  set-hook -g client-attached 'run-shell "... #{client_pid}"'

p="$1"
remote=0
while [ "$p" -gt 1 ] 2>/dev/null; do
    comm=$(ps -o comm= -p "$p" 2>/dev/null) || break
    case "$comm" in
        *sshd*|*mosh-server*) remote=1; break ;;
    esac
    p=$(ps -o ppid= -p "$p" 2>/dev/null | tr -d ' ')
    [ -z "$p" ] && break
done

if [ "$remote" -eq 1 ]; then
    tmux set -g prefix C-s
    tmux set -gu prefix2
    tmux bind C-s send-prefix
    tmux unbind C-a
else
    tmux set -g prefix C-a
    tmux set -gu prefix2
    tmux bind C-a send-prefix
    tmux unbind C-s
fi
