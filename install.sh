#!/usr/bin/env bash
source "$ROOT_DIR/lib/logging.sh"
source "$ROOT_DIR/lib/packages.sh"
source "$ROOT_DIR/lib/services.sh"
source "$ROOT_DIR/lib/prompts.sh"

PROFILE=""
DRY_RUN=false
SKIP_DOTFILES=false

usage() {
    cat <<EOF
Usage:
  ./install.sh --profile <profile>

Options:
  --profile         Profile to execute
  --dry-run         Print actions only
  --skip-dotfiles   Do not clone/apply dotfiles
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
        --skip-dotfiles)
            SKIP_DOTFILES=true
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
export SKIP_DOTFILES

PROFILE_SCRIPT="$ROOT_DIR/profiles/${PROFILE}.sh"

if [[ ! -f "$PROFILE_SCRIPT" ]]; then
    log_error "Profile not found: $PROFILE"
    exit 1
fi

log_info "Executing profile: $PROFILE"

source "$PROFILE_SCRIPT"

log_success "Bootstrap complete"
