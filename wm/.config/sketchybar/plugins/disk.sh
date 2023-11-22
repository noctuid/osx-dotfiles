#!/usr/bin/env bash
percent=$(gdf -l | awk '$6 == "/" {print $5}')
sketchybar -m --set "$NAME" label="$percent"
