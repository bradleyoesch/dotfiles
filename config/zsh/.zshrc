export PATH="/usr/local/bin:/usr/local/sbin:~/bin:/opt/homebrew/bin:$PATH"

# zsh setup (completion, options, plugins) and prompt
source ~/.config/dotfiles/.zshrc.zsh
source ~/.config/dotfiles/.zshrc.prompt

# next, our custom shell stuff, order matters
source ~/.config/dotfiles/.zshrc.constants
source ~/.config/dotfiles/.zshrc.functions
source ~/.config/dotfiles/.zshrc.aliases
source ~/.config/dotfiles/.zshrc.grep



# enable autocompletion of command
autoload bashcompinit && bashcompinit

# nvm installation added this for me
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# iterm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# planderson completions
test -e "${HOME}/.planderson/completions/planderson.zsh" && source "${HOME}/.planderson/completions/planderson.zsh"

# machine-local overrides and secrets, not versioned. keep last so it wins.
test -e "${HOME}/.zshrc.local" && source "${HOME}/.zshrc.local"
