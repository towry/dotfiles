
if [ -n $DOTFILES ]; then
	DOTFILES="$HOME/.dotfiles"
fi

if [ -n $ZSH ]; then
	# it's not zsh
	source "$DOTFILES/source/init_nozsh.sh"
	source ~/.zshenv
fi
