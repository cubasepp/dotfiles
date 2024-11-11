#!/bin/bash

if [[ "$UNAME" == "Linux" ]]; then
  sudo apt-get install -y fzf ripgrep bat tmux zoxide fd-find
fi
