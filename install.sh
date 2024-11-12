#!/bin/bash

source ~/.local/share/cubasepp/env

if [ "$USER" == "vscode" ]; then
  echo "Install vscode only"
  source $CUBASEPP_PATH/apps/vscode.sh
else
  echo "Install apps"
  for installer in $CUBASEPP_PATH/apps/*.sh; do
    echo "Run $installer"
    source $installer
  done
fi
