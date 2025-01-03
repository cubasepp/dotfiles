#!/bin/bash

if [[ "$UNAME" == "Linux" ]]; then
  mkdir -p "$HOME/.local/bin"
  cd /tmp || return
  curl -sLo nvim.tar.gz "https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz"
  tar -C "$HOME/.local/bin/" -xzf nvim.tar.gz
  rm -rf nvim-linux64 nvim.tar.gz
  cd ~- || return
elif [[ "$UNAME" == "Darwin" ]]; then
  brew install neovim
fi

if [ ! -d "$HOME/.config/nvim" ]; then
  git clone https://github.com/LazyVim/starter "$HOME/.config/nvim" && rm rm -rf ~/.config/nvim/.git
fi
