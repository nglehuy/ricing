#!/usr/bin/env sh
cd $HOME

echo "Installing desktop tools ..."
sudo pacman -Syu --noconfirm --needed  dunst \
  network-manager-applet nm-connection-editor networkmanager \
  light \
  ranger \
  feh \
  zathura \
  xcursor-breeze \
  blueman \
  ibus ibus-hangul \
  ttf-font-awesome noto-fonts noto-fonts-extra noto-fonts-cjk noto-fonts-emoji \
  yad rofi polybar picom bspwm sxhkd python-pywal \
  gnome-disk-utility yay

echo "Installing desktop apps ..."
sudo pacman -Syu --noconfirm --needed discord chromium snapd code docker kitty

yay -Syu --needed slack-desktop shutter perl-goo-canvas ibus-bamboo \
  anydesk-bin oomox otf-code-new-roman ttf-quicksand

echo "Setting up snapd ..."
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap

echo "Add user to docker group ..."
sudo usermod -a -G docker $USER

echo "Add user to video group ..."
sudo usermod -a -G video $USER
