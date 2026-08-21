#!/bin/bash

if [[ "$UNAME" == "Linux" ]]; then
  case "$ARCH" in
    x86_64) LAZYDOCKER_ARCH="x86_64" ;;
    aarch64|arm64) LAZYDOCKER_ARCH="arm64" ;;
    armv7l) LAZYDOCKER_ARCH="armv7" ;;
    armv6l) LAZYDOCKER_ARCH="armv6" ;;
    *) LAZYDOCKER_ARCH="x86_64" ;;
  esac
  mkdir -p ~/.local/bin/
  cd /tmp/ || return
  LAZYDOCKER_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazydocker/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -sLo lazydocker.tar.gz "https://github.com/jesseduffield/lazydocker/releases/latest/download/lazydocker_${LAZYDOCKER_VERSION}_Linux_${LAZYDOCKER_ARCH}.tar.gz"
  tar -C "$HOME/.local/bin/" -xzf lazydocker.tar.gz
  rm lazydocker.tar.gz
  cd ~- || return
elif [[ "$UNAME" == "Darwin" ]]; then
  brew install lazydocker
fi
