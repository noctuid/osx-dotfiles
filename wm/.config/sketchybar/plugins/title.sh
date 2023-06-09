#!/usr/bin/env bash
# not sure if the builtin info takes both title and app into consideration:
# https://github.com/FelixKratz/SketchyBar/blob/master/plugins/front_app.sh

title=$(yabai -m query --windows --window | jq --raw-output '.title')
app=$(yabai -m query --windows --window | jq --raw-output '.app')

# TODO why does it cut off my pipe?
# sketchybar -m --set title label="| ${title:-$app} |"
sketchybar -m --set "$NAME" label="${title:-$app}"
