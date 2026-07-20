#!/bin/sh

# Changes the wallpaper to a randomly chosen image in a given directory
# at a set interval.

# https://codeberg.org/LGFae/awww/src/commit/25ea4fd7a42359379da9ddadedda1c477caa4ae0/example_scripts/awww_randomize.sh

DEFAULT_INTERVAL=300 # In seconds

if [ $# -lt 1 ] || [ ! -d "$1" ]; then
	printf "Usage:\n\t\e[1m%s\e[0m \e[4mDIRECTORY\e[0m [\e[4mINTERVAL\e[0m]\n" "$0"
	printf "\tChanges the wallpaper to a randomly chosen image in DIRECTORY every\n\tINTERVAL seconds (or every %d seconds if unspecified)." "$DEFAULT_INTERVAL"
	exit 1
fi

# See awww-img(1)
RESIZE_TYPE="fit"
export AWWW_TRANSITION_FPS="${AWWW_TRANSITION_FPS:-60}"
export AWWW_TRANSITION_STEP="${AWWW_TRANSITION_STEP:-2}"

while true; do
	find "$1" -type f \
	| while read -r img; do
		echo "$(</dev/urandom tr -dc a-zA-Z0-9 | head -c 8):$img"
	done \
	| sort -n | cut -d':' -f2- \
	| while read -r img; do
		awww img --resize="$RESIZE_TYPE" "$img"
		sleep "${2:-$DEFAULT_INTERVAL}"
	done
done
