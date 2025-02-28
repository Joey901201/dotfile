#!/usr/bin/env bash

script_dir=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
filter=""
dry_run="0"

while [[ $# -gt 0 ]]; do
    if [[ "$1" == "--dry" ]]; then
        dry_run="1"
    else
        filter="$1"
    fi
    shift
done

export DRY_RUN="$dry_run"

log() {
    if [[ "$dry_run" == "1" ]]; then
        echo "[DRY_RUN]: $@"
    else
        echo "$@"
    fi
}

execute() {
    log "execute $@"
    if [[ "$dry_run" == "1" ]]; then
        return
    fi
    "$@"
}

log "$script_dir -- $filter"
cd $script_dir

scripts=$(find ./installs -maxdepth 1 -mindepth 1 -executable -type f)

for script in $scripts; do
    if echo "$script" | grep -qv "$filter"; then
        log "filtering $script"
        continue
    fi

    execute ./$script
done
