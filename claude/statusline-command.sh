#!/usr/bin/env bash
set -u

input=$(cat)

model=$(printf '%s' "$input" | jq -r '.model.display_name // .model.id // empty')
cwd=$(printf '%s' "$input" | jq -r '.workspace.current_dir // .cwd // empty')
cost=$(printf '%s' "$input" | jq -r '.cost.total_cost_usd // empty')

dir_display=""
if [ -n "$cwd" ]; then
  dir_display="${cwd/#$HOME/~}"
  dir_display=$(basename "$dir_display")
fi

branch=""
if [ -n "$cwd" ] && [ -d "$cwd/.git" ] || git -C "$cwd" rev-parse --git-dir >/dev/null 2>&1; then
  branch=$(git -C "$cwd" branch --show-current 2>/dev/null)
fi

parts=""
[ -n "$model" ] && parts="$model"
[ -n "$dir_display" ] && parts="$parts │ $dir_display"
[ -n "$branch" ] && parts="$parts │ ⎇ $branch"
[ -n "$cost" ] && parts="$parts │ \$$(printf '%.2f' "$cost")"

printf '%s' "$parts"
