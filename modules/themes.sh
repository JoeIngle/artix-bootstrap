#!/usr/bin/env bash



log_info "Installing themes"
install_aur_packages "$ROOT_DIR/packages/themes-aur.txt"

# Set theme, icon, and font defaults for new users
SKEL_GTK3="/etc/skel/.config/gtk-3.0/settings.ini"
SKEL_GTK4="/etc/skel/.config/gtk-4.0/settings.ini"
SKEL_FONTS="/etc/skel/.config/fontconfig/fonts.conf"

mkdir -p "$(dirname "$SKEL_GTK3")" "$(dirname "$SKEL_GTK4")" "$(dirname "$SKEL_FONTS")"

# Theme and icon values
GTK_THEME="Qogir-dark"
ICON_THEME="Tela-circle-dark"
FONT_NAME="Noto Sans 10"

# Write GTK 3 settings
cat > "$SKEL_GTK3" <<EOF
[Settings]
gtk-theme-name=$GTK_THEME
gtk-icon-theme-name=$ICON_THEME
gtk-font-name=$FONT_NAME
EOF

# Write GTK 4 settings
cat > "$SKEL_GTK4" <<EOF
[Settings]
gtk-theme-name=$GTK_THEME
gtk-icon-theme-name=$ICON_THEME
gtk-font-name=$FONT_NAME
EOF

# Write fontconfig (optional, fallback)
cat > "$SKEL_FONTS" <<EOF
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
	<match target="pattern">
		<edit name="family" mode="assign" binding="strong">
			<name>Noto Sans</name>
		</edit>
		<edit name="size" mode="assign">
			<double>10</double>
		</edit>
	</match>
</fontconfig>
EOF

# Optionally apply to current user if running interactively
if [ -n "$HOME" ] && [ -w "$HOME" ]; then
	USER_GTK3="$HOME/.config/gtk-3.0/settings.ini"
	USER_GTK4="$HOME/.config/gtk-4.0/settings.ini"
	USER_FONTS="$HOME/.config/fontconfig/fonts.conf"
	mkdir -p "$(dirname "$USER_GTK3")" "$(dirname "$USER_GTK4")" "$(dirname "$USER_FONTS")"
	cp "$SKEL_GTK3" "$USER_GTK3"
	cp "$SKEL_GTK4" "$USER_GTK4"
	cp "$SKEL_FONTS" "$USER_FONTS"
fi
