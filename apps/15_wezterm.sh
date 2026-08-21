#!/bin/bash

if [[ "$UNAME" == "OpenBSD" ]]; then
  echo "Skip wezterm... OpenBSD"
  return
fi

# Pinned on purpose: WezTerm's mux protocol is version-sensitive, so a client and
# a wezterm-mux-server on different releases will not talk to each other. Every
# machine that takes part (this Mac, the pi) has to land on the same version.
WEZTERM_VERSION="20240203-110809-5046fc22"

if [[ "$UNAME" == "Darwin" ]]; then
  brew install --cask wezterm
elif [[ "$UNAME" == "Linux" ]]; then
  if wezterm --version 2>/dev/null | grep -q "$WEZTERM_VERSION"; then
    echo "wezterm $WEZTERM_VERSION already installed"
    return
  fi

  arch=$(dpkg --print-architecture 2>/dev/null)
  distro=$(. /etc/os-release 2>/dev/null && echo "$ID")

  # Upstream ships per-distro debs and they are not interchangeable. Raspberry Pi
  # OS reports ID=debian, so it takes the Debian build (arm64 asset exists).
  case "$distro" in
  debian | raspbian)
    base="wezterm-${WEZTERM_VERSION}.Debian12"
    ;;
  *)
    base="wezterm-${WEZTERM_VERSION}.Ubuntu22.04"
    ;;
  esac

  if [ "$arch" = "arm64" ]; then
    deb="${base}.arm64.deb"
  else
    deb="${base}.deb"
  fi

  cd /tmp || return
  curl -sLo wezterm.deb "https://github.com/wez/wezterm/releases/download/${WEZTERM_VERSION}/${deb}"
  sudo apt install -y ./wezterm.deb
  rm -f wezterm.deb
  cd ~- || return
fi
