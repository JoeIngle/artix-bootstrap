#!/usr/bin/env bash

enable_service() {
    local service="$1"

    log_info "Enabling service: $service"

    run_cmd rc-update add "$service" default
    run_cmd rc-service "$service" start
}

disable_service() {
    local service="$1"

    log_info "Disabling service: $service"

    run_cmd rc-update del "$service" default || true
    run_cmd rc-service "$service" stop || true
}
