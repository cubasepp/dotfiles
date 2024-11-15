#!/bin/bash

if [[ "$UNAME" == "Linux" ]]; then
  cp --update=none "$HOME/.local/share/cubasepp/config/shellenv" "$HOME/.zshenv"
  cat "$HOME/.local/share/cubasepp/config/common/aliases.linux" >"$HOME/.local/share/cubasepp/config/common/aliases"
elif [[ "$UNAME" == "Darwin" ]]; then
  cp -n "$HOME/.local/share/cubasepp/config/shellenv" "$HOME/.zshenv"
  cat "$HOME/.local/share/cubasepp/config/common/aliases.mac" >"$HOME/.local/share/cubasepp/config/common/aliases"
else
  cp "$HOME/.local/share/cubasepp/config/shellenv" "$HOME/.zshenv"
fi

# Customized oh-my-zsh
cp "$HOME/.local/share/cubasepp/config/zshrc" "$HOME/.zshrc"

# Minimal Bash Setup
cp "$HOME/.local/share/cubasepp/config/bashrc" "$HOME/.bashrc"

if [ -f "$HOME/.local/bin/mise" ]; then
  echo 'eval "$($HOME/.local/bin/mise activate bash)"' >>"$HOME/.bashrc"
  echo 'eval "$($HOME/.local/bin/mise activate zsh)"' >>"$HOME/.zshrc"
fi

if [ -x "$(command -v zoxide)" ]; then
  echo 'eval "$(zoxide init bash)"' >>"$HOME/.bashrc"
  echo 'eval "$(zoxide init zsh)"' >>"$HOME/.zshrc"
fi
