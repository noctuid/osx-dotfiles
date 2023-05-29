# shellcheck disable=1090
source ~/dotfiles/scripts/aliases/stow.sh

if hash pyenv 2> /dev/null; then
	# set up pyenv
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PYENV_ROOT/bin:$PATH"
	# add pyenv shims
	eval "$(pyenv init --path)"
fi

restartkarabiner() {
    service=org.pqrs.karabiner.karabiner_console_user_server
    launchctl stop "$service" && launchctl start "$service"
}

dots() {
    ~/dotfiles/setup.sh "$@"
}
