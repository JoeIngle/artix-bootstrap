#!/usr/bin/env bash

log_info "Installing security tooling"
install_packages "$ROOT_DIR/packages/security.txt"

run_cmd ufw default deny incoming
run_cmd ufw default allow outgoing
run_cmd ufw enable
