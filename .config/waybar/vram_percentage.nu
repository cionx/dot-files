#!/usr/bin/env nu

use my_lib.nu map

# amdgpu_top will give us recordings of the form
#   {unit: "MiB", size: ⟨size in MiB⟩} .
# We want to transform this into
#   {MiB: ⟨size in MiB⟩, GiB: ⟨size in GiB⟩} .
def calcSize [info: record<unit: string, value: int>] {
	let sizeMiB: int = $info.value
	let sizeGiB: float = $sizeMiB / 1024
	return {"MiB": $sizeMiB, "GiB": $sizeGiB}
}

# We will use amdgpu_top to produce
# a table of the following form:
#
#  ╭──────────────────┬────────────────╮
#  │                  │ ╭─────┬──────╮ │
#  │ Total GTT        │ │ MiB │ 7991 │ │
#  │                  │ │ GiB │ 7.80 │ │
#  │                  │ ╰─────┴──────╯ │
#  │                  │ ╭─────┬──────╮ │
#  │ Total GTT Usage  │ │ MiB │ 346  │ │
#  │                  │ │ GiB │ 0.34 │ │
#  │                  │ ╰─────┴──────╯ │
#  │                  │ ╭─────┬──────╮ │
#  │ Total VRAM       │ │ MiB │ 8176 │ │
#  │                  │ │ GiB │ 7.98 │ │
#  │                  │ ╰─────┴──────╯ │
#  │                  │ ╭─────┬──────╮ │
#  │ Total VRAM Usage │ │ MiB │ 2063 │ │
#  │                  │ │ GiB │ 2.01 │ │
#  │                  │ ╰─────┴──────╯ │
#  ╰──────────────────┴────────────────╯
#
let meminfo = (
	amdgpu_top --dump --json | from json # Get all the information as a table.
	| get 0 | get VRAM                   # Extract the memory information.
	| map {|info| calcSize $info}        # Express the sizes in the desired form.
	)

let usedVRAM = $meminfo."Total VRAM Usage".GiB
let totalVRAM = $meminfo."Total VRAM".GiB
let percentageVRAM = $usedVRAM / $totalVRAM * 100

let usedGTT = $meminfo."Total GTT Usage".GiB
let totalGTT = $meminfo."Total GTT".GiB
let percentageGTT = $usedGTT / $totalGTT * 100

let text = $"($percentageVRAM | into int)% · ($percentageGTT | into int)%"

let usedVRAMstring = $usedVRAM | into string --decimals 1
let totalVRAMstring = $totalVRAM | into string --decimals 1
let usedGTTstring = $usedGTT | into string --decimals 1
let totalGTTstring = $totalGTT | into string --decimals 1

let tooltip = $"VRAM: ($usedVRAMstring) GiB / ($totalVRAMstring) GiB\nGTT:  ($usedGTTstring) GiB / ($totalGTTstring) GiB"

let output = {
	"text": $text,
	"tooltip": $tooltip,
	"class": "gpu_meminfo",
	"usedVRAM": $usedVRAM,
	"totalVRAM": $totalVRAM,
	"percentageVRAM": $percentageVRAM,
	"usedGTT": $usedGTT,
	"totalGTT": $totalGTT,
	"percentageGTT": $percentageGTT
}

let output_json = $output | to json --raw
return $output_json
