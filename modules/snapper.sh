#!/usr/bin/env bash

log_info "Installing snapper tooling"

install_packages "$ROOT_DIR/packages/core.txt"

if confirm "Configure snapper for root filesystem?"; then
    run_cmd snapper -c root create-config /
fi
