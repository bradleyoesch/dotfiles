# ~~~ zsh setup ~~~
# Plain-zsh replacement for oh-my-zsh. Ports the pieces we actually used;
# the prompt lives separately in .zshrc.prompt.

# completion
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # case-insensitive
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''

# options (curated oh-my-zsh defaults). NO share_history, it would fight
# per-directory-history and leak commands across dirs/panes.
setopt AUTO_CD
setopt AUTO_PUSHD PUSHD_IGNORE_DUPS
setopt EXTENDED_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_VERIFY HIST_REDUCE_BLANKS
setopt INTERACTIVE_COMMENTS
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

# autojump (brew): provides `j`
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && source /opt/homebrew/etc/profile.d/autojump.sh

# per-directory-history: command history scoped to the current directory
source ~/.config/dotfiles/plugins/per-directory-history.zsh

# zsh UX plugins (brew), order matters
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down
