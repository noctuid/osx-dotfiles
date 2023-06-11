#!/usr/bin/env bash
# https://github.com/SxC97/dotfiles/blob/main/.config/sketchybar/plugins/cpu.sh
core_count=$(sysctl -n machdep.cpu.thread_count)
cpu_info=$(ps -eo pcpu,user)
cpu_sys=$(echo "$cpu_info" | grep -v "$(whoami)" \
			  | sed "s/[^ 0-9\.]//g" \
			  | awk "{sum+=\$1} END {print sum/(100.0 * $core_count)}")
cpu_user=$(echo "$cpu_info" | grep "$(whoami)" \
			   | sed "s/[^ 0-9\.]//g" \
			   | awk "{sum+=\$1} END {print sum/(100.0 * $core_count)}")
cpu_percent=$(echo "$cpu_sys $cpu_user" \
				  | awk '{ printf("%.0f\n", ($1 + $2)*100) }')

sketchybar -m --set "$NAME" label="$cpu_percent"%
