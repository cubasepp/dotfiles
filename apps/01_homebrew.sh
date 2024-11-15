#!/bin/bash

if ! [ -x "$(command -v tmux)" ]; then
  echo "Hombrew already installed"
elif [[ "$UNAME" == "Darwin" ]]; then
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | sh
fi
