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

Install zsh, oh-my-zsh:

```bash
brew install zsh
echo '/opt/homebrew/bin/zsh' | sudo tee -a /etc/shells > /dev/null
chsh -s /opt/homebrew/bin/zsh
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
./setup && source ~/.zshrc
```

## Applications

```bash
open ~/Applications
```

### Dropbox

Setup

### FileZilla

Download and setup: https://filezilla-project.org/download.php?platform=osx

Import bradleyoesch.com site settings from [`applications/filezilla/site-config-bradleyoesch.com.xml`](applications/filezilla/site-config-bradleyoesch.com.xml)
- `File > Import > applications/filezilla/`

### Folx

Setup

### Flux

Update hues with `Top bar icon > Preferences`:
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

Set global hotkey
- `Preferences > Keys > Hotkey > cmd + opt + \``

### QuickLook

Open the Quicklook directory and `Right click > Show Package Contents > ... > MacOS > Right click > Open > Allow`

```bash
open /Users/bradley/Library/QuickLook
open ~/Applications # QLMarkdown
```

### Rectangle

Import settings from [`applications/rectangle/rectangle.json`](applications/rectangle/rectangle.json)
- `cmd + space > Rectangle > Gear icon > Import (at bottom)`

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

To import settings into VLC:

```bash
./applications/vlc/sync import
```

To import settings from VLC:

```bash
./applications/vlc/sync export
```

## Installation

This project uses [dotbot](https://github.com/anishathalye/dotbot) to manage the installation.

```bash
./install && source ~/.zshrc
```

## Contents

To view all relevant files and directories in this repo, run `tree`:

```bash
tree -aI 'dotbot|.git|.gitmodules'
```

## Credits

Many thanks to the [dotfiles community](https://dotfiles.github.io).
