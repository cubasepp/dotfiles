#!/bin/bash

# Plugin manager for zsh. The zshrc also self-bootstraps this as a fallback,
# but installing it here keeps the first shell launch clean.
ZINIT_HOME="$HOME/.local/share/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME"
fi
