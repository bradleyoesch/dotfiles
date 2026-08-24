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

Node isn't automated yet. Install nvm and it'll be picked up on the next
`./bin/setup`.

### Scripts

* `bin/bootstrap` — fresh-machine entry: Xcode CLT, Homebrew, git, clone, then setup
* `bin/setup` — full machine setup: packages, symlinks, app config. Idempotent
* `bin/install` — symlinks only (dotbot)
* `bin/update` — update brew, node, npm globals, editor plugins
* `bin/doctor` — read-only health check

## Applications

```bash
open ~/Applications
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

- Hover Zoom+ - import settings from [`gui/chrome/hoverzoon.json`](gui/chrome/hoverzoon.json)
  - To export: Extension Icon > Options > Advanced > Export
  - `echo '<JSON>' | jq -S '.' > gui/chrome/hoverzoom.json`
- LastPass - log in
- RedditEnhancementSuite - import settings from Google Drive
- SetupVPN - log in
- Stylebot - import settings from [`gui/chrome/stylebot.json`](gui/chrome/stylebot.json)
  - To export: Extension Icon > Sync > Export
  - `jq -S '.' ~/Downloads/stylebot_backup.json > gui/chrome/stylebot.json`
- uBlock Origin Lite - import settings from [`gui/chrome/ublock.json`](gui/chrome/ublock.json)

#### Apps

- Postman - log in with Google

### iTerm2

Load iTerm2 settings:

`General > Preferences > Load preferences from a custom folder or URL`
- [`gui/iterm2/`](gui/iterm2/)


`Profiles > Other Actions... > Import JSON Profiles...`
- [`gui/iterm2/profile.json`](gui/iterm2/profile.json)

`Profiles > Colors > Color Presets... > Import...`
- [`gui/iterm2/monokai-bradley.itermcolors`](gui/iterm2/monokai-bradley.itermcolors)

`Keys > Key Bindings > Presets... > Import`
- [`gui/iterm2/keybindings.itermkeymap`](gui/iterm2/keybindings.itermkeymap)

Set global hotkey:
`Preferences > Keys > Hotkey > cmd + opt + `

### Rectangle

Import settings from [`gui/rectangle/config.json`](gui/rectangle/config.json)
- `cmd + space > Rectangle > Gear icon > Import (at bottom)`

### Spotify

Log in with Facebook, double check settings

### Sublime Text

Settings should be copied for you already after installing.

You can open from the terminal with `subl`:

```bash
subl ~/.zshrc
```

The theme may be broken, so comment it out and reinstall:

- `cmd + ,` for preferences
- visit https://monokai.pro/sublime-text to install (may be under `Monokai+`)
- `cmd + shift + P > Monokai Pro: select theme` to apply

### Transmission

Download and set up: https://transmissionbt.com/download.html

### VLC

Settings should be copied for you already after installing.

To import settings into VLC:

```bash
./gui/vlc/sync.sh import
```

To import settings from VLC:

```bash
./gui/vlc/sync.sh export
```

## Installation

This project uses [dotbot](https://github.com/anishathalye/dotbot) to manage the installation.

```bash
./bin/install && exec zsh
```

## Contents

To view all relevant files and directories in this repo, run `tree`:

```bash
tree -aI 'dotbot*|.git|.gitmodules'
```

## Credits

Many thanks to the [dotfiles community](https://dotfiles.github.io).
