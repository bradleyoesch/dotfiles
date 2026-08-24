# AGENTS.md

Guidance for AI coding agents working in this dotfiles repo.

## Project overview

Personal macOS dotfiles. Symlinks are managed by dotbot via
`install.conf.yaml`. Machine setup runs through `bin/setup`. Package sets are
declared as data (`system/brew/Brewfile`, `system/npm/global-packages`) and
looped over, not hand-installed.

## Layout

* `bin/` — verbs: `bootstrap`, `setup`, `install`, `update`, `doctor`, plus shared `lib.sh`
* `cli/` — shell tool configs (zsh, git, tmux, vim, glow)
* `gui/` — app configs (iTerm2, Sublime, Karabiner, VLC)
* `system/` — package manifests (brew, npm)
* `install.conf.yaml` — dotbot symlink + setup declarations
* `docs/` — planning and design notes

zsh config is split into files under `cli/zsh/`, symlinked into
`~/.config/dotfiles/`, and sourced from `~/.zshrc`.

## Setup commands

* Fresh machine (Xcode CLT, brew, git, clone, setup): `bin/bootstrap`
* Full machine setup: `bin/setup`
* Symlinks only: `bin/install`
* Update managed tools: `bin/update`
* Health check: `bin/doctor`

## Conventions

* Everything must be idempotent. Check-before-acting; re-running any script is safe.
* Declare packages as data in `system/` manifests, then loop. Don't hand-write install lines.
* New symlinks go in `install.conf.yaml`, not ad-hoc `ln` calls.
* New tools go in the `Brewfile`, sorted within their section (brews, then casks).
* Match the existing shell style in `bin/setup` (`info`/`success` helpers from `bin/lib.sh`, guard clauses).
* `bin/doctor` derives package and symlink checks from the `Brewfile` and
  `install.conf.yaml`. Adding a bespoke `bin/setup` step means adding a matching
  check to the "bespoke steps" section of `bin/doctor` by hand.

## Commit guidelines

* Scope commits tightly. One concern per commit, don't sweep unrelated changes in.
* Follow the user's global writing rules: `*` bullets, contractions, no em dashes or semicolons.
