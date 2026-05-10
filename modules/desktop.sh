#!/usr/bin/env bash

log_info "Installing desktop packages"
install_packages "$ROOT_DIR/packages/desktop.txt"
install_aur_packages "$ROOT_DIR/packages/aur.txt"

enable_service bluetooth
enable_service NetworkManager
enable_service sddm
