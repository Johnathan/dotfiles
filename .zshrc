# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:~/.composer/vendor/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_GB.UTF-8

export PATH=/usr/local/bin:/Users/$HOME/bin:/usr/local/bin:/Users/$HOME/.composer/vendor/bin:/Users/$HOME/bin:/usr/local/bin:/Users/$HOME/.composer/vendor/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin


# Aliases
alias gs="git status -s"
alias ev="source ~/.zshrc"
alias whysoslow="top -o vsize"
alias cleanup_dsstore="find . -name '*.DS_Store' -type f -ls -delete"
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"

function weather() {
    if [[ $@ ]] then
      curl -s wttr.in/"$@" | sed -n "1,7p"
    else # otherwise fallback to london
      curl -s wttr.in/london | sed -n "1,7p"
    fi
}

# Determine size of a file or total size of a directory
function fs() {
    if du -b /dev/null > /dev/null 2>&1; then
        local arg=-sbh;
    else
        local arg=-sh;
    fi
    if [[ -n "$@" ]]; then
        du $arg -- "$@";
    else
        du $arg .[^.]* ./*;
    fi;
}

CUSTOM_ZSHRC=$HOME/.custom_zshrc
if test -f "$CUSTOM_ZSHRC"; then
  source $CUSTOM_ZSHRC
fi
