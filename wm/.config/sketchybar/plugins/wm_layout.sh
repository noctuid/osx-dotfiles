#!/usr/bin/env bash
# space_info=$(yabai -m query --spaces --space)
# layout=$(echo "$space_info"| jq --raw-output '.type')
# windows=$(echo "$space_info" | jq --raw-output '.windows | length')

# TODO aerospace doesn't support querying layout
layout=unknown
windows=$(aerospace list-windows --workspace visible --count)

icon=""
case "$layout" in
	# stack) icon="";;
	bsp) icon="";;
	float) icon="";;
esac

sketchybar -m --set "$NAME" icon="$icon" label="$windows"
