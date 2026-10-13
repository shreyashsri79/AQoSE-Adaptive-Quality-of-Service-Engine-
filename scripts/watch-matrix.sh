#!/bin/sh
# Live progress of a matrix run, from its results directory:
#   scripts/watch-matrix.sh results-smoke [total runs]
# Finished runs with their verdict, then the log of the run in progress.
dir=${1:-results-smoke}
total=${2:-45}
cd "$(dirname "$0")/.." || exit 1
while :; do
	clear
	finished=$(ls "$dir"/*/manifest.json 2>/dev/null | wc -l)
	echo "$dir: $finished of $total runs finished    $(date +%H:%M:%S)"
	echo
	for manifest in $(ls -tr "$dir"/*/manifest.json 2>/dev/null | tail -15); do
		run=$(basename "$(dirname "$manifest")")
		if grep -q '"valid": true' "$manifest"; then
			echo "  valid    $run"
		else
			echo "  INVALID  $run: $(grep invalid_reason "$manifest" | cut -c22-140)"
		fi
	done
	current=$(readlink "$dir/current")
	if [ -n "$current" ] && [ ! -f "$dir/$current/manifest.json" ]; then
		echo
		echo "running: $current"
		tail -n 6 "$dir/$current/runner.log" 2>/dev/null | cut -c1-150
	fi
	sleep 5
done
