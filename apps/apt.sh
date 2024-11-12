#!/bin/bash

if [[ "$UNAME" == "Linux" ]]; then
  sudo apt-get install -y fzf ripgrep bat tmux zoxide eza tmux fd-find zsh-autosuggestions zsh-syntax-highlighting
fi
