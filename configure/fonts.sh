#!/bin/bash

FONT_NAME="HackNerdFont"
if ! $(fc-list | grep -i $FONT_NAME >/dev/null); then
  echo "Skip: font missing, install it first"
fi
