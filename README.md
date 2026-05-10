# artix-bootstrap

A modular provisioning framework for rebuilding an Artix Linux workstation after a base installation.

The goal of this project is to provide a repeatable, maintainable and reusable workstation bootstrap process without attempting to fully automate operating system installation.

This framework is designed around a clean separation of responsibilities:

* The operating system installation is performed manually using the Artix ISO and Calamares installer
* Workstation provisioning is performed automatically using modular shell scripts
* Personal configuration is managed separately through a dedicated dotfiles repository

---

# Philosophy

This project intentionally avoids becoming a full configuration-management framework.

The design priorities are:

* Simplicity
* Transparency
* Repeatability
* Modularity
* Re-runnability
* Minimal abstraction

The framework uses:

* Bash
* OpenRC
* Pacman
* yay
* GNU Stow

There are deliberately no external provisioning frameworks, templating engines or orchestration layers.

---

# Installation Boundary

## Manual Installation Phase

The following tasks are intentionally performed manually using the Artix installer:

* Disk partitioning
* LUKS encryption
* btrfs subvolumes
* Bootloader installation
* User creation
* Locale and keyboard selection
* Network configuration
* Base desktop installation

Recommended installation target:

```text
Artix Linux
OpenRC
Minimal XFCE desktop
```

The framework assumes the machine is already bootable and network connectivity is available.

---

## Automated Provisioning Phase

Once the base operating system is installed, this framework provisions:

* Desktop applications
* Development tooling
* Docker
* Fonts and themes
* Shell environment
* OpenRC services
* Snapper and grub-btrfs
* Laptop power management
* Dotfiles

---

# Design Approach

## Modular Architecture

The framework is split into small composable modules.

Examples:

* core
* cli
* desktop
* dev
* docker
* laptop
* security
* snapper
* shell
* dotfiles

Each module is responsible for one logical area.

---

## Command Line Options

```bash
./install.sh --profile laptop-dev
```

Available options:

```text
--profile         Profile to execute
--dry-run         Print actions without executing
--skip-dotfiles   Skip dotfiles provisioning
--help            Show help
```

---

# Profiles

Profiles are lightweight wrappers around groups of modules.

Current profile:

```text
laptop-dev
```

Future profiles may include:

```text
minimal
desktop-dev
server
```

The framework uses minimal inheritance and avoids deeply nested profile logic.

---

## Modules

Current modules include:

```text
core
cli
desktop
dev
docker
dotfiles
fonts
laptop
security
shell
snapper
themes
xfce
```

Modules are sourced by profiles.

---

# Services

The framework manages OpenRC services automatically where appropriate.

Examples:

* NetworkManager
* bluetooth
* docker
* sddm
* tlp
* thermald

Services that are typically expected to start automatically are enabled during provisioning.

---

# Dotfiles Separation

Bootstrap logic and personal configuration are intentionally separated.

Bootstrap repository:

* installs packages
* configures services
* provisions workstation tooling

Dotfiles repository:

* shell configuration
* Neovim configuration
* tmux configuration
* ghostty configuration
* XFCE configuration

Dotfiles are deployed using GNU Stow.

Dotfiles repository:

[https://github.com/JoeIngle/artix-dotfiles](https://github.com/JoeIngle/artix-dotfiles)

---

# Features

* OpenRC service management
* Pacman and AUR package provisioning
* Docker tooling
* XFCE workstation setup
* Snapper and grub-btrfs integration
* Shell tooling
* Developer workstation tooling
* Logging and execution history
* Dry-run support
* GNU Stow integration
* CI validation using ShellCheck

---

# Target Workstation

The framework is currently optimised for:

```text
Artix Linux
OpenRC
XFCE
X11
btrfs
LUKS encryption
Developer workstation usage
```

Primary tooling includes:

* Python + uv
* Node.js
* Java
* Docker
* Neovim
* VS Code
* tmux
* Ghostty

---

# Repository Structure

```text
artix-bootstrap/
├── install.sh
├── README.md
├── .editorconfig
├── .shellcheckrc
├── .github/
│   └── workflows/
│       └── shellcheck.yml
├── lib/
│   ├── common.sh
│   ├── logging.sh
│   ├── packages.sh
│   ├── prompts.sh
│   └── services.sh
├── modules/
│   ├── cli.sh
│   ├── core.sh
│   ├── desktop.sh
│   ├── dev.sh
│   ├── docker.sh
│   ├── dotfiles.sh
│   ├── fonts.sh
│   ├── laptop.sh
│   ├── security.sh
│   ├── shell.sh
│   ├── snapper.sh
│   ├── themes.sh
│   └── xfce.sh
├── packages/
│   ├── aur.txt
│   ├── cli.txt
│   ├── core.txt
│   ├── desktop.txt
│   ├── dev.txt
│   ├── fonts.txt
│   ├── laptop.txt
│   └── security.txt
├── profiles/
│   └── laptop-dev.sh
└── logs/
```

---

# Package Structure

Packages are separated into logical manifests.

Examples:

```text
packages/core.txt
packages/desktop.txt
packages/dev.txt
packages/laptop.txt
packages/aur.txt
```

This keeps package management maintainable and avoids hardcoding package names inside shell scripts.

Repository packages and AUR packages are intentionally separated.

---

# Logging

All bootstrap operations are logged.

Log files are stored in:

```text
logs/
```

Log filenames are timestamped.

Example:

```text
logs/install-20260510-193000.log
```

---

# Idempotency

The framework is designed to become increasingly safe to re-run.

Examples:

* Existing packages are skipped
* Services are enabled safely
* Directories use mkdir -p
* Dotfiles prompt before overwrite
* Existing repositories are detected

---

# CI and Validation

The repository includes:

* ShellCheck
* GitHub Actions

The goal is to maintain consistent shell quality and prevent regressions.

---

# Usage

## Clone repository

```bash
git clone https://github.com/JoeIngle/artix-bootstrap.git
cd artix-bootstrap
```

## Run bootstrap

```bash
./install.sh --profile laptop-dev
```

## Dry run

```bash
./install.sh --profile laptop-dev --dry-run
```

## Skip dotfiles

```bash
./install.sh --profile laptop-dev --skip-dotfiles
```

---

# Profiles

## laptop-dev

Installs:

* XFCE desktop enhancements
* Developer tooling
* Docker
* Shell utilities
* Fonts/themes
* Snapper tooling
* Laptop power management

---

# Dotfiles

Dotfiles are managed separately:

[https://github.com/JoeIngle/artix-dotfiles](https://github.com/JoeIngle/artix-dotfiles)

GNU Stow is used to deploy configurations.

---

# Security

The framework currently provisions:

* ufw
* openssh
* gnupg
* keepassxc

Recommended firewall defaults:

* deny inbound
* allow outbound

---

# Snapper

The framework supports:

* snapper
* grub-btrfs
* automatic snapshot tooling

This is intended to provide rollback capability for rolling-release upgrades.

---

# Development Tooling

Current development tooling includes:

* Python
* uv
* Node.js
* npm
* Java
* Docker
* GitHub CLI
* VS Code
* Neovim

---

# Desktop Environment

The framework currently targets:

* XFCE
* SDDM
* PipeWire
* picom

Theme stack:

* Qogir Dark
* Tela Circle Dark
* Cantarell
* JetBrains Mono Nerd Font

---

# Future Goals

Potential future enhancements:

* Additional profiles
* Better rollback handling
* Improved XFCE provisioning
* More robust backup handling
* PostgreSQL module
* Neovim bootstrap automation
* Enhanced CI validation

---

# Contributing

This project is intentionally personal and opinionated, but contributions and ideas are welcome.

The primary goals should remain:

* Maintainability
* Transparency
* Simplicity
* Reliability

Avoid introducing unnecessary abstraction or external framework dependencies.

---

# License

MIT License

---

# install.sh

```bash
#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$ROOT_DIR/lib/common.sh"
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
```

---

# lib/common.sh

```bash
#!/usr/bin/env bash

require_root() {
    if [[ "$EUID" -ne 0 ]]; then
        echo "Please run as root"
        exit 1
    fi
}

check_command() {
    command -v "$1" >/dev/null 2>&1
}

check_internet() {
    if ! ping -c 1 archlinux.org >/dev/null 2>&1; then
        echo "No internet connectivity"
        exit 1
    fi
}

run_cmd() {
    if [[ "$DRY_RUN" == true ]]; then
        echo "[DRY RUN] $*"
    else
        "$@"
    fi
}
```

---

# lib/logging.sh

```bash
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
```

---

# lib/packages.sh

```bash
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
```

---

# lib/services.sh

```bash
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
```

---

# lib/prompts.sh

```bash
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
```

---

# profiles/laptop-dev.sh

```bash
#!/usr/bin/env bash

source "$ROOT_DIR/modules/core.sh"
source "$ROOT_DIR/modules/cli.sh"
source "$ROOT_DIR/modules/desktop.sh"
source "$ROOT_DIR/modules/fonts.sh"
source "$ROOT_DIR/modules/themes.sh"
source "$ROOT_DIR/modules/shell.sh"
source "$ROOT_DIR/modules/dev.sh"
source "$ROOT_DIR/modules/docker.sh"
source "$ROOT_DIR/modules/laptop.sh"
source "$ROOT_DIR/modules/security.sh"
source "$ROOT_DIR/modules/snapper.sh"
source "$ROOT_DIR/modules/xfce.sh"

if [[ "$SKIP_DOTFILES" == false ]]; then
    source "$ROOT_DIR/modules/dotfiles.sh"
fi
```

---

# modules/core.sh

```bash
#!/usr/bin/env bash

log_info "Installing core packages"
install_packages "$ROOT_DIR/packages/core.txt"
```

---

# modules/cli.sh

```bash
#!/usr/bin/env bash

log_info "Installing CLI tooling"
install_packages "$ROOT_DIR/packages/cli.txt"
```

---

# modules/desktop.sh

```bash
#!/usr/bin/env bash

log_info "Installing desktop packages"
install_packages "$ROOT_DIR/packages/desktop.txt"
install_aur_packages "$ROOT_DIR/packages/aur.txt"

enable_service bluetooth
enable_service NetworkManager
enable_service sddm
```

---

# modules/dev.sh

```bash
#!/usr/bin/env bash

log_info "Installing development tooling"
install_packages "$ROOT_DIR/packages/dev.txt"
```

---

# modules/docker.sh

```bash
#!/usr/bin/env bash

log_info "Configuring Docker"

enable_service docker

if ! groups "$SUDO_USER" | grep -q docker; then
    usermod -aG docker "$SUDO_USER"
fi
```

---

# modules/fonts.sh

```bash
#!/usr/bin/env bash

log_info "Installing fonts"
install_packages "$ROOT_DIR/packages/fonts.txt"
```

---

# modules/laptop.sh

```bash
#!/usr/bin/env bash

log_info "Installing laptop tooling"
install_packages "$ROOT_DIR/packages/laptop.txt"

enable_service tlp
enable_service thermald
```

---

# modules/security.sh

```bash
#!/usr/bin/env bash

log_info "Installing security tooling"
install_packages "$ROOT_DIR/packages/security.txt"

run_cmd ufw default deny incoming
run_cmd ufw default allow outgoing
run_cmd ufw enable
```

---

# modules/shell.sh

```bash
#!/usr/bin/env bash

log_info "Configuring shell environment"

install_packages "$ROOT_DIR/packages/cli.txt"
```

---

# modules/snapper.sh

```bash
#!/usr/bin/env bash

log_info "Installing snapper tooling"

install_packages "$ROOT_DIR/packages/core.txt"

if confirm "Configure snapper for root filesystem?"; then
    run_cmd snapper -c root create-config /
fi
```

---

# modules/themes.sh

```bash
#!/usr/bin/env bash

log_info "Installing themes"
install_aur_packages "$ROOT_DIR/packages/aur.txt"
```

---

# modules/xfce.sh

```bash
#!/usr/bin/env bash

log_info "Applying XFCE defaults"

mkdir -p /etc/skel/.config
```

---

# modules/dotfiles.sh

```bash
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
```

---

# packages/core.txt

```text
git
curl
wget
rsync
openssh
base-devel
```

---

# packages/cli.txt

```text
bat
eza
fastfetch
fd
fzf
jq
ripgrep
starship
tmux
tree
yazi
zoxide
btop
```

---

# packages/desktop.txt

```text
firefox
ghostty
networkmanager
network-manager-applet
pipewire
pipewire-pulse
wireplumber
bluez
bluez-utils
blueman
sddm
vlc
gwenview
```

---

# packages/dev.txt

```text
python
uv
nodejs
npm
jdk-openjdk
neovim
github-cli
docker
docker-compose
code
```

---

# packages/fonts.txt

```text
cantarell-fonts
noto-fonts
noto-fonts-emoji
ttf-jetbrains-mono-nerd
```

---

# packages/laptop.txt

```text
acpi
brightnessctl
fwupd
nvme-cli
powertop
smartmontools
thermald
tlp
```

---

# packages/security.txt

```text
keepassxc
ufw
gnupg
```

---

# packages/aur.txt

```text
onlyoffice-bin
qogir-gtk-theme
tela-circle-icon-theme
```

---

# .shellcheckrc

```text
external-sources=true
```

---

# .editorconfig

```ini
root = true

[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
indent_style = space
indent_size = 4
trim_trailing_whitespace = true
```

---

# .github/workflows/shellcheck.yml

```yaml
name: shellcheck

on:
  push:
  pull_request:

jobs:
  shellcheck:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Install ShellCheck
        run: sudo apt-get update && sudo apt-get install -y shellcheck

      - name: Run ShellCheck
        run: |
          find . -type f -name "*.sh" -exec shellcheck {} +
```
