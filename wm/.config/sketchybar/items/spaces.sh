#!/usr/bin/env bash
# TODO
# background highlight:
# https://github.com/FelixKratz/SketchyBar/discussions/12?sort=top#discussioncomment-3033787
# underline:
# https://github.com/FelixKratz/SketchyBar/discussions/12?sort=top#discussioncomment-2843397

# shellcheck disable=SC1090
source ~/bin/helpers.sh

min=1
max=10

create_space_settings() {
	local name number icon font
	# create local reference to modify array
	local -n settings=$1
	name=$1
	number=$2
	icon=${3:-$2}
	font=$4
	settings=(
		--add space "$name" left
		--subscribe "$name"
		yabai_window_created
		yabai_window_destroyed
		yabai_window_moved_space
		--set "$name"
		associated_space="$number"
		icon="$icon"
		click_script="yabai -m space --focus $name"
		label.drawing=off
		script="$PLUGIN_DIR/space.sh"
		icon.background.color="$yellow"
	)
	if ((number == min)); then
		settings+=(padding_left="$PADDING")
	fi
	if (( number < max )); then
		settings+=(padding_right=0)
	else
		settings+=(padding_right="$PADDING")
	fi
	if [[ -n $font ]]; then
		settings+=(icon.font="$font")
	fi
}

sketchybar -m \
		   --add event yabai_window_created \
		   --add event yabai_window_destroyed \
		   --add event yabai_window_moved_space

one=()
create_space_settings one 1 

two=()
create_space_settings two 2 

three=()
create_space_settings three 3  "$BRANDS"

four=()
create_space_settings four 4  "$BRANDS"

five=()
create_space_settings five 5 

six=()
create_space_settings six 6 

seven=()
create_space_settings seven 7  "$BRANDS"

eight=()
create_space_settings eight 8 

nine=()
create_space_settings nine 9 

ten=()
create_space_settings ten 10 

sketchybar \
	-m \
	"${one[@]}" \
	"${two[@]}" \
	"${three[@]}" \
	"${four[@]}" \
	"${five[@]}" \
	"${six[@]}" \
	"${seven[@]}" \
	"${eight[@]}" \
	"${nine[@]}" \
	"${ten[@]}"
