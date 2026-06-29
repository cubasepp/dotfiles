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

# Customized zsh (zinit + p10k). mise, zoxide and libpq are configured
# inside config/zshrc, so nothing is appended here (keeps this idempotent).
cp "$HOME/.local/share/cubasepp/config/zshrc" "$HOME/.zshrc"
