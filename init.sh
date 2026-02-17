#!/opt/homesystem/brew/bin/zsh

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

clog "Installing latest node..."
source ~/.nvm/nvm.sh
nvm install --lts
plog Done!

echo ""

clog "Installing global npm packages..."
while IFS= read -r package; do
  [[ -z "$package" || "$package" =~ ^# ]] && continue
  npm install -g "$package"
done < system/npm/global-packages
plog Done!

clog "Updating brew..."
brew doctor
brew update
clog "Installing brew packages and casks..."
brew bundle --file system/brew/Brewfile

clog "Symlinking Sublime to subl..."
sudo ln -sf ~/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl
plog Done!

clog "Updating VLC settings..."
./gui/vlc/sync.sh import
plog Done!
