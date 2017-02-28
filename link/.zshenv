#!/usr/bin/env zsh

export PATH="/Library/Developer/Toolchains/swift-latest.xctoolchain/usr/bin:$PATH"
export PATH="/usr/local/opt/openssl/bin:/Users/towry/.pyenv/shims:/Library/Frameworks/Python.framework/Versions/3.4/bin:/usr/local/git/bin:/usr/local/sbin:/Users/towry/.nvm/versions/node/v0.12.4/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/go/bin:/usr/local/MacGPG2/bin:$PATH"
# >>> Sources
# export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
# [[ -s "/Users/towry/.gvm/scripts/gvm" ]] && source "/Users/towry/.gvm/scripts/gvm"

### Added by the Heroku Toolbelt
# export PATH="/usr/local/heroku/bin:$PATH"

if [[ -d $HOME/.pyenv ]];then
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
fi

swiftenv() {
	if which swiftenv > /dev/null;then
		eval "$(swiftenv init -)";
	fi
}

source ~/.dotfiles/source/my_zshrc.sh
