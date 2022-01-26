# export PATH first
export PATH="/usr/local/bin:/usr/local/sbin:~/bin:/opt/homebrew/bin:$PATH"

# next, aliases and functions
source ~/.aliases
source ~/.functions



# enable autocompletion of command
autoload bashcompinit && bashcompinit

# nvm installation added this for me
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# iterm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
