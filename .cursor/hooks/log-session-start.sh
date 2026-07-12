#!/bin/bash
# Demo hook: logs session start to stderr (visible in Hooks output channel).
# Receives JSON on stdin; no stdout response required for sessionStart.

input=$(cat)
echo "[cursor-workspace-template] sessionStart hook fired" >&2
echo "$input" >&2
exit 0
