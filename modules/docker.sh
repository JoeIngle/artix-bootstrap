#!/usr/bin/env bash

log_info "Configuring Docker"

enable_service docker

if ! groups "$SUDO_USER" | grep -q docker; then
    usermod -aG docker "$SUDO_USER"
fi
