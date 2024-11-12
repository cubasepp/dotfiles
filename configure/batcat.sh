#!/bin/bash

if [[ ! "$UNAME" == "OpenBSD" ]]; then
  BATCAT_CONIFG_DIR=$(batcat --config-dir)
  mkdir -p "$BATCAT_CONIFG_DIR/themes"
  curl $HOME/.local/share/cubasepp/themes/batcat/catppuccin_mocha "$BATCAT_CONIFG_DIR/themes/Catppuccin Mocha.tmTheme"
  batcat cache --build
fi
