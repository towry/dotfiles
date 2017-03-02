
if [ -z "$DOTFILES" ]; then
	DOTFILES="$HOME/.dotfiles"
fi

# it's not zsh
if [ -z "$ZSH" ]; then
	echo "??????"
	source "$DOTFILES/source/init_nozsh.sh"

	source ~/.dotfiles/source/my_zshrc.sh
fi
