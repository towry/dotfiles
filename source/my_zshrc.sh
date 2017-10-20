#!/usr/bin/bash

export DOTFILES="$HOME/.dotfiles"

alias cls="clear"
alias pyact="pyenv activate"
alias pydeact="pyenv deactivate"
alias s="subl"
# alias n="gnvim"
alias m="mvim"
alias gts="gits"

alias gac='echo "$(tput bold)$(tput setaf 3)warning: be carefull$(tput sgr0)" && git add . && git commit'
alias gtail="git rev-list --all | tail"
alias xmerge="git merge --no-ff"
alias g="git"
if type nvim > /dev/null; then
	alias vi="nvim"
fi

export FZF_DEFAULT_COMMAND='ag -g ""'

#>>>>> PATH <<<<<<
DEF_NODE_VER="$(< ~/.nvm/alias/default)"
DEF_NODE_BIN_PATH="$HOME/.nvm/versions/node/$DEF_NODE_VER/bin"

export GOPATH=/Users/towry/workspace/goenv

export PATH="/usr/local/opt/openssl/bin\
:/Library/Frameworks/Python.framework/Versions/3.4/bin\
:/usr/local/go/bin\
:/usr/local/git/bin\
:/usr/local/sbin\
:$GOPATH/bin\
:$DEF_NODE_BIN_PATH\
:$HOME/.cargo/bin:$PATH"

# export PATH
#<<<<< PATH >>>>>>

# >>> Version managers
# PYENV
# Setting PATH for Python 3.4
# The orginal version is saved in .bash_profile.pysave
export RUSTUP_DIST_SERVER="https://mirrors.ustc.edu.cn/rust-static"

# NVM
export NVM_DIR="/Users/towry/.nvm"
loadnvm() {
	[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
}

# >>> Sources
# [[ -s "/Users/towry/.gvm/scripts/gvm" ]] && source "/Users/towry/.gvm/scripts/gvm"

### Added by the Heroku Toolbelt
# export PATH="/usr/local/heroku/bin:$PATH"

if [[ -d $HOME/.pyenv ]];then
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
fi

load_swiftenv() {
	if which swiftenv > /dev/null;then
		eval "$(swiftenv init -)";
	fi
}
load_swiftenv

# >>> Exports
# PATH="/usr/local/bin/vi:$HOME/dev/.tools/depot_tools:$PATH"
# export PATH
# <<<

# eval "$(docker-machine env default)"

# loadrsvm() {
# 	[[ -s /Users/towry/.rsvm/rsvm.sh ]] && . /Users/towry/.rsvm/rsvm.sh # This loads RSVM
# }

# source ~/.gvm/scripts/gvm
export PYTHONPATH="/Users/towry/Projects/mtp:${PYTHONPATH}"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# autojump
# [[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh


# >>> source
source ~/.dotfiles/source/shutils
source ~/.dotfiles/vendor/z/z.sh
# <<<
