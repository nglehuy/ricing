#!/usr/bin/env sh
cd $HOME

echo "Installing apps ..."
sudo pacman -Syu --noconfirm --needed discord chromium snapd dunst \
  network-manager-applet thunar ranger kitty feh zathura xcursor-breeze \
  blueman ibus ibus-hangul yad yay ttf-font-awesome rofi polybar picom \
  gnome-disk-utility bspwm sxhkd nm-connection-editor python-pywal \
  noto-fonts noto-fonts-extra noto-fonts-cjk noto-fonts-emoji \
  code

yay -Syu --needed slack-desktop shutter perl-goo-canvas ibus-bamboo \
  anydesk-bin themix-full-git otf-code-new-roman ttf-quicksand

echo "Setting up snapd ..."
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap
