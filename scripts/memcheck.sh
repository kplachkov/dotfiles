#!/usr/bin/env bash

function memcheck() {
	echo "Running memory check..."

	local threshold=0.85 # [0, 1]
	local normal_mem_interval=10
	local low_mem_interval=60

	echo "Notifications threshold: $(echo "$threshold * 100" | bc)%"

	while true; do
		mem_total=$(free -m | awk '/^Mem:/{print $2}')
		mem_used=$(free -m | awk '/^Mem:/{print $3}')
		swap_total=$(free -m | awk '/^Swap:/{print $2}')
		swap_used=$(free -m | awk '/^Swap:/{print $3}')

		total=$(echo "$mem_total + $swap_total" | bc)
		used=$(echo "$mem_used + $swap_used" | bc)

		echo ""
		echo "Memory status - $(date)"
		echo "Total memory: $total"
		echo "Used memory: $used"

		if [[ $(printf "%.0f" "$(echo "$total * $threshold" | bc)") -gt $used ]]; then
			sleep $normal_mem_interval
			continue
		fi

		notify-send -u critical "Available memory - less than $(echo "100 - $threshold * 100" | bc)%"
		ring_bell

		sleep $low_mem_interval
	done
}

function ring_bell() {
	local bell_interval=0.25

	printf '\a'
	sleep $bell_interval
	printf '\a'
	sleep $bell_interval
	printf '\a'
}

memcheck
