# Auto-attach to tmux on SSH login
if [[ -n "$SSH_CONNECTION" && -z "$TMUX" ]]; then
  tmux attach
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Powerlevel10k prompt (different paths for macOS/Linux)
if [[ -f "/opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
elif [[ -f "$HOME/.powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  source "$HOME/.powerlevel10k/powerlevel10k.zsh-theme"
fi
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# History
HISTSIZE=50000
SAVEHIST=50000

# PATH
[[ -d "/opt/homebrew/bin" ]] && export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.composer/vendor/bin:$PATH"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# pnpm (different paths for macOS/Linux)
if [[ "$OSTYPE" == "darwin"* ]]; then
  export PNPM_HOME="$HOME/Library/pnpm"
else
  export PNPM_HOME="$HOME/.local/share/pnpm"
fi
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Go
[[ -d "/usr/local/go/bin" ]] && export PATH="$PATH:/usr/local/go/bin"  # Go binary (Linux)
export PATH="$PATH:$HOME/go/bin"  # User-installed Go programs

# Aliases
alias ll='ls -laF'
alias gs='git status -s'
alias fco='git for-each-ref --sort=-committerdate --format="%(refname:short)" refs/heads/ | fzf --height=20% --reverse --info=inline --prompt="Switch to branch: " | xargs git checkout'
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias vim=nvim

# Clipboard alias (cross-platform)
if [[ "$OSTYPE" == "darwin"* ]]; then
  alias here="pwd | pbcopy && echo 'Path copied to clipboard'"
else
  alias here="pwd | xclip -selection clipboard && echo 'Path copied to clipboard'"
fi

# Determine size of a file or total size of a directory
function fs() {
  if du -b /dev/null > /dev/null 2>&1; then
    local arg=-sbh
  else
    local arg=-sh
  fi
  if [[ -n "$@" ]]; then
    du $arg -- "$@"
  else
    du $arg .[^.]* ./*
  fi
}

# IDE layout: nvim (left 33%) + claude (right 67%) in tmux
function ide() {
  if [[ -z "$TMUX" ]]; then
    echo "Error: ide must be run inside a tmux session."
    return 1
  fi
  local dir="${PWD}"
  local sock="${TMUX%%,*}"
  tmux -S "$sock" split-window -h -p 67 -c "$dir" "claude --dangerously-skip-permissions"
  tmux -S "$sock" send-keys -t 0 "nvim" Enter
  tmux -S "$sock" select-pane -t 1
}

# Source machine-specific secrets/config (not in repo)
[[ -f "$HOME/.secrets" ]] && source "$HOME/.secrets"

VISUAL="nvim"
EDITOR="nvim"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
