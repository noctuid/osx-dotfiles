#!/usr/bin/env bash
# The volume_change event supplies a $INFO variable in which the current volume
# percentage is passed to the script.

basedir=$(dirname "$(realpath "$0")")
# shellcheck disable=SC1090
source "$basedir"/../colors.sh

volume=$INFO
label_drawing=on
color="$blue"
icon_padding="$HALF_PADDING"
if ! (( volume >= 1)); then
	icon=""
	color="$red"
	label_drawing=off
	icon_padding=0
elif system_profiler SPAudioDataType | grep --quiet Headphones; then
	icon=""
elif (( volume >= 66 )); then
	icon=""
elif (( volume >= 33 )); then
	icon=""
elif (( volume >= 1 )); then
	icon=""
fi

sketchybar --set "$NAME" \
		   icon="$icon" icon.color="$color" icon.padding_right="$icon_padding" \
		   label="$volume%" label.drawing="$label_drawing"
