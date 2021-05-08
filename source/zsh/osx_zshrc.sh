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
  export LDFLAGS="-L/usr/local/opt/zlib/lib -L/usr/local/opt/bzip2/lib"
  export CPPFLAGS="-I/usr/local/opt/zlib/include -I/usr/local/opt/bzip2/include"
fi
