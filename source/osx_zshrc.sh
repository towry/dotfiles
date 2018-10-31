load_swiftenv() {
	if which swiftenv > /dev/null;then
		eval "$(swiftenv init -)";
	fi
}
load_swiftenv

if [[ -d $HOME/.pyenv ]];then
	export PATH="$HOME/.pyenv/bin:$PATH"
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
fi
