#!/bin/bash

if ! [ -x "$(command -v aerc)" ]; then
  echo "Skip aerc"
else
  # aerc resolves its config dir the same way: $XDG_CONFIG_HOME if set,
  # ~/Library/Preferences on macOS, ~/.config elsewhere.
  if [ -n "$XDG_CONFIG_HOME" ]; then
    AERC_CONFIG_DIR="$XDG_CONFIG_HOME/aerc"
  elif [[ "$UNAME" == "Darwin" ]]; then
    AERC_CONFIG_DIR="$HOME/Library/Preferences/aerc"
  else
    AERC_CONFIG_DIR="$HOME/.config/aerc"
  fi

  mkdir -p "$AERC_CONFIG_DIR"

  # Keep a copy of a pre-existing, non-cubasepp binds.conf the first time we
  # take it over. accounts.conf / aerc.conf are left alone on purpose: they
  # hold credentials and per-machine settings.
  if [ -f "$AERC_CONFIG_DIR/binds.conf" ] && [ ! -f "$AERC_CONFIG_DIR/binds.conf.orig" ]; then
    if ! grep -q "cubasepp:" "$AERC_CONFIG_DIR/binds.conf"; then
      cp "$AERC_CONFIG_DIR/binds.conf" "$AERC_CONFIG_DIR/binds.conf.orig"
    fi
  fi

  cp "$HOME/.local/share/cubasepp/config/aerc/binds.conf" "$AERC_CONFIG_DIR/binds.conf"

  unset AERC_CONFIG_DIR
fi
