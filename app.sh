#!/usr/bin/env sh
cd $HOME

echo "Installing desktop tools ..."
sudo pacman -Syu --noconfirm --needed  dunst \ #notification
  network-manager-applet nm-connection-editor network-manager \ # network manager
  light \ # screen light controller
  lightdm lightdm-slick-greeter light-locker \ # login and lock screen
  thunar ranger \ # file manager
  feh \ # background image setter
  zathura \ # pdf viewer
  xcursor-breeze \ # cursor theme
  blueman \ # bluetooth manager
  ibus ibus-hangul \ # input method
  ttf-font-awesome noto-fonts noto-fonts-extra noto-fonts-cjk noto-fonts-emoji \
  yad rofi polybar picom bspwm sxhkd python-pywal \ # WM components
  gnome-disk-utility \

echo "Installing desktop apps ..."
sudo pacman -Syu --noconfirm --needed discord chromium snapd code docker kitty \

eval "$(pyenv init -)"
pyenv shell system

yay -Syu --needed slack-desktop shutter perl-goo-canvas ibus-bamboo \
  anydesk-bin oomox otf-code-new-roman ttf-quicksand evince-no-gnome

echo "Setting up snapd ..."
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap

echo "Add user to docker group ..."
sudo usermod -a -G docker $USER

echo "Add user to video group ..."
sudo usermod -a -G video $USER
