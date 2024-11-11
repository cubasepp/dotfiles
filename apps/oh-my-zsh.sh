#!/bin/bash

if [ ! -d $CUBASEPP_PLUGIN_PATH/oh-my-zsh/ ]; then
  sh -c "ZSH=$CUBASEPP_PLUGIN_PATH/oh-my-zsh $(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"
fi
