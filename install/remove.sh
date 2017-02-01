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

if [[ -e $DEST_NAME ]]; then
	echo "do you want to restore '$DEST_NAME'?"
	cmn_ask_to_continue
fi
# else: continueo

# move file
mv $fname $DEST_NAME
cmn_echo_info "mv {$fname} => {$DEST_NAME}"

# remove linked file.
if [[ -f $fname ]]; then
	rm $fname
else [[ -d $fname ]]; then
	rm -r $fname
fi

remove_from_map $DEST_NAME
