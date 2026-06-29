#!/bin/bash

source ~/.local/share/cubasepp/env

echo $1
if [ ! -z $1 ]; then
  echo "Configure: $1.sh"
  source ./configure/$1.sh
else
  for configuration in ./configure/*.sh; do
    echo "Configure: $configuration"
    source $configuration
  done
fi
# chsh -s $(which zsh)
