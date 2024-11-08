#!/bin/bash

# Do not overwrite custom env's
cp -n $HOME/.local/share/cubasepp/config/shellenv $HOME/.zshenv

# Customized oh-my-zsh
cp $HOME/.local/share/cubasepp/config/zshrc $HOME/.zshrc

# Minimal Bash Setup
cp $HOME/.local/share/cubasepp/config/bashrc $HOME/.bashrc
