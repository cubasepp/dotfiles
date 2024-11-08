#!/bin/bash

if ! [ -x "$(command -v tmux)" ]; then
  echo "Skip tmux"
else
  mkdir -p $HOME/.tmux/plugins
  mkdir -p $HOME/.tmux/config

  if [ ! -d $HOME/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
  fi

  cp $HOME/.local/share/cubasepp/config/tmux/ssh.common $HOME/.tmux/config
  cp $HOME/.local/share/cubasepp/config/tmux/catppuccin.common $HOME/.tmux/config
  cp $HOME/.local/share/cubasepp/config/tmux/tmux.conf $HOME/.tmux.conf
fi
