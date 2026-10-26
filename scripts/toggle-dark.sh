
#!/usr/bin/env bash
set -euo pipefail

# Persistent state
STATE="${XDG_STATE_HOME:-$HOME/.local/state}/theme-mode"
mkdir -p "$(dirname "$STATE")"

# Detect current mode using GNOME's standard preference
if command -v gsettings >/dev/null 2>&1 &&
   gsettings list-schemas | grep -qx 'org.gnome.desktop.interface'; then
    CURRENT="$(gsettings get org.gnome.desktop.interface color-scheme)"
else
    CURRENT="'prefer-light'"
fi

if [[ "$CURRENT" == "'prefer-dark'" ]]; then
    MODE="light"
    SCHEME="prefer-light"
    GTK_THEME="Adwaita"
else
    MODE="dark"
    SCHEME="prefer-dark"
    GTK_THEME="Adwaita-dark"
fi

# Standard desktop color-scheme preference
if command -v gsettings >/dev/null 2>&1 &&
   gsettings list-schemas | grep -qx 'org.gnome.desktop.interface'; then
    gsettings set org.gnome.desktop.interface color-scheme "$SCHEME"
    gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME"
fi

# GTK 3 fallback / override
if command -v gsettings >/dev/null 2>&1 &&
   gsettings list-schemas | grep -qx 'org.gnome.desktop.interface'; then
    :
fi

# Persist our selected mode for other scripts
printf '%s\n' "$MODE" > "$STATE"

# Optional: GTK 4/libadwaita apps also follow color-scheme above.
# Optional: enable a matching Qt theme separately if you have one installed.

# Smooth Niri transition, if available
if command -v niri >/dev/null 2>&1; then
    niri msg action do-screen-transition 2>/dev/null || true
fi

# Optional notification
if command -v notify-send >/dev/null 2>&1; then
    notify-send "Theme switched" "Now using ${MODE} mode"
fi

echo "Switched to ${MODE} mode"
