#!/usr/bin/env bash

# sync all files in ../link/

source "$HOME/.dotfiles/install/conf.sh"

cmn_ask_to_continue "Are you sure ?"
# continue to process.

if [[ ! -f $MAP_FILE ]]; then
	cmn_echo_info "done"
	exit 0
fi

while IFS= read -r line; do
	if [[ -f "$line" && ! -L "$line" ]]; then
		DEST_NAME=$LINK_DIR/${line#"$HOME/"}
		if [[ -f "$DEST_NAME" ]]; then
			echo "[DONE] => $DEST_NAME file exists when do $line."
		fi

		# move file
		mv $line $DEST_NAME
		# link file
		ln -s $DEST_NAME $line
		echo "[DONE] => $line"
	else
		if [[ -L "$line" ]]; then
			echo "[FAIL] => $line is a symlink."
		else
			echo "[FAIL] => $line may not exists."
		fi
	fi
done <"$MAP_FILE"
