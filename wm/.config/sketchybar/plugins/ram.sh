#!/usr/bin/env bash
usage=$(memory_pressure | \
			awk '/System-wide memory free percentage:/ { printf("%02.0f\n", 100-$5) }')

sketchybar -m --set "$NAME" label="$usage%"
