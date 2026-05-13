#!/usr/bin/env bash

LOG_DIR="$ROOT_DIR/logs"
mkdir -p "$LOG_DIR"

LOG_FILE="$LOG_DIR/install-$(date +%Y%m%d-%H%M%S).log"

setup_logging() {
    exec > >(tee -a "$LOG_FILE") 2>&1
}

log_info() {
    echo "[INFO] $1"
}

log_warn() {
    echo "[WARN] $1"
}

log_error() {
    echo "[ERROR] $1"
}

log_success() {
    echo "[OK] $1"
}
