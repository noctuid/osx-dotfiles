#!/usr/bin/env bash
# title=$(yabai -m query --windows --window | jq --raw-output '.title')
# app=$(yabai -m query --windows --window | jq --raw-output '.app')
# in case yabai is not running

title=$(aerospace list-windows --focused --format "%{app-name} - %{window-title}")
title=${title:-$INFO}

# TODO why does it cut off my pipe?
# sketchybar -m --set title label="| ${title:-$app} |"
sketchybar -m --set "$NAME" label="$title"
