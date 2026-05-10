#!/usr/bin/env bash

DOTFILES_DIR="/home/$SUDO_USER/artix-dotfiles"

if [[ -d "$DOTFILES_DIR" ]]; then
    log_warn "Dotfiles repo already exists"
else
    log_info "Cloning dotfiles repository"

    run_cmd git clone \
        https://github.com/JoeIngle/artix-dotfiles.git \
        "$DOTFILES_DIR"
fi

install_packages <(echo stow)

cd "$DOTFILES_DIR"

if confirm "Apply dotfiles with GNU Stow?"; then
    run_cmd sudo -u "$SUDO_USER" stow bash git ghostty nvim tmux
fi
