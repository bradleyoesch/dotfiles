export PATH="/usr/local/bin:/usr/local/sbin:~/bin:/opt/homebrew/bin:$PATH"

export HOMEBREW_CASK_OPTS=\"--appdir=~/Applications\"

# source the zshrc file created when installing oh-my-zshrc
source ~/.oh-my-zshrc

# next, aliases and functions
source ~/.aliases
source ~/.grep
source ~/.functions



# enable autocompletion of command
autoload bashcompinit && bashcompinit

# nvm installation added this for me
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# iterm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# zsh integration, order matters
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down

