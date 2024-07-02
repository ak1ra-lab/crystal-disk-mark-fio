#!/bin/bash

main() {
    device="${1:-/dev/nvme0n1}"

    action="${2:-basic}"
    case "${action}" in
    perf)
        jobs=(11-crystal-disk-mark-nvme-perf.fio)
        ;;
    extra)
        jobs=(12-crystal-disk-mark-nvme-extra.fio)
        ;;
    mix)
        jobs=(13-crystal-disk-mark-nvme-mix.fio)
        ;;
    basic)
        jobs=(11-crystal-disk-mark-nvme-perf.fio 12-crystal-disk-mark-nvme-extra.fio)
        ;;
    all)
        jobs=(11-crystal-disk-mark-nvme-perf.fio 12-crystal-disk-mark-nvme-extra.fio 13-crystal-disk-mark-nvme-mix.fio)
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
