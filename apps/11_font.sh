#!/bin/bash

FONT_NAME="HackNerdFont"
if [[ "$UNAME" == "Linux" ]]; then
  if ! fc-list | grep -i $FONT_NAME >/dev/null; then
    mkdir -p ~/.local/share/fonts/
    cd /tmp/ || return
    curl -sL "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip" -o hack_nerd_font.zip
    unzip hack_nerd_font.zip -d hack
    cp hack/*.ttf ~/.local/share/fonts/
    rm -rf hack_nerd_font.zip hack
    fc-cache
    cd ~- || return
  fi
elif [[ "$UNAME" == "Darwin" ]]; then
  brew install font-hack-nerd-font font-caskaydia-mono-nerd-font
fi
