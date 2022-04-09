# dotfiles

These them there them dotfiles.

## New Computer Setup

Install Xcode:

```bash
touch ~/.zshrc
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

Open new tab to show nvm has installed:

```bash
nvm -v
```

When we install oh-my-zsh, it'll overwrite our `~/.zshrc`, so let's make a backup to save our nvm stuff:

```bash
mv ~/.zshrc ~/.zshrc.bak
```

Install zsh, oh-my-zsh:

```bash
brew install zsh
echo '/opt/homebrew/bin/zsh' | sudo tee -a /etc/shells > /dev/null
chsh -s /opt/homebrew/bin/zsh
open https://github.com/ohmyzsh/ohmyzsh#basic-installation
omz update
# copy contents of original `~/.zshrc` into one generated by this install
cat ~/.zshrc.bak >> ~/.zshrc
```

Open a new tab and you should see zsh and omz load on startup.

Clone this project:

```bash
mkdir -p ~/code/bradleyoesch
cd ~/code/bradleyoesch
git clone https://github.com/bradleyoesch/dotfiles.git
cd dotfiles
```

Run setup script then restart zsh to pick up the changes:

```bash
./setup
mv ~/.zshrc ~/.zshrc.bak
./install
exec zsh
```

If everything looks good, you can remove your old zshrc at any point:

```bash
rm ~/.zshrc.bak
```

## Applications

```bash
open ~/Applications
```

### Dropbox

Setup

### FileZilla

Download and setup: https://filezilla-project.org/download.php?platform=osx

Add ssh key:
1. `ssh-keygen`
1.  [Copy the key manually](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys-on-ubuntu-20-04#copying-the-public-key-manually) into your droplet
1. Import bradleyoesch.com site settings from [`applications/filezilla/site-config-bradleyoesch.com.xml`](applications/filezilla/site-config-bradleyoesch.com.xml)
   - `File > Import > applications/filezilla/`
   - You will probably have to add the ssh key manually, since filezilla expects it with a certain format

Export settings with `File > Export > Export Site Manager entries`

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
- Stylebot - import settings from [`applications/chrome/stylebot.json`](applications/chrome/stylebot.json)
- uBlock - import settings from [`applications/chrome/ublock.txt`](applications/chrome/ublock.txt)

#### Apps

- Postman - log in with Google

### iTerm2

Load iTerm2 settings:

`General > Preferences > Load preferences from a custom folder or URL`
- [`applications/iterm2/`](applications/iterm2/)


`Profiles > Other Actions... > Import JSON Profiles...`
- [`applications/iterm2/profile.json`](applications/iterm2/profile.json)

`Profiles > Colors > Color Presets... > Import...`
- [`applications/iterm2/monokai-bradley.itermcolors`](applications/iterm2/monokai-bradley.itermcolors)

`Keys > Key Bindings > Presets... > Import`
- [`applications/iterm2/keybindings.itermkeymap`](applications/iterm2/keybindings.itermkeymap)

Set global hotkey:
`Preferences > Keys > Hotkey > cmd + opt + `

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
./install && exec zsh
```

## Contents

To view all relevant files and directories in this repo, run `tree`:

```bash
tree -aI 'dotbot|.git|.gitmodules'
```

## Credits

Many thanks to the [dotfiles community](https://dotfiles.github.io).
