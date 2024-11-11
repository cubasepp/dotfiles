#!/bin/bash

if [[ "$UNAME" == "Linux" ]]; then
  cd /tmp
  curl -sLo zellij.tar.gz "https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz"
  tar -xf zellij.tar.gz zellij
  sudo install zellij /usr/local/bin
  rm zellij.tar.gz zellij
  cd ~-
elif [[ "$UNAME" == "Darwin" ]]; then
  brew install zellij
fi

mkdir -p $HOME/.config/zellij/themes
