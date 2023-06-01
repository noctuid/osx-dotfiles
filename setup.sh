#!/usr/bin/env bash
# dependencies:
# - git (should be installed by default)
# - svn
# - nix
# - brew
# - xcode and developer tools (i.e. xcode-select --install)
# - gnu coreutils (brew install coreutils)
# - macfuse for isntalling avfs and extfuse (brew install macfuse)

# NOTE: Have to put in password to install some things; have to give some
# programs accessibility permissions (e.g. skhd)

# MAYBE ranger config
# TODO neovim config
# TODO consistent error _message on failure

# * Helpers
basedir=$(dirname "$(realpath "$0")")
rdotfiles=https://raw.githubusercontent.com/noctuid/dotfiles/master
svn_dotfiles=https://github.com/noctuid/dotfiles/trunk

# shellcheck disable=SC1090
source "$basedir"/setup-utils/setup-utils.sh

# * Stow
stow_dotfiles() {
	# shellcheck disable=1090
	source "$basedir"/scripts/aliases/stow.sh
	_message "Symlinking config files."
	restow || _errm "Symlinking config files failed."
}

# * VS Code Setup
vscode_setup() {
	_message "Setting up VS Code"
	grep --invert-match '^#' "$basedir"/editing/vscode-extensions.txt \
		| xargs -L1 code --install-extension \
		|| _errm "VS Code setup failed."
}

# * Lunar Setup
# unsure if will use yet
lunar_setup() {
	/Applications/Lunar.app/Contents/MacOS/Lunar install-cli
}

# * Prevent Application Restore
# even on crash
no_reopen_setup() {
	# https://apple.stackexchange.com/questions/129327/avoiding-all-apps-reopening-when-os-x-crashes
	# prevent writing this file (don't remove or will recreate)
	_message "Preventing applications from reopening even on crash"
	sudo chown root ~/Library/Preferences/ByHost/com.apple.loginwindow*
	sudo chmod 000 ~/Library/Preferences/ByHost/com.apple.loginwindow*
}

# * Pywal Setup
# necessary because release version of pywal is very broken
pywal_setup() {
	if ! hash wal 2> /dev/null; then
		pipx install git+https://github.com/dylanaraps/pywal.git
	fi
	if ! pipx list | grep --quiet 'pywalfox'; then
		pipx install pywalfox
		pywalfox install
	fi
	if [[ ! -d ~/.cache/wal ]]; then
		pywal_gruvbox
	fi
}

# https://github.com/dylanaraps/pywal/issues/668
pywal_gruvbox() {
	walset --theme base16-gruvbox-soft "$basedir"/mac-wallpapers/gruv.jpg
}

pywal_rose_pine() {
	walset --theme rose-pine-hybrid "$basedir"/mac-wallpapers/pixelmoon.png
}

# * Main
setup_help() {
    echo "usage: [options] [subcommand]

By default (no args specified) or if \"all\" is given as the subcommand, run all
setup functions. To run a specific setup function, you can specify it, e.g.
\"emacs_setup\" to get the latest Emacs configuration.

Here are a list of available commands:
$(declare -F | awk '!/^declare -f _/{print "- " $NF}')
- nix (alias for nix_setup)
- emacs (alias for emacs_pull)
- pull (alias for all_config_pull)

options:
  -h or --help			print this help text
"
}

all() {
	nix_pull "$basedir"/flake.lock
	nix_channel_setup
	nix_setup

	# yarn_global_install

	emacs_pull
	shell_pull
	browser_pull
	pywal_pull
	python_pull

	# vscode_setup

	gitconfig_setup
	github_auth_setup

	stow_dotfiles

	no_reopen_setup

	pywal_setup
}

_main() {
	if [[ $1 =~ ^(-h|--help)$ ]]; then
		setup_help
	elif [[ -z $1 ]]; then
		all
	elif [[ $1 == nix ]]; then
		nix_setup
	elif [[ $1 == emacs ]]; then
		emacs_pull
	elif [[ $1 == pull ]]; then
		all_config_pull
	else
		"$@"
	fi
}

_main "$@"
