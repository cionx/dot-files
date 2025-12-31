#!/usr/bin/env nu

let percent_str: string = cat /sys/class/hwmon/hwmon3/device/gpu_busy_percent
let percent: float = $percent_str | into float
let padding = if ($percent < 10) {" "} else {""}
let text = $padding + $"($percent | into string --decimals 0)"
let output = {
	text: $text,
	class: "gpu_usage",
	percentage: $percent,
}
let output_json = $output | to json --raw
echo $output_json
