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

    run_cmd yay -S --noconfirm --needed "${packages[@]}"
}

install_yay() {
    log_info "Installing yay"

    run_cmd pacman -S --noconfirm --needed git base-devel

    local tmp_dir
    tmp_dir=$(mktemp -d)

    git clone https://aur.archlinux.org/yay.git "$tmp_dir/yay"

    cd "$tmp_dir/yay"
    makepkg -si --noconfirm

    cd - >/dev/null

    rm -rf "$tmp_dir"
}
