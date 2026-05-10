#!/usr/bin/env bash

confirm() {
    local prompt="$1"

    read -rp "$prompt [Y/n]: " response

    case "$response" in
        [nN][oO]|[nN])
            return 1
            ;;
        *)
            return 0
            ;;
    esac
}
