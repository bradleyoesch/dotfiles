# Setup Automation Plan

Goal: bring the repo closer to baweaver/dotfiles-style automation. One command
on a brand-new Mac gets a fully configured machine. No README full of manual
steps. Everything idempotent, so re-running is safe.

Reference: https://github.com/baweaver/dotfiles/tree/main

## Guiding principles

* Zero manual steps. A fresh Mac runs one command and ends configured.
* The only allowed interactive prompts are OS password entries (sudo, chsh) and
  the Xcode Command Line Tools GUI dialog, which macOS can't fully suppress.
* Idempotent everywhere. Re-running any script is safe and skips finished work.
* Config as data, not code. Lists (brew, npm, gh extensions) live in files we
  loop over, not hand-written install lines.
* The README stops being an instruction manual. It becomes a one-liner plus a
  short description of what the scripts do.

## Current state (already good, don't rebuild)

* Idempotency. `init.sh` already checks-before-acting everywhere.
* Declarative symlinks. dotbot `install.conf.yaml` handles all linking.
* Declarative package lists. `Brewfile` and `system/npm/global-packages` are
  data we loop over.

## Gaps to close

* No health check. Nothing verifies a machine is correctly set up.
* No single entrypoint. Setup is a README checklist, not a script.
* Prerequisites are manual. Xcode CLT, brew, nvm, zsh, oh-my-zsh, and the repo
  clone are all hand-run from the README.
* Verbs are mixed. `init.sh` does setup and update work in one file.

## Manual steps to eliminate

Each README step, with how to automate it and the gotcha.

* Xcode Command Line Tools
  * Approach: headless install via the `softwareupdate` trick (touch the
    in-progress flag file, find the CLT label, `softwareupdate -i`).
  * Gotcha: on some macOS versions this still needs one GUI click. Accept this
    as the single unavoidable dialog. Fall back to `xcode-select --install`.
* Homebrew
  * Approach: run the official installer non-interactively, then
    `eval "$(/opt/homebrew/bin/brew shellenv)"`.
  * Gotcha: needs sudo password once.
* git
  * Approach: comes with Xcode CLT, then pinned in `Brewfile`. No separate step.
* nvm + node
  * Approach: keep nvm, install it via `Brewfile` (`brew "nvm"`) instead of the
    manual curl, then the existing `init.sh` node block runs.
  * Alternative: migrate to `mise` (see "Open questions"). Out of scope for v1.
* zsh + oh-my-zsh
  * Approach: `zsh` is in `Brewfile`. Install oh-my-zsh unattended with
    `RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl ...)"` so it never overwrites
    `.zshrc` or drops us into a subshell.
  * Gotcha: `chsh` to set the default shell needs a password. The
    `.zshrc.bak` dance in the README goes away once oh-my-zsh runs with
    `KEEP_ZSHRC=yes`.
  * Open question: do we still need oh-my-zsh? baweaver dropped it. See below.
* Clone the repo
  * Approach: the bootstrap one-liner clones into `~/bradleyoesch/dotfiles`
    before handing off to the in-repo scripts.

## Target structure

A `bin/` directory of single-purpose verbs, plus a curl-able bootstrap.

* `bin/bootstrap` — the fresh-machine entrypoint. Installs Xcode CLT, brew, and
  git, clones the repo, then calls `bin/setup`. This is what the README
  one-liner runs.
* `bin/setup` — full machine configuration. Roughly today's `init.sh`: brew
  bundle, node, npm globals, symlinks (dotbot), app config (iTerm2, VLC, subl),
  tmux/vim plugins. Idempotent.
* `bin/install` — symlinks only. Thin wrapper around dotbot for when you just
  changed a dotfile and want to relink.
* `bin/update` — upgrade everything: `brew upgrade`, `brew bundle`, node LTS,
  npm globals, gh extensions, tmux/vim plugins.
* `bin/doctor` — read-only health check. Verifies brew tools present, symlinks
  in place, CLIs on PATH, plugins installed. Changes nothing. Exit non-zero on
  failure so it's CI/re-run friendly.

The existing `init.sh` becomes `bin/setup` (or stays and `bin/setup` calls it).
dotbot and `install.conf.yaml` stay as-is.

## bin/doctor spec (build first)

Read-only. For each check, print pass/fail and tally. Model on baweaver's.

* Homebrew installed, `brew bundle check` passes against `Brewfile`.
* Each key CLI on PATH: git, gh, glab, acli, delta, bat, fd, glow, kcat, tmux.
* nvm present, node LTS active.
* Symlinks resolve: `~/.zshrc`, `~/.gitconfig` include, dotbot targets.
* Plugins present: tmux tpm, vim-sensible.
* App config wired: iTerm2 custom prefs folder set, `subl` symlink exists.
* Print "N passed, M failed"; exit 1 if any failed.

## Ordered task list

1. `bin/doctor` — cheapest, highest value, changes nothing. Start here.
2. `bin/update` — extract the brew/node/npm upgrade logic out of `init.sh`.
3. Split `init.sh` into `bin/setup` + `bin/install`, keep behavior identical.
4. `bin/bootstrap` — Xcode CLT + brew + git + clone + call `bin/setup`.
5. Move nvm and zsh install into `Brewfile` / unattended installers so they
   stop being manual.
6. Rewrite `README.md` down to the one-liner plus a script table.
7. Delete the manual-steps section of the README once bootstrap covers it.

All steps done. Steps 1-7, plus the app-section trimming (iTerm2, VLC, Sublime
reduced to what still needs a human, standalone "Installation" section folded
away), plus node automation (`bin/setup` installs nvm if missing). `bin/bootstrap`
now takes a fresh machine to fully configured, including node, in one command.

### nvm vs mise (decided: nvm)

Stay on nvm. Indeed's paved-path tooling calls the `nvm` command directly
(`.indeed/setup.sh`, `run.sh`, `build.sh` across flex, identity, and other
repos), so nvm must stay installed. That also removes mise's main draw: those
scripts need nvm loaded anyway, so switching wouldn't cut shell-startup cost,
it would just add a second version manager and PATH conflicts.

`bin/setup` installs nvm via the official installer (pinned tag) at `~/.nvm`,
not brew, because the Indeed scripts and our `.zshrc` both expect that path.
`PROFILE=/dev/null` keeps the installer from editing `~/.zshrc`.

## Dropping oh-my-zsh (decided)

Decision: drop oh-my-zsh. Went through it feature by feature. The big three
(`zsh-autosuggestions`, `zsh-syntax-highlighting`, `zsh-history-substring-search`)
are already sourced straight from brew, so they survive the drop untouched.

Key realization: we can drop oh-my-zsh NOW and only lose the prompt formatting
until Starship is set up. Everything else ports cleanly. A bare zsh prompt (or a
tiny placeholder) covers the gap.

| Feature | Decision |
|---------|----------|
| Prompt (robbyrussell) | Replace with Starship later. Bare/minimal prompt in the meantime. |
| Completion (`compinit`) | Port: `autoload -Uz compinit && compinit` with a cache guard. |
| zsh options | Port a curated set of the defaults oh-my-zsh set silently. |
| autojump | Keep. Source brew's `autojump.sh` directly (one line). |
| per-directory-history | Keep. Vendor the standalone `.zsh` and source it. History must stay per-dir (matters for the tmux multi-pane workflow), so do NOT set `SHARE_HISTORY`. |
| jump | Drop. autojump's `j partial-name` covers the need; `mark` never used. |
| safe-paste | Drop. Modern zsh bracketed paste covers it. |
| urltools | Drop. Unused. |

Starship is queued separately: placeholder at `cli/starship/starship.toml`, not
wired up. Activation steps live in that file's header.

## Known issues / cleanup

Pre-existing, noticed while building the `bin/` verbs. Not fixed yet to keep
those changes surgical.

* `bin/setup` appends `export PATH` and `export HOMEBREW_CASK_OPTS` directly to
  `~/.zshrc`. This is now redundant, the dotfiles `cli/zsh/.zshrc` already sets
  both, and dotbot adds a `source` line for it. The direct appends could be
  dropped, leaving `~/.zshrc` to just source the managed config.
* `cli/zsh/.zshrc` line 3 has `export HOMEBREW_CASK_OPTS=\"--appdir=~/Applications\"`
  with literal escaped quotes, so the value includes stray `"` characters. Should
  be `export HOMEBREW_CASK_OPTS="--appdir=~/Applications"`.

## Resolved questions

* nvm vs mise, decided nvm (see the section above).
* Where `bin/bootstrap` is curl'd from, resolved. The README uses the raw
  GitHub URL (`raw.githubusercontent.com/.../bin/bootstrap`) as the true
  one-command install, with clone-then-`bin/setup` as the alternative.
