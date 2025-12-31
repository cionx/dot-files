#!/usr/bin/env nu

use my_lib.nu map
use std repeat

let updateRate = 0.5sec
let timeWindow = 10sec # Should be a multiple of $updateRate.
let sampleNumber = ($timeWindow / $updateRate) | into int

def speedFormat [] {
  $in | into string
}

def totalFormat [] {
  $in | into string
}

def getTotal [] {
  ip -j -s link show dev wlp2s0 | from json
  | get stats64 | get 0
  | map {|r| $r.bytes | into filesize}
}

mut oldTotals: list<record<rx: filesize, tx: filesize>> = getTotal | repeat $sampleNumber

while true {
  let newTotal: record<rx: filesize, tx: filesize> = getTotal
  let oldestTotal = $oldTotals | first
  let diff: record<rx: filesize, tx: filesize> = {
    rx: ($newTotal.rx - $oldestTotal.rx),
    tx: ($newTotal.tx - $oldestTotal.tx)
  }
  let speed = $diff | map {|sizeDiff| $sizeDiff / ($timeWindow / 1sec)} # We compute speed per second.

  let text = $"($speed.rx | speedFormat)/s ↓"
  let tooltip = $"Rolling average download and upload speeds over the past ($timeWindow):\n↓ ($speed.rx | speedFormat)/s  ·  ↑ ($speed.tx | speedFormat)/s\n\nTotal download and upload since system start:\n↓ ($newTotal.rx | totalFormat)  ·  ↑ ($newTotal.tx | totalFormat)"

  let output = {
    text: $text,
    tooltip: $tooltip,
    class: "",
    speedDown: "",
    speedUp: "",
    totalDown: $newTotal.rx,
    totalUp: $newTotal.tx
  }

  let output_json = $output | to json --raw
  print $output_json

  $oldTotals = $oldTotals | skip 1 | append $newTotal

  sleep $updateRate
}
