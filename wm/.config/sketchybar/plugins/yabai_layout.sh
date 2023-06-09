#!/usr/bin/env bash
space_info=$(yabai -m query --spaces --space)
layout=$(echo "$space_info"| jq --raw-output '.type')
windows=$(echo "$space_info" | jq --raw-output '.windows | length')

icon=""
case "$layout" in
	# stack) icon="";;
	bsp) icon="";;
	float) icon="";;
esac

sketchybar -m --set "$NAME" icon="$icon" label="$windows"
