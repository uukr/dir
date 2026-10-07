#!/usr/bin/env fish

env DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus \
    XDG_RUNTIME_DIR=/run/user/1000 \
    /usr/bin/fish -c 'qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript '\''panelById(28).hiding = panelById(28).hiding == "autohide" ? "none" : "autohide"'\'''
