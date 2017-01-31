#!/usr/bin/env bash

# sync all files in ../link/

source "$HOME/.dotfiles/install/conf.sh"

NEED_CONFIRM=1

if [ $# -gt 0 ]; then
	if [ "$1" = "-y" ]; then
		NEED_CONFIRM=0
	fi
fi

if [ $NEED_CONFIRM -eq 1 ]; then
	cmn_ask_to_continue "Are you sure ?"
fi
# continue to process.

if [[ ! -f $MAP_FILE ]]; then
	cmn_echo_info "done"
	exit 0
fi

while IFS= read -r line; do
	DEST_NAME=$LINK_DIR/${line#"$HOME/"}

	if [[ -f "$line" && ! -L "$line" ]]; then
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
			echo "[DONE] => $line is a symlink."
		elif [[ -f "$DEST_NAME" ]]; then
			# sync from link
			ln -s $DEST_NAME $line
			echo "[DONE] => $line"
		else
			echo "[FAIL] => $line may not exists."
		fi
	fi
done <"$MAP_FILE"
