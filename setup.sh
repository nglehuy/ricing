#!/usr/bin/env sh

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
