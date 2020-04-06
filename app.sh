#!/usr/bin/env sh
cd $HOME

sudo pacman -Rcns --noconfirm manjaro-hello
sudo pacman -Rcns $(pacman -Qnq | grep manjaro-gnome*)
sudo pacman -Rcns $(pacman -Qnq | grep gnome*)
sudo pacman -Rcns $(pacman -Qnq | grep maia)

echo "Installing desktop apps ..."
sudo pacman -Syu --needed  dunst pamac \
  network-manager-applet nm-connection-editor networkmanager \
  light dex \
  ranger \
  feh \
  zathura polkit-gnome gnome \
  xcursor-breeze papirus-icon-theme \
  blueman xorg-xsetroot \
  ibus ibus-hangul \
  ttf-font-awesome noto-fonts noto-fonts-extra noto-fonts-cjk noto-fonts-emoji \
  ttf-roboto \
  yad rofi polybar picom bspwm bspwm-scripts sxhkd python-pywal \
  gnome-disk-utility yay \
  discord chromium snapd code docker kitty

echo "Setting up snapd ..."
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap

echo "Add user to docker group ..."
sudo usermod -a -G docker $USER

echo "Add user to video group ..."
sudo usermod -a -G video $USER

rm -rf $HOME/.local/share/keyrings/*
