#!/usr/bin/bash

alias cls="clear"
alias pyact="pyenv activate"
alias pydeact="pyenv deactivate"
alias s="subl"
# alias n="gnvim"
alias m="mvim"

alias gac='echo "$(tput bold)$(tput setaf 3)warning: be carefull$(tput sgr0)" && git add . && git commit'
alias gtail="git rev-list --all | tail"
alias xmerge="git merge --no-ff"
alias g="git"
if type nvim > /dev/null; then
	alias vi="nvim"
fi
alias rm="echo Use 'del', or the full path i.e. '/bin/rm'"

# >>> Version managers

# PYENV
# Setting PATH for Python 3.4
# The orginal version is saved in .bash_profile.pysave
export PATH="/Users/towry/.multirust/toolchains/stable/cargo/bin:/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
export RUSTUP_DIST_SERVER="https://mirrors.ustc.edu.cn/rust-static"

DEF_NODE_VER="$(< ~/.nvm/alias/default)"
DEF_NODE_BIN_PATH="$HOME/.nvm/versions/node/$DEF_NODE_VER/bin:$PATH"
export GOPATH=/Users/towry/workspace/goenv
export PATH="$PATH:$GOPATH/bin:$HOME/.rvm/rubies/default/bin"
export PATH="$DEF_NODE_BIN_PATH:$HOME/.cargo/bin:$PATH"

# NVM
export NVM_DIR="/Users/towry/.nvm"
loadnvm() {
	[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
}

# >>> Exports
# PATH="/usr/local/bin/vi:$HOME/dev/.tools/depot_tools:$PATH"
# export PATH
# <<<

# eval "$(docker-machine env default)"

loadrsvm() {
	[[ -s /Users/towry/.rsvm/rsvm.sh ]] && . /Users/towry/.rsvm/rsvm.sh # This loads RSVM
}

# source ~/.gvm/scripts/gvm
export PYTHONPATH="/Users/towry/Projects/mtp:${PYTHONPATH}"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export VISUAL=vim
export EDITOR="$VISUAL"
# autojump
# [[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh


# >>> source
source ~/.dotfiles/source/shutils
source ~/.dotfiles/vendor/z/z.sh
# <<<

if [ -f ./private.sh ]; then
	source ./private.sh
fi

# http://henrik.nyh.se/2008/12/git-dirty-prompt
# http://www.simplisticcomplexity.com/2008/03/13/show-your-git-branch-name-in-your-prompt/
#   username@Machine ~/dev/dir[master]$   # clean working directory
#   username@Machine ~/dev/dir[master*]$  # dirty working directory

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1$(parse_git_dirty))/"
}
export PS1='\[\033[01;32m\]\u\[\033[00m\]:\[\033[1;33m\]\w\[\033[0m\]$(parse_git_branch)$ '
