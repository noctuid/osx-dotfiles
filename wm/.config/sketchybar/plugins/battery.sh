#!/usr/bin/env bash
# adapted from
# https://github.com/FelixKratz/dotfiles/blob/master/.config/sketchybar/plugins/battery.sh

basedir=$(dirname "$(realpath "$0")")
# shellcheck disable=SC1090
source "$basedir/../colors.sh"

battery_info="$(pmset -g batt)"
percent=$(echo "$battery_info" | grep -Eo "\d+%" | cut -d% -f1)

color=$blue

if echo "$battery_info" | grep --quiet 'AC Power'; then
	icon=""
elif (( percent >= 90 )); then
	icon=""
elif (( percent >= 75 )); then
	icon=""
elif (( percent >= 50 )); then
	icon=""
elif (( percent >= 25 )); then
	icon=""
	color="$yellow"
else
	icon=""
	color="$red"
fi

sketchybar -m --set "$NAME" icon="$icon" label="$percent" \
		   icon.color="$color" label.color="$foreground"
