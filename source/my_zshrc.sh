#!/usr/bin/bash

export DOTFILES="$HOME/.dotfiles"

alias cls="clear"
alias pyact="pyenv activate"
alias pydeact="pyenv deactivate"
alias s="subl"
# alias n="gnvim"
alias m="mvim"
alias v="vimr"
alias gts="gits"

alias gac='echo "$(tput bold)$(tput setaf 3)warning: be carefull$(tput sgr0)" && git add . && git commit'
alias gtail="git rev-list --all | tail"
alias xmerge="git merge --no-ff"
alias xmerged="git branch --merged master"
alias g="git"
if type nvim > /dev/null; then
	alias vi="nvim"
fi
alias typora="open -a typora"
alias docker-exec="docker exec -it"
alias docker-logs="/bin/bash ~/.dotfiles/source/docker-logs"

export FZF_DEFAULT_COMMAND='ag -g ""'

export RUSTUP_DIST_SERVER="https://mirrors.ustc.edu.cn/rust-static"

# NVM
export NVM_DIR="$HOME/.nvm"
loadnvm() {
	[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
}

# loadrsvm() {
# 	[[ -s $HOME/.rsvm/rsvm.sh ]] && . $HOME/.rsvm/rsvm.sh # This loads RSVM
# }

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

#>>>>> PATH <<<<<<
DEF_NODE_VER="$(< ~/.nvm/alias/default)"
DEF_NODE_BIN_PATH="$HOME/.nvm/versions/node/$DEF_NODE_VER/bin"

export GOPATH=$HOME/workspace/goenv
export PATH="$PATH:/usr/local/opt/openssl/bin\
:/Library/Frameworks/Python.framework/Versions/3.4/bin\
:/usr/local/bin\
:/usr/local/go/bin\
:/usr/local/git/bin\
:/usr/local/sbin\
:$GOPATH/bin\
:$DEF_NODE_BIN_PATH\
:$HOME/.cargo/bin"
#>>>>> END PATH <<<<<<


# >>> source
source ~/.dotfiles/source/shutils
source ~/.dotfiles/vendor/z/z.sh
# Platform specific source
if [[ $(uname -s) == Linux ]]
then
	source ~/.dotfiles/source/debian_zshrc.sh
else
	source ~/.dotfiles/source/osx_zshrc.sh
fi

# <<<
