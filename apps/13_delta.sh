#!/bin/bash

if [[ "$UNAME" == "Linux" ]]; then
  if ! [ -x "$(command -v delta)" ]; then
    case "$ARCH" in
      x86_64) DELTA_TARGET="x86_64-unknown-linux-gnu" ;;
      aarch64|arm64) DELTA_TARGET="aarch64-unknown-linux-gnu" ;;
      armv6l|armv7l) DELTA_TARGET="arm-unknown-linux-gnueabihf" ;;
      *) DELTA_TARGET="x86_64-unknown-linux-gnu" ;;
    esac
    mkdir -p ~/.local/bin/
    cd /tmp/ || return
    DELTA_VERSION=$(curl -s "https://api.github.com/repos/dandavison/delta/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
    DELTA_DIR="delta-${DELTA_VERSION}-${DELTA_TARGET}"
    curl -sLo delta.tar.gz "https://github.com/dandavison/delta/releases/latest/download/${DELTA_DIR}.tar.gz"
    tar -xzf delta.tar.gz
    install "$DELTA_DIR/delta" ~/.local/bin/
    rm -rf delta.tar.gz "$DELTA_DIR"
    cd ~- || return
  fi
elif [[ "$UNAME" == "Darwin" ]]; then
  brew install git-delta
fi
