#!/usr/bin/env bash

#**************************************
# add file that under $HOME dir to link.
#**************************************

source "$HOME/.dotfiles/install/conf.sh"

if [[ $# -eq 0 ]]; then
	echo "usage: $0 [file]"
	exit 0
fi

fname=$(realpath "$1")

if [[ ! -e "$fname" ]]; then
	echo "$fname file not exists."
	echo "exit."
	exit 0
fi
# Return if it's a symlink.
if [[ -L "$fname" ]]; then
	echo "It's a symlink."
	echo "exit."
	exit 0
fi

DEST_NAME=$LINK_DIR/${fname#"$HOME/"}

# test if destination file exists.
if [[ -e "$DEST_NAME" ]]; then
	echo "$DEST_NAME exist"
	cmn_ask_to_continue "do you want to override it?"
fi
# else: continue

# move file
mv $fname $DEST_NAME
# link file
cmn_echo_info "create link {$DEST_NAME} => {$fname}"
ln -s $DEST_NAME $fname

# add to map: $fname
function add_to_map {
	touch $MAP_FILE
	if ! grep -Fxq "$1" $MAP_FILE; then
		echo "$1" >> $MAP_FILE
	fi
}

add_to_map $fname
# done
