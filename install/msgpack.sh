#!/usr/bin/env bash

CLONE_URL="https://github.com/msgpack/msgpack-c.git"
CLONE_DIR="/tmp"
CLONE_DIR_NAME="msgpack-c"

function main {
	cd $CLONE_DIR
	git clone $CLONE_URL $CLONE_DIR_NAME
	cd $CLONE_DIR_NAME
	cmake . && make && sudo make install
}

main
