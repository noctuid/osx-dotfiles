#!/usr/bin/env bash

# NOTE: don't run this; verify script then manually run
install_nix() {
	# https://nixos.org/download.html
	# multi-user installation
	sh <(curl -L https://nixos.org/nix/install) --daemon
	# then in new terminal
	nix-shell -p nix-info --run "nix-info -m"
}

install_brew() {
	# https://docs.brew.sh/Installation
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
}

# TODO check if this is still needed (no longer installing most packages through
# brew for one)
# UPDATE it looks like brew install does chmod go-w at least for share/zsh and
# site-functions already
# many packages write here and will fail to install by default
# sudo chown -R "$(whoami)" /usr/local/share/man /usr/local/share/man/man1 \
#      /usr/local/share/zsh /usr/local/share/zsh/site-functions
# chmod u+w /usr/local/share/man /usr/local/share/man/man1 /usr/local/share/zsh \
#       /usr/local/share/zsh/site-functions

# macfuse required for various packages (e.g. avfs and extfuse)
brew install coreutils macfuse jq
