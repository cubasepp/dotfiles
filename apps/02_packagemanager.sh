#!/bin/bash

if [[ "$UNAME" == "Linux" ]]; then
  sudo apt-get install -y fzf ripgrep bat zoxide eza tmux fd-find zsh-autosuggestions zsh-syntax-highlighting

  # Debian's fd-find package ships the binary as `fdfind` (an unrelated package
  # already owns the `fd` name), unlike Homebrew's `fd` on macOS. fzf's
  # FZF_CTRL_T_COMMAND/FZF_ALT_C_COMMAND run `fd` in a non-interactive subshell,
  # so a zsh alias alone doesn't cover it — symlink onto PATH instead.
  mkdir -p "$HOME/.local/bin"
  ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"
elif [[ "$UNAME" == "Darwin" ]]; then
  brew install fzf ripgrep bat tmux zoxide eza fd zsh-autosuggestions zsh-syntax-highlighting
fi
