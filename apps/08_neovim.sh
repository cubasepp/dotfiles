#!/bin/bash

if [[ "$UNAME" == "Linux" ]]; then
  case "$ARCH" in
    x86_64) NVIM_ARCH="x86_64" ;;
    aarch64|arm64) NVIM_ARCH="arm64" ;;
    *) NVIM_ARCH="" ;;
  esac
  if [ -n "$NVIM_ARCH" ]; then
    mkdir -p "$HOME/.local/bin"
    cd /tmp || return
    # -f so a renamed/missing asset fails loudly instead of saving the 404 body
    if curl -fsSLo nvim.tar.gz "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${NVIM_ARCH}.tar.gz"; then
      tar -C "$HOME/.local/bin/" -xzf nvim.tar.gz
    else
      echo "neovim: download failed for nvim-linux-${NVIM_ARCH}" >&2
    fi
    rm -f nvim.tar.gz
    cd ~- || return
  else
    echo "neovim: no prebuilt binary for $ARCH, falling back to apt"
    sudo apt-get install -y neovim
  fi
elif [[ "$UNAME" == "Darwin" ]]; then
  brew install neovim
fi

if [ ! -d "$HOME/.config/nvim" ]; then
  git clone https://github.com/LazyVim/starter "$HOME/.config/nvim" &&
    rm -rf "$HOME/.config/nvim/.git"
fi
