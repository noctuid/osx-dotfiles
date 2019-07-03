#!/usr/bin/env bash
# dependencies:
# - brew
# - xcode and developer tools (i.e. xcode-select --install)

# TODO installing gvfs requires installing macports
# TODO kitty config
# TODO zsh config
# TODO ranger config
# TODO browser config

# * Package Installation
# brew seems extremely slow...
echo "Installing packages with Brew."
brew bundle --no-upgrade || exit 1

# * Emacs config
emacs_setup() (
	# useful here (but see http://mywiki.wooledge.org/BashFAQ/105)
	set -e

	ln -sf /usr/local/Cellar/emacs-plus/*/Emacs.app/ /Applications/

	# brew services start d12frosted/emacs-plus/emacs-plus

	if [[ -f ~/.emacs ]]; then
		# ~/.emacs will prevent init.el from loading
		trash ~/.emacs
	fi

	mkdir -p ~/tmp/.emacs.d
	if [[ -f ~/.emacs.d/lisp.local.el ]]; then
		cp -f ~/.emacs.d/lisp/local.el ~/tmp/.emacs.d/
	fi
	if [[ -d ~/.emacs.d/straight ]]; then
		sudo cp -Rf ~/.emacs.d/straight ~/tmp/.emacs.d/
	fi

	trash ~/.emacs.d
	# github doesn't support git-archive
	# however, it will convert to svn repo in backend
	# this can be used to get a specific folder
	svn checkout https://github.com/noctuid/dotfiles/trunk/emacs/.emacs.d \
		~/.emacs.d
	# TODO use lockfile once up-to-date
	trash ~/.emacs.d/straight

	if [[ -d ~/tmp/.emacs.d ]]; then
		cp -R ~/tmp/.emacs.d ~/
	fi
)

echo "Setting up Emacs with latest configuration."
emacs_setup || echo "Emacs setup failed."

# * Locate Service
echo "Enabling services."
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

# * NPM/Yarn
echo "Installing programs with yarn."
yarn global add indium
yarn global add typescript-language-server
yarn global add prettier
