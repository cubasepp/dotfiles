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

# Prompt theme. Tracked here (rather than left as the untracked file `p10k
# configure` generates) so every machine -- including remote hosts reached
# over SSH -- shows the same "remote" styling on the context segment.
cp "$HOME/.local/share/cubasepp/config/p10k.zsh" "$HOME/.p10k.zsh"
