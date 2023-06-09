#!/usr/bin/env bash

basedir=$(dirname "$(realpath "$0")")
# shellcheck disable=SC1090
source "$basedir/../colors.sh"
# shellcheck disable=SC1090
source ~/bin/helpers.sh

args=()

if [[ $SELECTED == true ]]; then
	args+=(--set "$NAME" icon.background.y_offset="$UNDERLINE_OFFSET")
else
	args+=(--set "$NAME" icon.background.y_offset=-"$BAR_HEIGHT")
fi

windows=$(yabai -m query --spaces \
			  | jq --raw-output \
				   ".[] | select(.label == \"$NAME\") | .windows | length")
# windows=$(yabai -m query --spaces --space | jq '.windows | length')
if (( windows == 0 )); then
	args+=(icon.color=0xFF555555)
else
	args+=(icon.color="$foreground")
fi

# underline animated when swapping spaces
sketchybar -m --animate tanh 10 "${args[@]}"
