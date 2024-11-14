#!/bin/bash

FONT_NAME="HackNerdFont"
if ! $(fc-list | grep -i $FONT_NAME >/dev/null); then
  mkdir -p ~/.local/share/fonts/
  cd /tmp/
  curl -sL "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip" -o hack_nerd_font.zip
  unzip hack_nerd_font.zip -d hack
  cp hack/*.ttf ~/.local/share/fonts/
  rm -rf hack_nerd_font.zip hack
  fc-cache
  cd ~-
fi
