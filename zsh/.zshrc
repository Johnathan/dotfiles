DISABLE_AUTO_UPDATE="true"

TERM=screen-256color

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh
setopt AUTO_CD
[ -z "$TMUX" ] && export TERM=xterm-256color


plugins=(brew legit)

source $ZSH/oh-my-zsh.sh

function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    echo '○'
}

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

PROMPT='
%{$fg_bold[red]%}$(collapse_pwd)%{$reset_color%}$(git_prompt_info)$(git_prompt_status)
$(virtualenv_info)-> '

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[green]%}+$fg[red]%}-$reset_color%}$fg[white]"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[blue]%}•%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} ✔%{$reset_color%}"

# Export $EDITOR
export EDITOR=vim

alias yolo='sudo'
alias clit="git"
alias gs="git status -s"
alias ev="vim ~/.zshrc"
alias v="mvim ."

mkcd()
{
	mkdir $1;
	cd $1;
}

# Checks PHP syntax for all PHP files in directory
check_php_syntax()
{
	find . -name \*.php -exec php -l "{}" \; > ~/check_syntax.txt
    grep -v 'No syntax errors detected' ~/check_syntax.txt
    rm ~/check_syntax.txt
}

# Creates directory and file
function mdtouch() {
	if [ ! -d `dirname $1` ]; then mkdir -p `dirname $1`; fi
	touch $1
}

function server()
{
	python -m SimpleHTTPServer
}

# Laravel Generator Aliases
alias g:c="php artisan generate:controller"
alias g:r="php artisan generate:resource"
alias g:m="php artisan generate:model"
alias g:v="php artisan generate:view"
alias g:mig="php artisan generate:migration"
alias g:a="php artisan generate:assets"
alias g:t="php artisan generate:test"
alias g:r="php artisan generate:resource"
alias artisan="php artisan"

# z
source /usr/local/etc/profile.d/z.sh

export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""

# Customize to your needs...
export PATH="/usr/local/bin:$PATH"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

export NODE_PATH="/usr/local/lib/node"
export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/share/npm/bin:$PATH"
export PATH=/Applications/MAMP/bin/php/php5.4.10/bin:$PATH
[[ -s $HOME/.pythonbrew/etc/bashrc ]] && source $HOME/.pythonbrew/etc/bashrc
