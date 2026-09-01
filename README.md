# dotfiles

These them there them dotfiles.

## Setup

Fresh machine, one command. Installs Xcode Command Line Tools, Homebrew, and
git, clones this repo, then runs setup:

```bash
curl -fsSL https://raw.githubusercontent.com/bradleyoesch/dotfiles/main/bin/bootstrap | bash
```

Or clone it yourself and run setup:

```bash
git clone https://github.com/bradleyoesch/dotfiles.git ~/bradleyoesch/dotfiles
cd ~/bradleyoesch/dotfiles
./bin/setup
```

Then reload the shell:

```bash
exec zsh
```

### Scripts

* `bin/bootstrap` — fresh-machine entry: Xcode CLT, Homebrew, git, clone, then setup
* `bin/setup` — full machine setup: packages, symlinks, app config. Idempotent
* `bin/install` — symlinks only (dotbot)
* `bin/update` — update brew, node, npm globals, editor plugins
* `bin/doctor` — read-only health check

## Applications

```bash
open /Applications
```

### FileZilla

Download and set up: https://filezilla-project.org/download.php?platform=osx

Add ssh key:
1. `ssh-keygen`
1. [Copy the key manually](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys-on-ubuntu-20-04#copying-the-public-key-manually) into your droplet
1. Add ssh key manually, since filezilla expects a specific format

### Google Chrome

Set up google account

#### Extensions

- Hover Zoom+ - import settings from [`config/chrome/hoverzoom.json`](config/chrome/hoverzoom.json)
  - To export: Extension Icon > Options > Advanced > Export
  - `pbpaste | jq -S '.' > config/chrome/hoverzoom.json`
- LastPass - log in
- RedditEnhancementSuite - import settings from Google Drive
- Stylebot - import settings from [`config/chrome/stylebot.json`](config/chrome/stylebot.json)
  - To export: Extension Icon > Sync > Export
  - `jq -S '.' ~/Downloads/stylebot_backup.json > config/chrome/stylebot.json`
- uBlock Origin Lite - import settings from [`config/chrome/ublock.json`](config/chrome/ublock.json)
  - `jq -S '.' ~/Downloads/my-ubol-settings.json > config/chrome/ublock.json`

#### Apps

- Postman - log in with Google

### iTerm2

Settings load automatically, `bin/setup` points iTerm2 at the custom prefs
folder ([`config/iterm2/`](config/iterm2/)).

Set global hotkey:
``Preferences > Keys > Hotkey > cmd + opt + ` ``

### Rectangle

Import settings from [`config/rectangle/config.json`](config/rectangle/config.json)
- `cmd + space > Rectangle > Gear icon > Import (at bottom)`

### Spotify

Log in with Facebook, double check settings

### Sublime Text

Settings and the `subl` command are set up automatically. If the theme looks
broken, reinstall it:

- `cmd + ,` for preferences
- visit https://monokai.pro/sublime-text to install (may be under `Monokai+`)
- `cmd + shift + P > Monokai Pro: select theme` to apply

### Transmission

Download and set up: https://transmissionbt.com/download.html

### VLC

Settings load automatically, `bin/setup` runs the import. To capture changes you make in VLC back into the repo:

* `./config/vlc/sync.sh export`

## TODO

* `.claude` — set up and track Claude Code config
* `.agents` — set up and track agents config
* agent-zero — set up agent-zero

## Contents

To view all relevant files and directories in this repo, run `tree`:

```bash
tree -aI 'dotbot*|.git|.gitmodules'
```

## Credits

Many thanks to the [dotfiles community](https://dotfiles.github.io).
