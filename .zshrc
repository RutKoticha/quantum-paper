# -----------------------------
# Environment Variables
# -----------------------------

# PostgreSQL (Ubuntu default – only if you actually use it)
# export PGDATA=/var/lib/postgresql/15/main

export PATH="$HOME/.local/bin:$HOME/.npm-global/bin:/mnt/data/Flutter/flutter/bin:$HOME/bin:$PATH"

# -----------------------------
# NVM
# -----------------------------

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

# -----------------------------
# Zinit
# -----------------------------

ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname "$ZINIT_HOME")"
   git clone git@github.com:zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "$ZINIT_HOME/zinit.zsh"

# -----------------------------
# Oh My Posh
# -----------------------------
if command -v oh-my-posh >/dev/null 2>&1; then
  eval "$(oh-my-posh init zsh --config "$HOME/.config/ohmyposh/zen.toml")"
fi

# -----------------------------
# Plugins
# -----------------------------

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# -----------------------------
# OMZ snippets
# -----------------------------

zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# -----------------------------
# Completion
# -----------------------------

autoload -Uz compinit
compinit

zinit cdreplay -q

# -----------------------------
# History
# -----------------------------

HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTFILE=$HOME/.zsh_history
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups hist_save_no_dups hist_ignore_dups hist_find_no_dups

# -----------------------------
# Completion + fzf-tab styling
# -----------------------------

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color=auto $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color=auto $realpath'

# -----------------------------
# Aliases
# -----------------------------

alias ls='ls --color=auto'
alias vim='nvim'
alias c='clear'

# -----------------------------
# Tool integrations
# -----------------------------

command -v fzf >/dev/null && eval "$(fzf --zsh)"
command -v zoxide >/dev/null && eval "$(zoxide init --cmd cd zsh)"

# -----------------------------
# Key bindings
# -----------------------------

bindkey '^[[H' beginning-of-line
bindkey '^[[1~' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# -----------------------------
# Angular completion
# -----------------------------

command -v ng >/dev/null && source <(ng completion script)

# -----------------------------
# Extra configs
# -----------------------------

if [ -d ~/.zshrc.d ]; then
  for rc in ~/.zshrc.d/*; do
    [ -f "$rc" ] && source "$rc"
  done
fi

. "$HOME/.cargo/env" 
export PATH=$PATH:/usr/local/go/bin
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
alias psql-sourcenode='psql "postgresql://doadmin@db-sourcenode-do-user-30924051-0.i.db.ondigitalocean.com:25060/defaultdb?sslmode=require"'


