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

# 3 pixels on FHD; 7 on 4k
WM_BORDER=$(fraction_of 0.001822917 "$width")
export WM_BORDER

# 3 pixels on 4k
HALF_WM_BORDER=$(fraction_of 0.5 "$WM_BORDER")
export HALF_WM_BORDER

# 15 pixels on4k
CORNER_RADIUS=$(fraction_of 0.5 "$WM_GAP")
export CORNER_RADIUS

BAR_WIDTH=$((width - 2 * WM_GAP))
# 65 on 4k (slightly bigger than 60 that is 2 * WM_GAP)
BAR_HEIGHT=$(fraction_of 0.0305 "$height")
BAR_X_OFFSET=$WM_GAP
BAR_Y_OFFSET=$WM_GAP
# 3 pixels FHD; 6 on 4k
BAR_BORDER=$(fraction_of 0.0015625 "$width")
export BAR_WIDTH BAR_HEIGHT BAR_X_OFFSET BAR_Y_OFFSET BAR_BORDER

# pixels before top of windows
# first part is just 4 WM_GAP, but could be different
TOP_PADDING=$((2 * WM_GAP + BAR_HEIGHT + 2 * BAR_BORDER))
export TOP_PADDING
