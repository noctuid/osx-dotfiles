#!/usr/bin/env bash
# shebang just to indicate bash (not actually run)
if [[ -f ~/.cache/wal/colors.sh ]]; then
	# shellcheck disable=SC1090
	source ~/.cache/wal/colors.sh
	background="0xFF${background//\#}"
	foreground="0xFF${foreground//\#}"
	# shellcheck disable=2154
	red="0xFF${color1//\#}"
	# shellcheck disable=2154
	green="0xFF${color2//\#}"
	# shellcheck disable=2154
	yellow="0xFF${color3//\#}"
	# shellcheck disable=2154
	blue="0xFF${color4//\#}"
	# shellcheck disable=2154
	magenta="0xFF${color5//\#}"
else
	# default menubar background/foreground colors
	background=0xFF202020
	foreground=0xFFE9E9E9
	# shellcheck disable=SC2034
	red=0xFFA40000
	# shellcheck disable=SC2034
	green=0xFF90A959
	# shellcheck disable=SC2034
	yellow=0xFFCDA449
	# shellcheck disable=SC2034
	blue=0xFF2A3D4E
	# shellcheck disable=SC2034
	magenta=0xFF905EFF
fi
