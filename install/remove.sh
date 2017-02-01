#!/usr/bin/env bash

# remove file from link directory

source "$HOME/.dotfiles/install/conf.sh"

# remove record from map.txt
function remove_from_map {
	sed -i.bak "\#$1#d" "$MAP_FILE"
}

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

DEST_NAME=$HOME/${fname#"$LINK_DIR/"}
DEST_FILE_NAME=$DEST_NAME
if [[ -d "$fname" ]]; then
	DEST_NAME=$(dirname $HOME/${fname#"$LINK_DIR/"})
fi

if [[ -e $DEST_FILE_NAME ]]; then
	echo "do you want to restore '$DEST_FILE_NAME'?"
	cmn_ask_to_continue
fi
# else: continue

if [[ -L $DEST_FILE_NAME ]]; then
	rm $DEST_FILE_NAME
	# move file
	mv -f $fname $DEST_NAME
	cmn_echo_info "mv {$fname} => {$DEST_FILE_NAME}"
else
	cp -rf $fname $DEST_NAME
fi

# remove linked file.
if [[ -f $fname ]]; then
	rm $fname
elif [[ -d $fname ]]; then
	rm -r $fname
fi

remove_from_map $DEST_FILE_NAME
