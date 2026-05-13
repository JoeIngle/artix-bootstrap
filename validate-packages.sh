#!/usr/bin/env bash
# validate-packages.sh
# Run this on an Arch/Artix system with pacman and yay or paru installed.

set -euo pipefail

# Directory containing package manifests
PKGDIR="packages"

# Use yay or paru for AUR checks
yay_bin="$(command -v yay || command -v paru || true)"
if [[ -z "$yay_bin" ]]; then
    echo "Error: yay or paru is required for AUR checks." >&2
    exit 1
fi

missing_pkgs=()

for file in "$PKGDIR"/*.txt; do
    echo "Checking $file..."
    grep -v '^#' "$file" | grep -v '^$' | while read -r pkg; do
        if pacman -Si "$pkg" &>/dev/null; then
            echo "[pacman] $pkg"
        elif "$yay_bin" -Si "$pkg" &>/dev/null; then
            echo "[AUR]    $pkg"
        else
            echo "[MISSING] $pkg (from $file)"
            missing_pkgs+=("$pkg ($file)")
        fi
    done
    echo
done

if [[ ${#missing_pkgs[@]} -gt 0 ]]; then
    echo "Summary: The following packages were not found in pacman or AUR:"
    for m in "${missing_pkgs[@]}"; do
        echo "  $m"
    done
    exit 2
else
    echo "All packages found in pacman or AUR."
fi
