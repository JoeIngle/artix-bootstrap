#!/usr/bin/env bash

install_packages() {
    local package_file="$1"

    if [[ ! -f "$package_file" ]]; then
        log_error "Missing package file: $package_file"
        return 1
    fi

    mapfile -t packages < <(grep -v '^#' "$package_file" | sed '/^$/d')

    if [[ ${#packages[@]} -eq 0 ]]; then
        return 0
    fi

    run_cmd pacman -Syu --noconfirm --needed "${packages[@]}"
}

install_aur_packages() {
    local package_file="$1"

    if ! check_command yay; then
        install_yay
    fi

    mapfile -t packages < <(grep -v '^#' "$package_file" | sed '/^$/d')

    if [[ ${#packages[@]} -eq 0 ]]; then
        return 0
    fi

    # Always run yay as the invoking user, not root
    if [[ $EUID -eq 0 ]]; then
        if [[ -n "$SUDO_USER" ]]; then
            sudo -u "$SUDO_USER" yay -S --noconfirm --needed "${packages[@]}"
        else
            log_error "Cannot determine non-root user for yay. Aborting."
            return 1
        fi
    else
        yay -S --noconfirm --needed "${packages[@]}"
    fi
}

install_yay() {
    log_info "Installing yay"

    pacman -S --noconfirm --needed git base-devel

    local tmp_dir
    tmp_dir=$(mktemp -d)

    git clone https://aur.archlinux.org/yay.git "$tmp_dir/yay"

    chown -R "$SUDO_USER:$SUDO_USER" "$tmp_dir"

    cd "$tmp_dir/yay"

    sudo -u "$SUDO_USER" makepkg -si --noconfirm

    cd - >/dev/null

    rm -rf "$tmp_dir"
}
