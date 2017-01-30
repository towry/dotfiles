#!/usr/bin/env bash

# make all shell script executable.

for filename in ./*.sh; do
	if [[ -f $filename && ! -x $filename ]]; then
		echo "chmod +x ${filename}"
		chmod +x "${filename}"
	fi
done

