#!/usr/bin/env sh

echo "Linking home directory ..."
cp -l -f -T -r $PWD/home $HOME

echo "Linking .config directory ..."
cp -l -f -T -r $PWD/config $XDG_CONFIG_HOME

echo "Copying themes ..."
cp -rT $PWD/themes $HOME/.themes
