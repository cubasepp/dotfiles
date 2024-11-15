#!/bin/bash

if [[ "$UNAME" == "Linux" ]]; then
  sudo apt-get install -y fzf ripgrep bat zoxide eza tmux fd-find zsh-autosuggestions zsh-syntax-highlighting
elif [[ "$UNAME" == "Darwin" ]]; then
  brew install fzf ripgrep bat tmux zoxide eza fd zsh-autosuggestions zsh-syntax-highlighting zellij
fi
