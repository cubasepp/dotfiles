# cubasepp

My personal, cross-platform terminal dev setup. One repo that installs my CLI tools
and lays down my config for **zsh**, **tmux** and **kitty** on **Linux**, **macOS** and
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
- Terminal/multiplexer: kitty, zellij
- Prompts/UI: [gum](https://github.com/charmbracelet/gum)
- Fonts: Hack & CaskaydiaMono Nerd Fonts

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
./configure.sh shell    # only refresh zsh config
```

Configure steps that copy into `$HOME` are idempotent and won't clobber existing
dotfiles (`cp -n` / `--update=none`), so it's safe to re-run.

## Layout

```
apps/          numbered installers, run in order by install.sh
configure/     copies config into $HOME (one script per topic)
config/        the actual dotfiles (zshrc, tmux.conf, kittyconf, gitconfig, …)
config/common/ shared shell snippets + per-OS aliases
themes/        Catppuccin themes for delta, bat, kitty, zellij, zsh-highlighting
bin/           helper commands on PATH
plugins/       local plugin drop-in (git-ignored)
env            shared env vars (CUBASEPP_PATH, UNAME, …)
```

## Helper commands (`bin/`)

- **`cubassh`** — fuzzy-pick a host from `~/.ssh/config` and connect, via `gum`.
  Extra args are forwarded to `ssh`, e.g. `cubassh -L 8080:localhost:80`.
- **`cubasepp`** — entry point / greeting.

## Notes

- The install target path is fixed at `~/.local/share/cubasepp` (referenced as
  `$CUBASEPP_PATH` throughout). Clone it there.
- Running as the `vscode` user installs only the VS Code piece (devcontainer-friendly).
- OpenBSD skips tools that aren't available there (e.g. mise).
