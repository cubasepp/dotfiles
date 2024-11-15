#!/bin/bash

if [[ "$UNAME" == "OpenBSD" ]]; then
  echo "Skip mise... OpenBSD"
  return
fi

if [[ "$UNAME" == "Darwin" ]]; then
  brew install kitty
fi
