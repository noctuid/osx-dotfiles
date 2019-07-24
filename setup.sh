#!/usr/bin/env bash
# dependencies:
# - brew
# - xcode and developer tools (i.e. xcode-select --install)
# NOTE: Have to put in password to install some things; have to give some
# programs accessiiblity permissions (e.g. skhd)

# TODO installing gvfs requires installing macports
# TODO kitty config
# TODO zsh config
# TODO ranger config
# TODO browser config

# * Package Installation
# brew seems extremely slow...
echo "Installing packages with Brew."
brew bundle --no-upgrade || exit 1

# * Stow
# shellcheck disable=1090
source ~/dotfiles/scripts/aliases/stow.sh
echo "Symlinking config files."
restow || echo "Symlinking config files failed."

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

install_emacs_anywhere() {
	if [[ ! -d ~/.emacs_anywhere/.git ]]; then
		git clone https://github.com/zachcurry/emacs_anywhere ~/.emacs-anywhere
	fi
	# cp -Rf ~/.emacs-anywhere/"Emacs Anywhere".workflow ~/Library/Services
}

install_emacs_anywhere || echo "Installing Emacs Anywhere failed."

# * Services
echo "Enabling services."
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

brew services start emacs-plus
brew services start skhd

# * NPM/Yarn
echo "Installing programs with yarn."
yarn global add indium
yarn global add typescript-language-server
yarn global add prettier

# * Git Config Reminder
if [[ ! -f ~/.gitconfig ]]; then
	echo 'Remember to setup ~/.gitconfig with:
[includeIf "gitdir:~/school/**"]
path = .gitconfig-school
[includeIf "gitdir:~/src/**"]
path = .gitconfig-personal
[includeIf "gitdir:~/src/**"]
path = .gitconfig-personal
[includeIf "gitdir:~/dotfiles/**"]
path = .gitconfig-personal
'
fi

if [[ ! -f ~/.gitconfig-school ]]; then
	echo "Remember to create ~/.gitconfig-school"
fi

if [[ ! -f ~/.gitconfig-personal ]]; then
	echo "Remember to create ~/.gitconfig-personal"
fi
