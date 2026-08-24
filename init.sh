#!/opt/homebrew/bin/zsh

source "$(cd "$(dirname "$0")" && pwd)/bin/lib.sh"

if grep -q "export PATH" ~/.zshrc
then
    info "Found \"export PATH\" in ~/.zshrc, skipping update"
    info "Existing PATH:"
    echo $PATH
else
    info "Updating PATH..."
    echo "export PATH=\"/usr/local/bin:/usr/local/sbin:~/bin:/opt/homesystem/brew/bin:\$PATH\"" >> ~/.zshrc
    exec zsh
    info "Updated PATH:"
    echo $PATH
fi

echo ""

info "Creating ~/Applications for personal applications..."
mkdir -p ~/Applications

if grep -q "HOMEBREW_CASK_OPTS" ~/.zshrc
then
    info "Found HOMEBREW_CASK_OPTS in ~/.zshrc, skipping update"
else
    success "Updating homebrew cask install directory to ~/Applications, run this script again!"
    echo "\nexport HOMEBREW_CASK_OPTS=\"--appdir=~/Applications\"" >> ~/.zshrc
    exec zsh
fi

echo ""

source ~/.nvm/nvm.sh
current_node=$(nvm current)
lts_version=$(nvm version-remote --lts)
if [ "$current_node" = "$lts_version" ]; then
    info "Node LTS ($lts_version) already installed and active, skipping"
else
    info "Installing latest node LTS..."
    nvm install --lts
    success "Done!"
fi

echo ""

missing_packages=()
while IFS= read -r package; do
  [[ -z "$package" || "$package" =~ ^# ]] && continue
  if ! npm list -g "$package" &>/dev/null; then
    missing_packages+=("$package")
  fi
done < system/npm/global-packages

if [ ${#missing_packages[@]} -eq 0 ]; then
    info "All npm packages already installed, skipping"
else
    info "Installing missing global npm packages..."
    for package in "${missing_packages[@]}"; do
      npm install -g "$package"
    done
    success "Done!"
fi

brew_repo="/opt/homebrew/.git"
if [ -d "$brew_repo" ]; then
    last_update=$(stat -f %m "$brew_repo/FETCH_HEAD" 2>/dev/null || echo 0)
    current_time=$(date +%s)
    time_diff=$((current_time - last_update))

    if [ $time_diff -lt 86400 ]; then
        info "Brew updated within the last 24 hours, skipping update"
    else
        info "Updating brew..."
        brew doctor
        brew update
    fi
else
    info "Updating brew..."
    brew doctor
    brew update
fi

info "Installing brew packages and casks..."
brew trust --formula atlassian/acli/acli
brew bundle --file system/brew/Brewfile

if [ ! -L /usr/local/bin/subl ]; then
    info "Symlinking Sublime to subl..."
    sudo ln -sf ~/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl
    success "Done!"
else
    info "subl symlink already exists, skipping"
fi

info "Updating VLC settings..."
./gui/vlc/sync.sh import
success Done!

echo ""

iterm2_prefs="$(pwd)/gui/iterm2"
if [ "$(defaults read com.googlecode.iterm2 PrefsCustomFolder 2>/dev/null)" = "$iterm2_prefs" ]; then
    info "iTerm2 prefs folder already set, skipping"
else
    info "Pointing iTerm2 at custom prefs folder..."
    defaults write com.googlecode.iterm2 PrefsCustomFolder "$iterm2_prefs"
    defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
    success "Done!"
fi

echo ""

if [ ! -d ~/.tmux/plugins/tpm ]; then
    info "Installing tmux plugin manager..."
    mkdir -p ~/.tmux/plugins
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    success "Done!"
else
    info "tmux plugin manager already installed, skipping"
fi

echo ""

if [ ! -d ~/.vim/pack/tpope/start/sensible ]; then
    info "Installing vim-sensible..."
    mkdir -p ~/.vim/pack/tpope/start
    git clone https://tpope.io/vim/sensible.git ~/.vim/pack/tpope/start/sensible
    success "Done!"
else
    info "vim-sensible already installed, skipping"
fi
