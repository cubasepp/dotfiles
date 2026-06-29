#!/bin/bash

if [[ "$UNAME" == "Darwin" ]]; then
  if [ -x "$(command -v brew)" ]; then
    echo "Homebrew already installed"
  else
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | sh
  fi
fi
