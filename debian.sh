#! /bin/bash

sudo snap list

sudo snap remove --purge lxd 2>/dev/null || true
sudo snap remove --purge core24 2>/dev/null || true
sudo snap remove --purge snapd 2>/dev/null || true

sudo apt purge snapd
sudo apt autoremove --purge

sudo tee /etc/apt/preferences.d/no-snapd >/dev/null <<'EOF'
Package: snapd
Pin: release *
Pin-Priority: -1
EOF

sudo apt update

sudo apt install curl gpg

sudo add-apt-repository ppa:avengemedia/danklinux
sudo add-apt-repository ppa:avengemedia/dms

sudo apt update
sudo apt install niri dms libwayland-server0 thunar alacritty thunar gvfs kdeconnect emacs power-profiles-daemon pipewire wireplumber lxpolkit wl-clipboard xdg-desktop-portal-gtk brightnessctl playerctl upower

sudo systemctl --user set-environment DMS_PREFERRED_BATTERY="/org/freedesktop/UPower/devices/battery_BAT1"

suod apt install flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak install flathub net.waterfox.waterfox
flatpak install flathub org.keepassxc.KeePassXC

mkdir -p .config/environment.d/

echo "XDG_DATA_DIRS=$HOME/.local/share/flatpak/export/share:/var/lib/flatpak/exports/share:${XDG_DATA_DIRS:-/usr/local/share:/usr/share}" > .config/environment.d/flatpak.conf

flatpak override --user --filesystem=xdg-config/gtk-3.0:ro
flatpak override --user --filesystem=xdg-config/gtk-4.0:ro

flatpak override --user --filesystem=xdg-config/qt5ct:ro
flatpak override --user --env=QT_QPA_PLATFORMTHEME=qt5ct
flatpak override --user --filesystem=xdg-config/qt6ct:ro
flatpak override --user --env=QT_QPA_PLATFORMTHEME=qt6ct
