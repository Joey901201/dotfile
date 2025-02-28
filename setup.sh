#!/usr/bin/env bash

dry_run="0"
while [[ $# -gt 0 ]]; do
    if [[ "$1" == "--dry" ]]; then
        dry_run="1"
    fi
    shift
done

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

#check if DEV_ENV was set
if [[ -n "$DEV_ENV" ]]; then
    echo "DEV_ENV has been set to: $DEV_ENV"
    read -p "Do you want to overwrite DEV_ENV with default path ($HOME/dev_env)? (y/n): " overwrite_env
    if [[ "$overwrite_env" == "y" ]]; then
        export DEV_ENV="$HOME/dev_env"
    fi
else
    export DEV_ENV="$HOME/dev_env"
fi

log "Updating and upgrading system"
execute sudo apt -y update
execute sudo apt -y upgrade

log "Installing git"
execute sudo apt -y install git

log "Creating dev_env at $DEV_ENV"
execute mkdir -p "$DEV_ENV"

log "Cloning dotfile"
if [[ -d "$DEV_ENV/dotfile" ]]; then
    log "dotfile already exists, pulling latest changes"
    execute git -C "$DEV_ENV/dotfile" pull
else
    execute git clone https://github.com/Joey901201/dotfile.git "$DEV_ENV/dotfile"
fi

log "Updating submodules"
execute git submodule update --init --remote
execute git -C "$DEV_ENV/dotfile/nvim" checkout main
