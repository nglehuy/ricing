#!/bin/bash

echo "Installing apps ..."
sudo pacman -Syu --needed --noconfirm dunst \
  network-manager-applet nm-connection-editor networkmanager \
  light dex \
  ranger \
  feh \
  zathura polkit-gnome gnome gnome-screensaver \
  papirus-icon-theme \
  blueman xorg-xsetroot \
  ibus ibus-hangul \
  ttf-font-awesome noto-fonts noto-fonts-extra noto-fonts-cjk noto-fonts-emoji \
  yad rofi picom sxhkd bspwm python-pywal \
  gnome-disk-utility \
  discord kitty

yay -Syu --needed --noconfirm slack-desktop ibus-bamboo nerd-fonts-fira-code radeontop oomox polybar

echo "Add user to video group ..."
sudo usermod -a -G video $USER

echo "Linking home directory ..."
cp -l -f -T -r $PWD/home $HOME

echo "Linking .config directory ..."
cp -l -f -T -r $PWD/config $HOME/.config

echo "Linking /root/.config/gtk-3.0 directory ..."
sudo cp -l -f -T -r $PWD/config/gtk-3.0 /root/.config/gtk-3.0

echo "Linking /root/.gtkrc-2.0 directory ..."
sudo cp -l -f -T -r $PWD/home/.gtkrc-2.0 /root/.gtkrc-2.0

echo "Copying themes ..."
sudo cp -rfT $PWD/themes /usr/share/themes

echo "Copying backgrounds ..."
sudo cp -rfT $PWD/backgrounds /usr/share/backgrounds

wal --theme base16-onedark
