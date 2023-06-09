fraction_of() { # <decimal number> <total>
	# awk "BEGIN {printf(\"%.0f\", $1 * $2)}"
	# slightly faster
	echo "($1 * $2) / 1" | bc
}

# max
width=$(system_profiler SPDisplaysDataType | awk '/Resolution/ {print $2}')
height=$(system_profiler SPDisplaysDataType | awk '/Resolution/ {print $4}')

# 15 pixels on FHD; 30 on 4k
WM_GAP=$(fraction_of 0.0078125 "$width")
export WM_GAP

PADDING=$WM_GAP
# 7 pixels on FHD; 15 on 4k
HALF_PADDING=$(fraction_of 0.004 "$width")
export PADDING HALF_PADDING

# 3 pixels on FHD; 7 on 4k
WM_BORDER=$(fraction_of 0.001822917 "$width")
export WM_BORDER

# 3 pixels on 4k
HALF_WM_BORDER=$(fraction_of 0.5 "$WM_BORDER")
export HALF_WM_BORDER

# 15 pixels on4k
CORNER_RADIUS=$(fraction_of 0.5 "$WM_GAP")
export CORNER_RADIUS

# 65 on 4k (slightly bigger than 60 that is 2 * WM_GAP)
# BAR_HEIGHT=$(fraction_of 0.0305 "$height")

# 25 on FHD; 50 on 4k; based on default macOS menubar
BAR_HEIGHT=$(fraction_of 0.0235 "$height")
# 15 on FHD; 30 on 4k
UNDERLINE_OFFSET=-$(fraction_of 0.014 "$height")
export BAR_HEIGHT UNDERLINE_OFFSET

# matching normal bar aesthetic, so not floating
# BAR_WIDTH=$((width - 2 * WM_GAP))
# BAR_X_OFFSET=$WM_GAP
# BAR_Y_OFFSET=$WM_GAP

# no border for now to match macOS menubar
# 3 pixels FHD; 6 on 4k
# BAR_BORDER=$(fraction_of 0.0015625 "$width")
