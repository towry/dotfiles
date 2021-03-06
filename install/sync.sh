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
	line="$HOME/$line"
	# line_parent_dir=$(dirname "$line")
	DEST_NAME=$LINK_DIR/${line#"$HOME/"}

	if [[ ! -e "$line" ]]; then
		# create parent directory if not exists.
		if [[ ! -e $(dirname "$line") ]]; then
			mkdir -p $(dirname "$line")
		fi

		ln -s $DEST_NAME $line
		echo "[DONE] => $line"
	elif [[ -L "$line" ]]; then
		echo "[DONE] => $line is a symlink."
	elif [[ -e "$line" && -e "$DEST_NAME" ]]; then
		# remove local with backup
		if [[ -d "$line" ]]; then
			backup_name=$BACKUP_DIR/${line#"$HOME/"}
			backup_name=$(dirname "$backup_name")
			cp -rf "$line" "$backup_name"
			rm -rf "$line"
		else
			backup_name=$BACKUP_DIR/${line#"$HOME/"}
			cp -f "$line" "$backup_name"
			rm "$line"
		fi
		ln -s $DEST_NAME $line
		echo "[DONE] => $line"
	elif [[ -e "$line" && ! -e "$DEST_NAME" ]]; then
		# we only allow add from 'add.sh', so...
		echo "[FAIL] => You may need fix the map.txt file"
	fi
done <"$MAP_FILE"
