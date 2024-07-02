#!/bin/sh

device=${1:-/dev/nvme0n1}
test -b "${device}" || exit 1

test -d results || mkdir -p results

job=crystal-disk-mark-nvme
fio --filename="${device}" --output="results/${device#/dev/}-${job}-$(date +%F.%s).txt" "${job}.fio"

job=crystal-disk-mark-nvme-mix
fio --filename="${device}" --output="results/${device#/dev/}-${job}-$(date +%F.%s).txt" "${job}.fio"
