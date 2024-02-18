#!/usr/bin/env bash
# dependencies:
# - git (should be installed by default)
# - svn
# - nix (if using)
# - brew
# - xcode and developer tools (i.e. xcode-select --install)
# - gnu coreutils (brew install coreutils)
# - macfuse for isntalling avfs and extfuse (brew install macfuse)

# NOTE: Have to put in password to install some things; have to give some
# programs accessibility permissions (e.g. skhd)

# MAYBE ranger config
# TODO neovim config
# TODO consistent error _message on failure

# * Helpers/Setup
basedir=$(dirname "$(realpath "$0")")
rdotfiles=https://raw.githubusercontent.com/noctuid/dotfiles/master
svn_dotfiles=https://github.com/noctuid/dotfiles/trunk

export USE_NIX=${USE_NIX:-false}

# shellcheck disable=SC1090
source "$basedir"/setup-utils/setup-utils.sh

mkdir -p ~/.cache

# * Stow
stow_dotfiles() {
	# shellcheck disable=1090
	source "$basedir"/scripts/aliases/stow.sh
	_message "Symlinking config files."
	restow || _errm "Symlinking config files failed."
}

# * Brew Setup
brew_install_packages() {
	brew bundle --file="$basedir"/Brewfile
}

# NOTE: this only needs to be run once but is idempotent
services_setup() {
	_message "Enabling services."
	yabai --start-service
	skhd --start-service
	brew services start sketchybar
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

# NOTE this won't work first run until yabai has created spaces
# https://github.com/dylanaraps/pywal/issues/668
pywal_gruvbox() {
	walset --theme base16-gruvbox-soft "$basedir"/mac-wallpapers/gruv.jpg
}

pywal_rose_pine() {
	walset --theme rose-pine-hybrid "$basedir"/mac-wallpapers/pixelmoon.png
}

# * Hackarounds
# must start daemon through Emacs.app for windows to be managed/tiled by yabai
hack_start_emacs_daemons() {
	open -a Emacs --args --daemon
	open -a Emacs --args --daemon=dirvish
}

# TODO unfortunately needs to be split/run in new terminal for nix programs to
# be available
emacsup() {
	hack_start_emacs_daemons
}

__hack_start_nix() {
	sudo launchctl kickstart -k system/org.nixos.darwin-store
	sudo launchctl kickstart -k system/org.nixos.nix-daemon
	sudo launchctl kickstart -k system/org.nixos.yabai-sa
}

__hack_reload_failed_services() {
	local agentdir plists
	agentdir=~/Library/LaunchAgents
	plists=(
		"$agentdir/org.nixos.yabai.plist"
		"$agentdir/org.nix-community.home.skhd.plist"
		"$agentdir/org.nix-community.home.sketchybar.plist"
	)
	for plist in "${plists[@]}"; do
		launchctl unload "$plist"
		launchctl load -w "$plist"
	done
}

__nixup() (
	# nix-darwin... rebuild switch will take care of everything if needed
	# sudo launchctl kickstart -k system/org.nixos.activate-system

	__hack_start_nix
	__hack_reload_failed_services
	# FIXME
	export NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1
	# necessary for Emacs.app to be available
	nix_darwin_switch
	_message "Open a new terminal and run: dots emacsup"
	_message "Don't run emacsclient immediately afterwards.  If you have
problems with packages not being available, you may need to kill Emacs in
activity monitor and start it again."
)

# * Post Reboot
post_reboot() {
	emacsup
	~/.config/yabai/yabairc
}

# * Main
setup_help() {
    echo "usage: [options] [subcommand]

By default (no args specified) or if \"all\" is given as the subcommand, run all
setup functions. To run a specific setup function, you can specify it, e.g.
\"emacs_setup\" to get the latest Emacs configuration.

Here are a list of available commands:
$(declare -F | awk '!/^declare -f _/{print "- " $NF}')
- brew (alias for brew_install_packages)
- nix (alias for nix_setup)
- emacs (alias for emacs_pull)
- pull (alias for all_config_pull)

options:
  -h or --help			print this help text
"
}

all() {
	if $USE_NIX; then
		nix_pull "$basedir"/flake.lock || return 1
		nix_channel_setup
		nix_setup || return 1
	else
		brew_install_packages
		services_setup
	fi
	cargo_install

	# yarn_global_install

	all_config_pull

	# vscode_setup

	gitconfig_setup
	gh auth login
	# update .gitconfig
	gh auth setup-git

	stow_dotfiles
	# necessary e.g. for pywal_setup which installs to ~/.local/bin
	# shellcheck disable=SC1090
	source ~/.profile

	no_reopen_setup

	pywal_setup
}

_main() {
	if [[ $1 =~ ^(-h|--help)$ ]]; then
		setup_help
	elif [[ -z $1 ]]; then
		all
	elif [[ $1 == nix ]]; then
		if $USE_NIX; then
			nix_setup
		else
			_errm "Nix is disabled"
			exit 1
		fi
	elif [[ $1 == brew ]]; then
		brew_install_packages
	elif [[ $1 == emacs ]]; then
		emacs_pull
	elif [[ $1 == pull ]]; then
		all_config_pull
	else
		if [[ $1 =~ nix ]] && ! $USE_NIX; then
			_errm "Nix is disabled"
			exit 1
		fi
		"$@"
	fi
}

_main "$@"
