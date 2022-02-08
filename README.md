# dotfiles

These them there them dotfiles.

## New Computer Setup

Install Xcode:

```bash
xcode-select --install
```

Install brew:

```bash
open https://brew.sh/
brew -v
brew doctor
brew update
```

Install git:

```bash
brew install git
```

Install nvm:

```bash
mkdir -p ~/.nvm
open https://github.com/nvm-sh/nvm#installing-and-updating
nvm -v
```

Install oh-my-zsh:

```bash
open https://github.com/ohmyzsh/ohmyzsh#basic-installation
rm ~/.zshrc
```

Clone this project:

```bash
mkdir -p ~/code/bradleyoesch
cd ~/code/bradleyoesch
git clone git@github.com:bradleyoesch/dotfiles.git
cd dotfiles
```

Run setup script:

```bash
./setup
```

## Applications

```bash
open ~/Applications
```

### Dropbox

Setup

### Folx

Setup

### Flux

- Daytime - 4800K
- Sunset - 3400K
- Bedtime - 2000K

### Google Chrome

Setup google account

#### Extensions

- Hover Zoom+ - go through settings
- LastPass - log in
- OneTab - import tabs
- RedditEnhancementSuite - import settings from Google Drive
- SetupVPN - log in
- Slapdash - log in
- Stylebot - import settings from [`applications/chrome/stylebot.json`](applications/chrome/stylebot.json)
- uBlock - import settings from [`applications/chrome/ublock.txt`](applications/chrome/ublock.txt)

#### Apps

- Postman - log in

### iTerm2

Load iTerm2 settings:

- [`applications/iterm2/keybindings.itermkeymap`](applications/iterm2/keybindings.itermkeymap)
- [`applications/iterm2/monokai-bradley.itermcolors`](applications/iterm2/monokai-bradley.itermcolors)
- [`applications/iterm2/profile.json`](applications/iterm2/profile.json)

Preferences > Keys > Hotkey > cmd + \`

### QuickLook

Open the Quicklook directory and Right click > Show Package Contents > ... > MacOS > Right click > Open > Allow

```bash
open /Users/bradley/Library/QuickLook
open ~/Applications # QLMarkdown
```

### Rectangle

Import settings from [`applications/rectangle/rectangle.json`](applications/rectangle/rectangle.json)

### Slapdash

Log in

### Spotify

Log in, double check settings

### Sublime Text

Settings should be copied for you already after installing.

You can open from the terminal with `subl`:

```bash
subl ~/.zshrc
```

### VLC

Settings should be copied for you already after installing.

## Installation

This project uses [dotbot](https://github.com/anishathalye/dotbot) to manage the installation.

```bash
./install
```

## Contents

To view all relevant files and directories in this repo, run `tree`:

```bash
tree -aI 'dotbot|.git|.gitmodules'
```

## Credits

Many thanks to the [dotfiles community](https://dotfiles.github.io).
