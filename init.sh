#!/opt/homebrew/bin/zsh

# Color codes for terminal output
export LGRN='\033[1;32m'
export CYAN='\033[0;36m'
export NC='\033[0m' # No Color

clog() {
  echo "${CYAN}>>>>> $1 <<<<<${NC}"
}
plog() {
  echo "${LGRN}>>>>> $1 <<<<<${NC}"
}

if grep -q "export PATH" ~/.zshrc
then
    clog "Found \"export PATH\" in ~/.zshrc, skipping update"
    clog "Existing PATH:"
    echo $PATH
else
    clog "Updating PATH..."
    echo "export PATH=\"/usr/local/bin:/usr/local/sbin:~/bin:/opt/homesystem/brew/bin:\$PATH\"" >> ~/.zshrc
    exec zsh
    clog "Updated PATH:"
    echo $PATH
fi

echo ""

clog "Creating ~/Applications for personal applications..."
mkdir -p ~/Applications

if grep -q "HOMEBREW_CASK_OPTS" ~/.zshrc
then
    clog "Found HOMEBREW_CASK_OPTS in ~/.zshrc, skipping update"
else
    plog "Updating homebrew cask install directory to ~/Applications, run this script again!"
    echo "\nexport HOMEBREW_CASK_OPTS=\"--appdir=~/Applications\"" >> ~/.zshrc
    exec zsh
fi

echo ""

source ~/.nvm/nvm.sh
current_node=$(nvm current)
lts_version=$(nvm version-remote --lts)
if [ "$current_node" = "$lts_version" ]; then
    clog "Node LTS ($lts_version) already installed and active, skipping"
else
    clog "Installing latest node LTS..."
    nvm install --lts
    plog "Done!"
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
    clog "All npm packages already installed, skipping"
else
    clog "Installing missing global npm packages..."
    for package in "${missing_packages[@]}"; do
      npm install -g "$package"
    done
    plog "Done!"
fi

brew_repo="/opt/homebrew/.git"
if [ -d "$brew_repo" ]; then
    last_update=$(stat -f %m "$brew_repo/FETCH_HEAD" 2>/dev/null || echo 0)
    current_time=$(date +%s)
    time_diff=$((current_time - last_update))

    if [ $time_diff -lt 86400 ]; then
        clog "Brew updated within the last 24 hours, skipping update"
    else
        clog "Updating brew..."
        brew doctor
        brew update
    fi
else
    clog "Updating brew..."
    brew doctor
    brew update
fi

clog "Installing brew packages and casks..."
brew bundle --file system/brew/Brewfile

if [ ! -L /usr/local/bin/subl ]; then
    clog "Symlinking Sublime to subl..."
    sudo ln -sf ~/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl
    plog "Done!"
else
    clog "subl symlink already exists, skipping"
fi

clog "Updating VLC settings..."
./gui/vlc/sync.sh import
plog Done!

echo ""

if [ ! -d ~/.tmux/plugins/tpm ]; then
    clog "Installing tmux plugin manager..."
    mkdir -p ~/.tmux/plugins
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    plog "Done!"
else
    clog "tmux plugin manager already installed, skipping"
fi

echo ""

if [ ! -d ~/.vim/pack/tpope/start/sensible ]; then
    clog "Installing vim-sensible..."
    mkdir -p ~/.vim/pack/tpope/start
    git clone https://tpope.io/vim/sensible.git ~/.vim/pack/tpope/start/sensible
    plog "Done!"
else
    clog "vim-sensible already installed, skipping"
fi
