#!/usr/bin/env sh

echo "Linking home directory ..."
cp -l -f -T -r $PWD/home $HOME

echo "Linking .config directory ..."
cp -l -f -T -r $PWD/config $XDG_CONFIG_HOME

echo "Linking /root directory ..."
sudo cp -l -f -T -r $PWD/home /root

echo "Linking /root/.config directory ..."
sudo cp -l -f -T -r $PWD/config /root/.config

echo "Linking /etc directory ..."
sudo cp -l -f -T -r $PWD/etc /etc

echo "Copying themes ..."
sudo cp -rfT $PWD/themes /usr/share/themes

echo "Copying backgrounds ..."
sudo cp -rfT $PWD/backgrounds /usr/share/backgrounds
