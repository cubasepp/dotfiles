#!/bin/bash

if [[ "$UNAME" == "Linux" ]]; then
  case "$ARCH" in
    x86_64) LAZYGIT_ARCH="x86_64" ;;
    aarch64|arm64) LAZYGIT_ARCH="arm64" ;;
    armv6l|armv7l) LAZYGIT_ARCH="armv6" ;;
    *) LAZYGIT_ARCH="x86_64" ;;
  esac
  mkdir -p ~/.local/bin/
  cd /tmp/ || return
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -sLo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_linux_${LAZYGIT_ARCH}.tar.gz"
  tar -C $HOME/.local/bin/ -xzf lazygit.tar.gz
  rm lazygit.tar.gz
  cd ~- || return
elif [[ "$UNAME" == "Darwin" ]]; then
  brew install lazygit
fi
