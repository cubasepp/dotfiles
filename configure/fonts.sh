#!/bin/bash

FONT_NAME="HackNerdFont"
if [[ "$UNAME" == "Linux" ]] && ! fc-list | grep -i $FONT_NAME >/dev/null; then
  echo "Skip: font missing, install it first"
fi
