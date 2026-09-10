#! /bin/bash

apt install curl gpg

echo "deb http://deb.debian.org/debian trixie-backports main" | \
  tee /etc/apt/sources.list.d/trixie-backports.list
apt update
apt install -t trixie-backports quickshell

curl -fsSL https://download.opensuse.org/repositories/home:AvengeMedia:danklinux/Debian_13/Release.key | \
  gpg --dearmor -o /etc/apt/keyrings/danklinux.gpg
echo "deb [signed-by=/etc/apt/keyrings/danklinux.gpg] https://download.opensuse.org/repositories/home:/AvengeMedia:/danklinux/Debian_13/ /" | \
  tee /etc/apt/sources.list.d/danklinux.list

curl -fsSL https://download.opensuse.org/repositories/home:/AvengeMedia:/dms/Debian_13/Release.key | \
  gpg --dearmor -o /etc/apt/keyrings/avengemedia-dms.gpg
echo "deb [signed-by=/etc/apt/keyrings/avengemedia-dms.gpg] https://download.opensuse.org/repositories/home:/AvengeMedia:/dms/Debian_13/ /" | \
  tee /etc/apt/sources.list.d/avengemedia-dms.list

apt update
apt install niri dms libwayland-server0 thunar alacritty thunar gvfs kdeconnect emacs power-profiles-daemon pipewire wireplumber lxpolkit wl-clipboard xdg-desktop-portal-gtk brightnessctl playerctl upower

systemctl --user set-environment DMS_PREFERRED_BATTERY="/org/freedesktop/UPower/devices/battery_BAT1"

apt install flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak install flathub net.waterfox.waterfox
flatpak install flathub org.keepassxc.KeePassXC

echo "XDG_DATA_DIRS=$HOME/.local/share/flatpak/export/share:/var/lib/flatpak/exports/share:${XDG_DATA_DIRS:-/usr/local/share:/usr/share}" > .config/environment.d/flatpak.conf

flatpak override --user --filesystem=xdg-config/gtk-3.0:ro
flatpak override --user --filesystem=xdg-config/gtk-4.0:ro

flatpak override --user --filesystem=xdg-config/qt5ct:ro
flatpak override --user --env=QT_QPA_PLATFORMTHEME=qt5ct
flatpak override --user --filesystem=xdg-config/qt6ct:ro
flatpak override --user --env=QT_QPA_PLATFORMTHEME=qt6ct
