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

### iTerm2

Load iTerm2 settings:

- [`applications/iterm2/keybindings.itermkeymap`](applications/iterm2/keybindings.itermkeymap)
- [`applications/iterm2/monokai-bradley.itermcolors`](applications/iterm2/monokai-bradley.itermcolors)
- [`applications/iterm2/profile.json`](applications/iterm2/profile.json)

Preferences > Keys > Hotkey > cmd + \`

### Sublime Text

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
