#!/bin/bash

if [[ "$UNAME" == "Linux" ]]; then
  if ! [ -x "$(command -v gum)" ]; then
    mkdir -p ~/.local/bin/
    cd /tmp/ || return
    GUM_VERSION=$(curl -s "https://api.github.com/repos/charmbracelet/gum/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    GUM_DIR="gum_${GUM_VERSION}_Linux_x86_64"
    curl -sLo gum.tar.gz "https://github.com/charmbracelet/gum/releases/latest/download/${GUM_DIR}.tar.gz"
    tar -xzf gum.tar.gz
    install "$GUM_DIR/gum" ~/.local/bin/
    rm -rf gum.tar.gz "$GUM_DIR"
    cd ~- || return
  fi
elif [[ "$UNAME" == "Darwin" ]]; then
  brew install gum
fi
