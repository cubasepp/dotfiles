#!/bin/bash

if [ -x "$(command -v kitty)" ]; then
  touch "$HOME/.kitty.custom"
  mkdir -p "$HOME/.config/kitty/"
  cp "$HOME/.local/share/cubasepp/config/kittyconf" "$HOME/.config/kitty/kitty.conf"
fi
