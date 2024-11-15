#!/bin/bash

if [[ "$UNAME" == "Linux" ]]; then
  mkdir -p ~/.local/bin/
  cd /tmp/ || return
  LAZYDOCKER_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazydocker/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -sLo lazydocker.tar.gz "https://github.com/jesseduffield/lazydocker/releases/latest/download/lazydocker_${LAZYDOCKER_VERSION}_Linux_x86_64.tar.gz"
  tar -C "$HOME/.local/bin/" -xzf lazydocker.tar.gz
  rm lazydocker.tar.gz
  cd ~- || return
elif [[ "$UNAME" == "Darwin" ]]; then
  brew install lazydocker
fi
