#!/usr/bin/env bash

log_info "Installing laptop tooling"
install_packages "$ROOT_DIR/packages/laptop.txt"

enable_service tlp
enable_service thermald
