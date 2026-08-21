# cubasepp

My personal, cross-platform terminal dev setup. One repo that installs my CLI tools
and lays down my config for **zsh**, **tmux**, **kitty** and **WezTerm** on **Linux**, **macOS** and
**OpenBSD**.

Inspired by [omakub](https://github.com/basecamp/omakub) — but omakub is Linux-only,
and I need the same setup everywhere, on my default shell (zsh) rather than bash.

## What it sets up

**Tools** (installed via `apt`/`brew`, see `apps/`):

- Core CLI: `fzf`, `ripgrep`, `bat`, `fd`, `eza`, `zoxide`, `tmux`
- Shell: zsh + [zinit](https://github.com/zdharma-continuum/zinit), autosuggestions, syntax highlighting, powerlevel10k
- Runtimes: [mise](https://mise.jdx.dev) (node, etc.)
- Git/Docker TUIs: `lazygit`, `lazydocker`, `delta`
- Editors: Neovim, VS Code
- Terminal/multiplexer: kitty, WezTerm, zellij
- Prompts/UI: [gum](https://github.com/charmbracelet/gum)
- Fonts: Hack & CaskaydiaMono Nerd Fonts

Config-only (not installed by this repo, but configured if present):

- **aerc** — key bindings (`config/aerc/binds.conf`). `accounts.conf` and
  `aerc.conf` stay local; they hold credentials and per-machine settings.
  Adds an `M` ("mark") leader on top of the upstream defaults: `Mr` read,
  `Mu` unread, `Mt` toggle, `MA` whole folder read, plus `Mu`/`Mq` in the
  message viewer.

### WezTerm

`config/wezterm/*.lua` -> `~/.config/wezterm/`, split into modules. WezTerm puts the
config file's directory on `package.path`, so each module is require-able by bare name
and returns a table with an `apply(config)`:

```
wezterm.lua     entry point — requires the rest in order
colors.lua      Catppuccin Mocha palette (data only)
appearance.lua  scheme, transparency, blur, initial window size
fonts.lua       Hack Nerd Font Mono, matching config/kittyconf
tabbar.lua      tab bar settings + format-tab-title + update-status
keys.lua        all key bindings
domains.lua     ssh/mux domains
startup.lua     gui-startup window centring
```

A Catppuccin Mocha powerline tab bar (`format-tab-title`: per-process Nerd Font icons,
zoom/unseen-output markers) plus a status line (`update-status`: workspace badge, cwd,
battery, clock). `use_fancy_tab_bar` is off — that is what allows real powerline
separators, at the cost of the native macOS tab strip. The status line renders *inside*
the tab bar, so hiding the bar hides both.

Keys on top of the defaults: workspaces (`CMD+SHIFT+P` switch, `CMD+SHIFT+N` new,
`CMD+SHIFT+E` rename, `CMD+ALT+arrows` cycle), remote domains (`CMD+SHIFT+I` new tab on
the Pi, `CMD+SHIFT+O` domain picker), and QuickSelect "insert path" on `CTRL+SHIFT+Space`.

Two things worth knowing:

- **`configure/wezterm.sh` deletes `~/.wezterm.lua`.** WezTerm resolves that path
  *before* `~/.config/wezterm/wezterm.lua`, so a leftover single-file config would
  silently keep winning over the modules.
- **`configure/wezterm.sh` changes a macOS system setting.** It disables input-source
  hotkeys 60/61, because macOS otherwise swallows `CTRL+SHIFT+Space` before WezTerm sees
  it and QuickSelect appears broken. Undo via System Settings > Keyboard > Keyboard
  Shortcuts > Input Sources.
- **The version in `apps/15_wezterm.sh` is pinned.** WezTerm's mux protocol is
  version-sensitive, so every machine that connects to a `wezterm-mux-server` has to be
  on the same release.

Cheat sheet for all of the above: `docs/wezterm-cheatsheet.html` (open it in a browser).

Everything is themed with [Catppuccin Mocha](https://github.com/catppuccin) (see `themes/`).

## Install

Clone into the expected location (`$CUBASEPP_PATH`):

```sh
git clone <repo-url> ~/.local/share/cubasepp
cd ~/.local/share/cubasepp

./install.sh      # install apps/tools for the current OS
./configure.sh    # write configs into $HOME (zsh, git, tmux, kitty, …)
```

`configure.sh` accepts a single target to (re)run just one piece:

```sh
./configure.sh kitty    # only re-run configure/kitty.sh
./configure.sh wezterm  # only rewrite ~/.wezterm.lua
./configure.sh shell    # only refresh zsh config
```

Configure steps that copy into `$HOME` are idempotent and won't clobber existing
dotfiles (`cp -n` / `--update=none`), so it's safe to re-run.

## Layout

```
apps/          numbered installers, run in order by install.sh
configure/     copies config into $HOME (one script per topic)
config/        the actual dotfiles (zshrc, tmux.conf, kittyconf, gitconfig, …)
config/wezterm/ WezTerm config, split into modules
config/common/ shared shell snippets + per-OS aliases
themes/        Catppuccin themes for delta, bat, kitty, zellij, zsh-highlighting
bin/           helper commands on PATH
docs/          reference sheets (wezterm-cheatsheet.html)
plugins/       local plugin drop-in (git-ignored)
env            shared env vars (CUBASEPP_PATH, UNAME, …)
```

## Helper commands (`bin/`)

- **`cubassh`** — fuzzy-pick a host from `~/.ssh/config` and connect, via `gum`.
  Extra args are forwarded to `ssh`, e.g. `cubassh -L 8080:localhost:80`.
- **`cubasepp`** — entry point / greeting.
- **`wzc`** — attach to a WezTerm mux domain in a detached background window.
  `wezterm connect` is a foreground client that blocks the shell it was started
  from; this backgrounds it. `wzc` for the default domain, `wzc <domain>` for a
  specific one, or set `$WZC_DOMAIN`.

## Notes

- The install target path is fixed at `~/.local/share/cubasepp` (referenced as
  `$CUBASEPP_PATH` throughout). Clone it there.
- Running as the `vscode` user installs only the VS Code piece (devcontainer-friendly).
- OpenBSD skips tools that aren't available there (e.g. mise).
