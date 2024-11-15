#!/bin/bash

source "$HOME/.local/share/cubasepp/env"

if [ "$USER" == "vscode" ]; then
  APPS="vscode.sh"
else
  APPS="*.sh"
fi

echo "Install apps"
for installer in $CUBASEPP_PATH/apps/$APPS; do
  echo "Run $installer"
  source "$installer"
done
