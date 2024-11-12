#!/bin/bash

# Do not overwrite custom env's
cp -n $HOME/.local/share/cubasepp/config/shellenv $HOME/.zshenv

# Customized oh-my-zsh
cp $HOME/.local/share/cubasepp/config/zshrc $HOME/.zshrc

# Minimal Bash Setup
cp $HOME/.local/share/cubasepp/config/bashrc $HOME/.bashrc

if [ -f $HOME/.local/bin/mise ]; then
  echo 'eval "$($HOME/.local/bin/mise activate bash)"' >>$HOME/.bashrc
  echo 'eval "$($HOME/.local/bin/mise activate zsh)"' >>$HOME/.zshrc
fi

if [ -x "$(command -v zoxide)" ]; then
  echo 'eval "$(zoxide init bash)"' >>$HOME/.bashrc
  echo 'eval "$(zoxide init zsh)"' >>$HOME/.zshrc
fi
