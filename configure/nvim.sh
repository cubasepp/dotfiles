#!/bin/bash

if [ ! -d "$HOME/.config/nvim" ]; then
  mkdir -p ~/.config/nvim/plugin/after
  mkdir -p ~/.config/nvim/lua/plugins

  cp ~/.local/share/cubasepp/config/nvim/transparency.lua "$HOME/.config/nvim/plugin/after/"
  cp ~/.local/share/cubasepp/config/nvim/catppuccin.lua "$HOME/.config/nvim/lua/plugins/"
fi
