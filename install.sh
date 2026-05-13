#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$ROOT_DIR/lib/logging.sh"
source "$ROOT_DIR/lib/packages.sh"
source "$ROOT_DIR/lib/services.sh"
source "$ROOT_DIR/lib/prompts.sh"

PROFILE=""
DRY_RUN=false

usage() {
    cat <<EOF
Usage:
  ./install.sh --profile <profile>

Options:
  --profile         Profile to execute
  --dry-run         Print actions only
  -h, --help        Show this help
EOF
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --profile)
            PROFILE="$2"
            shift 2
            ;;
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            usage
            exit 1
            ;;
    esac
done

if [[ -z "$PROFILE" ]]; then
    echo "No profile specified"
    usage
    exit 1
fi

setup_logging
require_root
check_internet

export ROOT_DIR
export DRY_RUN

PROFILE_SCRIPT="$ROOT_DIR/profiles/${PROFILE}.sh"

if [[ ! -f "$PROFILE_SCRIPT" ]]; then
    log_error "Profile not found: $PROFILE"
    exit 1
fi

log_info "Executing profile: $PROFILE"

source "$PROFILE_SCRIPT"

log_success "Bootstrap complete"
