#!/usr/bin/env bash

require_root() {
    if [[ "$EUID" -ne 0 ]]; then
        echo "Please run as root"
        exit 1
    fi
}

check_command() {
    command -v "$1" >/dev/null 2>&1
}

check_internet() {
    if ! ping -c 1 archlinux.org >/dev/null 2>&1; then
        echo "No internet connectivity"
        exit 1
    fi
}

run_cmd() {
    if [[ "$DRY_RUN" == true ]]; then
        echo "[DRY RUN] $*"
    else
        "$@"
    fi
}
