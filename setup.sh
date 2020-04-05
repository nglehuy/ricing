#!/usr/bin/env sh

echo "Linking home directory ..."
cp -l -f -T -r $PWD/home $HOME

echo "Linking .config directory ..."
cp -l -f -T -r $PWD/config $XDG_CONFIG_HOME

echo "Linking /etc directory ..."
sudo cp -l -f -T -r $PWD/etc /etc

echo "Copying themes ..."
sudo cp -rT $PWD/themes /usr/share/themes

echo "Copying backgrounds ..."
sudo cp -rT $PWD/backgrounds /usr/share/backgrounds
