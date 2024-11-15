#!/bin/bash

if [[ "$UNAME" == "Linux" ]]; then
  mkdir -p ~/.local/bin/
  cd /tmp/ || return
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -sLo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar -C $HOME/.local/bin/ -xzf lazygit.tar.gz
  rm lazygit.tar.gz
  cd ~- || return
elif [[ "$UNAME" == "Darwin" ]]; then
  brew install lazygit
fi
