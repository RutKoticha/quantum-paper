# -----------------------------
# Environment Variables
# -----------------------------

export PATH="$HOME/.local/bin:$HOME/.npm-global/bin:/mnt/data/Flutter/flutter/bin:$HOME/bin:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
export HOMEBREW_CELLAR="/home/linuxbrew/.linuxbrew/Cellar"
export HOMEBREW_REPOSITORY="/home/linuxbrew/.linuxbrew"
export MANPATH="/home/linuxbrew/.linuxbrew/share/man${MANPATH+:$MANPATH}:"
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:${INFOPATH:-}"

# -----------------------------
# NVM (lazy-loaded — loads only when you first call node/npm/nvm)
# -----------------------------

export NVM_DIR="$HOME/.nvm"

_load_nvm() {
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
}

# Lazy stubs — real NVM loads on first use
nvm() { unfunction nvm node npm npx; _load_nvm; nvm "$@"; }
node() { unfunction nvm node npm npx; _load_nvm; node "$@"; }
npm() { unfunction nvm node npm npx; _load_nvm; npm "$@"; }
npx() { unfunction nvm node npm npx; _load_nvm; npx "$@"; }

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
# Oh My Posh (cached init)
# -----------------------------

_OMP_CACHE="$HOME/.cache/omp_init.zsh"
_OMP_CONFIG="$HOME/.dotfiles/.config/ohmyposh/config.omp.yaml"

if command -v oh-my-posh >/dev/null 2>&1; then
  if [[ ! -f "$_OMP_CACHE" || "$_OMP_CONFIG" -nt "$_OMP_CACHE" ]]; then
    oh-my-posh init zsh --config "$_OMP_CONFIG" > "$_OMP_CACHE"
  fi
  source "$_OMP_CACHE"
fi

# -----------------------------
# Plugins (defer heavy ones)
# -----------------------------

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit ice wait lucid; zinit light zsh-users/zsh-syntax-highlighting
zinit ice wait lucid; zinit light Aloxaf/fzf-tab

# -----------------------------
# OMZ snippets (deferred)
# -----------------------------

zinit ice wait lucid; zinit snippet OMZL::git.zsh
zinit ice wait lucid; zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit ice wait lucid; zinit snippet OMZP::aws
zinit ice wait lucid; zinit snippet OMZP::kubectl
zinit ice wait lucid; zinit snippet OMZP::kubectx
zinit ice wait lucid; zinit snippet OMZP::command-not-found

# -----------------------------
# Completion (cached — only rebuilds once a day)
# -----------------------------

autoload -Uz compinit
if [[ -n "$HOME/.zcompdump"(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

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
alias grep=rg

# -----------------------------
# Tool integrations (cached)
# -----------------------------

# fzf
_FZF_CACHE="$HOME/.cache/fzf_init.zsh"
if command -v fzf >/dev/null 2>&1; then
  if [[ ! -f "$_FZF_CACHE" ]]; then
    fzf --zsh > "$_FZF_CACHE"
  fi
  source "$_FZF_CACHE"
fi

# zoxide
_ZOXIDE_CACHE="$HOME/.cache/zoxide_init.zsh"
if command -v zoxide >/dev/null 2>&1; then
  if [[ ! -f "$_ZOXIDE_CACHE" ]]; then
    zoxide init --cmd cd zsh > "$_ZOXIDE_CACHE"
  fi
  source "$_ZOXIDE_CACHE"
fi

# Angular completion (lazy — only loads when `ng` is first called)
ng() {
  unfunction ng
  command -v ng >/dev/null && source <(command ng completion script)
  ng "$@"
}

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
# Bun
# -----------------------------

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:/home/koticharut/.opencode/bin:$PATH"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# -----------------------------
# Extra configs
# -----------------------------

if [ -d ~/.zshrc.d ]; then
  for rc in ~/.zshrc.d/*; do
    [ -f "$rc" ] && source "$rc"
  done
fi
