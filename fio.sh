#!/bin/bash

main() {
    device="${1:-/dev/nvme0n1}"
    test -b "${device}" || exit 1

    action="${2:-basic}"
    case "${action}" in
    perf)
        jobs=(01-crystal-disk-mark-nvme-perf.fio)
        ;;
    extra)
        jobs=(02-crystal-disk-mark-nvme-extra.fio)
        ;;
    mix)
        jobs=(03-crystal-disk-mark-nvme-mix.fio)
        ;;
    basic)
        jobs=(01-crystal-disk-mark-nvme-perf.fio 02-crystal-disk-mark-nvme-extra.fio)
        ;;
    all)
        jobs=(01-crystal-disk-mark-nvme-perf.fio 02-crystal-disk-mark-nvme-extra.fio 03-crystal-disk-mark-nvme-mix.fio)
        ;;
    *)
        exit 0
        ;;
    esac

    test -d results || mkdir -p results
    for job in "${jobs[@]}"; do
        fio --filename="${device}" --output="results/${device##*/}-${job%.fio}-$(date +%F.%s).txt" "${job}"
    done
}

main "$@"
