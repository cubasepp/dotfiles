#!/bin/bash

if ! [ -x "$(command -v zellij)" ]; then
  echo "Skip zellij"
else
  mkdir -p ~/.config/zellij/themes
  cp $HOME/.local/share/cubasepp/config/zellijkdl $HOME/.config/zellij/config.kdl
  cp $HOME/.local/share/cubasepp/themes/zellij/theme.kdl $HOME/.config/zellij/themes/catppuccin.kdl
fi
