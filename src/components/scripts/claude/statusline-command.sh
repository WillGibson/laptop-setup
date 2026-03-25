#!/bin/sh
cyan_bold=$(printf '\033[1;36m')
blue_bold=$(printf '\033[1;34m')
green=$(printf '\033[0;32m')
red=$(printf '\033[0;31m')
yellow=$(printf '\033[33m')
reset=$(printf '\033[0m')

input=$(cat)
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
home="$HOME"
display_dir="${cwd/#$home/~}"
model=$(echo "$input" | jq -r '.model.display_name // empty')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
ctx_size=$(echo "$input" | jq -r '.context_window.context_window_size // empty')
input_tokens=$(echo "$input" | jq -r '.context_window.current_usage.input_tokens // empty')

# Context usage progress bar (always shown, defaults to 0% before first API call)
used_val="${used:-0}"
bar_width=10
pct=$(printf '%.0f' "$used_val")
pct_str="${pct}%"
pct_len=${#pct_str}
# Number of block characters available before the embedded percentage label
block_area=$(( bar_width - pct_len ))
filled=$(echo "$used_val $block_area" | awk '{f=int(($1/100)*$2 + 0.5); if(f>$2) f=$2; printf "%d", f}')
empty=$(( block_area - filled ))
if [ "$pct" -gt 50 ]; then
    bar_color="$red"
else
    bar_color="$green"
fi
bar="${bar_color}"
i=0
while [ "$i" -lt "$filled" ]; do
    bar="${bar}█"
    i=$(( i + 1 ))
done
bar="${bar}${reset}"
i=0
while [ "$i" -lt "$empty" ]; do
    bar="${bar}░"
    i=$(( i + 1 ))
done
ctx=" | ${bar} ${pct_str}"

# Model
model_info=""
if [ -n "$model" ]; then
    model_info=" | $model"
fi

dir_info="${cyan_bold}${display_dir}${reset}"

printf "%s%s%s%s" "$dir_info" "$model_info" "$ctx"
