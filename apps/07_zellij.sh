#!/bin/bash

if [[ "$UNAME" == "Linux" ]]; then
  case "$ARCH" in
    x86_64) ZELLIJ_TARGET="x86_64-unknown-linux-musl" ;;
    aarch64|arm64) ZELLIJ_TARGET="aarch64-unknown-linux-musl" ;;
    *) echo "zellij: no prebuilt binary for $ARCH, skipping" ;;
  esac
  if [ -n "$ZELLIJ_TARGET" ]; then
    cd /tmp || return
    curl -sLo zellij.tar.gz "https://github.com/zellij-org/zellij/releases/latest/download/zellij-${ZELLIJ_TARGET}.tar.gz"
    tar -xf zellij.tar.gz zellij
    sudo install zellij /usr/local/bin
    rm zellij.tar.gz zellij
    cd ~- || return
  fi
elif [[ "$UNAME" == "Darwin" ]]; then
  brew install zellij
fi

mkdir -p "$HOME/.config/zellij/themes"
