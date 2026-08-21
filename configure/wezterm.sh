#!/bin/bash

if [ -x "$(command -v wezterm)" ]; then
  mkdir -p "$HOME/.config/wezterm"
  cp "$HOME/.local/share/cubasepp/config/wezterm/"*.lua "$HOME/.config/wezterm/"

  # WezTerm resolves ~/.wezterm.lua BEFORE ~/.config/wezterm/wezterm.lua, so a
  # leftover single-file config would silently keep winning over the modules.
  rm -f "$HOME/.wezterm.lua"

  # macOS never delivers CTRL+SHIFT+Space to WezTerm, so QuickSelect (its stock
  # binding) looks broken. The input-source switcher owns CTRL+Space (hotkey 60)
  # and also grabs CTRL+SHIFT+Space to cycle backwards -- the latter is not listed
  # anywhere in System Settings. Disabling 60/61 frees the key. Idempotent.
  # Undo: System Settings > Keyboard > Keyboard Shortcuts > Input Sources.
  if [[ "$UNAME" == "Darwin" ]]; then
    for hotkey in 60 61; do
      case $hotkey in
      60) mods=262144 ;; # CTRL+Space     -- select previous input source
      61) mods=786432 ;; # CTRL+ALT+Space -- select next input source
      esac
      defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add "$hotkey" \
        "<dict><key>enabled</key><false/><key>value</key><dict><key>type</key><string>standard</string><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>$mods</integer></array></dict></dict>"
    done
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u 2>/dev/null || true
    echo "  wezterm: freed CTRL+SHIFT+Space (disabled macOS input-source hotkeys 60/61)"
  fi
fi
