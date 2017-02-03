
if [ -z "$DOTFILES" ]; then
	DOTFILES="$HOME/.dotfiles"
fi

if [ -z "$ZSH" ]; then
	# it's not zsh
	source "$DOTFILES/source/init_nozsh.sh"
	source ~/.zshenv
fi
