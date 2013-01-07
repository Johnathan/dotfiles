# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
# plugins=(brew bundler cap git heroku node npm osx rails3 rvm)

plugins=(legit)

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

# RSpec
alias rspec='_run-with-bundler rspec --colour'

# Export $EDITOR
export EDITOR=vim

alias gs="git status -s"

alias ev="vim ~/.zshrc"

gc()
{
	git commit -m "$1"
}

site()
{
	SITE=$1
	BRANCH=$2
	cd "$HOME/Dropbox/htdocs/$SITE";
	git checkout $BRANCH
}

mkcd()
{
	mkdir $1;
	cd $1;
}

check_syntax()
{
	find . -name \*.php -exec php -l "{}" \; > ~/check_syntax.txt
    grep -v 'No syntax errors detected' ~/check_syntax.txt
    rm ~/check_syntax.txt
}

function mdtouch() {
	if [ ! -d `dirname $1` ]; then mkdir -p `dirname $1`; fi
	touch $1
}

alias git=hub

alias push="git push origin \$(git symbolic-ref HEAD | cut -d'/' -f3)"

alias g:c="php artisan generate:controller"
alias g:m="php artisan generate:model"
alias g:v="php artisan generate:view"
alias g:mig="php artisan generate:migration"
alias g:a="php artisan generate:assets"
alias g:t="php artisan generate:test"
alias g:r="php artisan generate:resource"
alias artisan="php artisan"

export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""

# Customize to your needs...
export PATH="/usr/local/bin:$PATH"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

export NODE_PATH="/usr/local/lib/node"
export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/share/npm/bin:$PATH"
[[ -s $HOME/.pythonbrew/etc/bashrc ]] && source $HOME/.pythonbrew/etc/bashrc
