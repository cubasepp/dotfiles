#!/bin/bash

if [[ "$UNAME" == "OpenBSD" ]]; then
  echo "Skip mise... OpenBSD"
  return
fi
if ! [ -x "$(command -v mise)" ]; then
  curl -s https://mise.run | sh
fi
