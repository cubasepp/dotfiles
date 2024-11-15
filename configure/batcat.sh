#!/bin/bash

if [[ "$UNAME" == "Linux" ]]; then
  BATCAT_CONIFG_DIR=$(batcat --config-dir)
  mkdir -p "$BATCAT_CONIFG_DIR/themes"
  cp "$HOME/.local/share/cubasepp/themes/batcat/catppuccin_mocha" "$BATCAT_CONIFG_DIR/themes/Catppuccin Mocha.tmTheme"
  batcat cache --build
elif [[ "$UNAME" == "Darwin" ]]; then
  BATCAT_CONIFG_DIR=$(bat --config-dir)
  mkdir -p "$BATCAT_CONIFG_DIR/themes"
  cp "$HOME/.local/share/cubasepp/themes/batcat/catppuccin_mocha" "$BATCAT_CONIFG_DIR/themes/Catppuccin Mocha.tmTheme"
  bat cache --build
fi
