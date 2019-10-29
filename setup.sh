#!/usr/bin/env bash
# dependencies:
# - brew
# - xcode and developer tools (i.e. xcode-select --install)
# NOTE: Have to put in password to install some things; have to give some
# programs accessiiblity permissions (e.g. skhd)

# TODO installing gvfs requires installing macports
# TODO ranger config
# TODO browser config

basedir=$(dirname "$(realpath "$0")")
rdotfiles=https://raw.githubusercontent.com/noctuid/dotfiles/master
svn_dotfiles=https://github.com/noctuid/dotfiles/trunk

# * Package Installation
# brew seems extremely slow...
echo "Installing packages with Brew."
brew bundle --no-upgrade || echo "Brew package installation failed."

# * Emacs config
emacs_setup() (
	# useful here (but see http://mywiki.wooledge.org/BashFAQ/105)
	set -e

	ln -sf /usr/local/Cellar/emacs-plus/*/Emacs.app/ /Applications/

	# brew services start d12frosted/emacs-plus/emacs-plus

	mkdir -p ~/.emacs.d/{lisp,straight,yasnippet/snippets}
	curl "$rdotfiles"/emacs/.emacs.d/early-init.el > ~/.emacs.d/early-init.el
	curl "$rdotfiles"/emacs/.emacs.d/init.el > ~/.emacs.d/init.el
	curl "$rdotfiles"/emacs/.emacs.d/awaken.org > ~/.emacs.d/awaken.org
	curl "$rdotfiles"/emacs/.emacs.d/lisp/noct-util.el \
		 > ~/.emacs.d/lisp/noct-util.el
	# TODO use lockfile once up-to-date
	# curl "rdotfiles"/emacs/.emacs.d/straight/versions/default.el \
		# 	 > ~/.emacs.d/straight/versions/default.el

	# github doesn't support git-archive
	# however, it will convert to svn repo in backend
	# this can be used to get a specific folder
	svn checkout "$svn_dotfiles"/emacs/.emacs.d/etc/yasnippet/snippets \
		~/.emacs.d/yasnippet/snippets
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

# * Shell
curl "$rdotfiles"/terminal/.zshrc > ~/.zshrc

mkdir -p ~/.config/kitty
curl "$rdotfiles"/terminal/.config/kitty/kitty.conf > ~/.config/kitty/kitty.conf

# * Stow
# shellcheck disable=1090
source ~/dotfiles/scripts/aliases/stow.sh
echo "Symlinking config files."
restow || echo "Symlinking config files failed."

# * VS Code Setup
vscode_setup() {
	grep --invert-match '^#' ~/dotfiles/editing/vscode-extensions.txt \
		| xargs -L1 code --install-extension
}

vscode_setup || echo "VS Code setup failed."

# * Services
echo "Enabling services."
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

brew services start emacs-plus
brew services start skhd

# * NPM/Yarn
echo "Installing programs with yarn."
yarn global add typescript
yarn global add typescript-language-server
yarn global add indium
yarn global add prettier
yarn global add react-native-cli
yarn global add ios-deploy

# * Python
pip3 install -r "$basedir"/requirements.txt
mkdir -p ~/.virtualenvs

# * Git Config Reminder
if [[ ! -f ~/.gitconfig ]]; then
	echo 'Remember to setup ~/.gitconfig with:
[includeIf "gitdir:~/school/**"]
path = .gitconfig-school
[includeIf "gitdir:~/src/emacs/**"]
path = .gitconfig-personal
[includeIf "gitdir:~/src/forks/**"]
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
