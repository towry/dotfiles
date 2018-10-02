load_swiftenv() {
	if which swiftenv > /dev/null;then
		eval "$(swiftenv init -)";
	fi
}
load_swiftenv
