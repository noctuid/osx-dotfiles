#!/usr/bin/env bash
# dependencies:
# - brew
# - xcode and developer tools (i.e. xcode-select --install)
# - gnu coreutils (brew install coreutils)
# - macfuse for isntalling avfs and extfuse (brew install macfuse)

# NOTE: Have to put in password to install some things; have to give some
# programs accessibility permissions (e.g. skhd)

# TODO installing gvfs requires installing macports
# TODO ranger config
# TODO browser config
# TODO consistent error message on failure

# * Helpers
basedir=$(dirname "$(realpath "$0")")
rdotfiles=https://raw.githubusercontent.com/noctuid/dotfiles/master
svn_dotfiles=https://github.com/noctuid/dotfiles/trunk

message() {
	echo
	echo "setup.sh: $*"
}

errm() {
	echo
	echo "setup.sh: $*" >&2
}

# * Package Installation
# ** Brew
install_packages() {
	# brew seems extremely slow...
	message "Installing packages with Brew."
	brew bundle --no-upgrade || errm "Brew package installation failed."
}

# ** NPM/Yarn
yarn_global_install() {
	message "Installing programs with yarn."
	yarn global add typescript
	yarn global add typescript-language-server
	yarn global add indium
	yarn global add prettier
	yarn global add react-native-cli
	yarn global add ios-deploy
}

# ** Pip
pip_global_install() {
	pip3 install -r "$basedir"/requirements.txt
	mkdir -p ~/.virtualenvs
}

# * Emacs config
emacs_setup() (
	message "Setting up Emacs with latest configuration."

	# useful here (but see http://mywiki.wooledge.org/BashFAQ/105)
	set -e

	# ln -sf /usr/local/Cellar/emacs-plus/*/Emacs.app/ /Applications/
	# ln -sf /usr/local/Cellar/emacs-mac/*/Emacs.app /Applications/
	# ln -sf /usr/local/opt/emacs-mac/Emacs.app /Applications

	brew link "emacs-plus@28"

	mkdir -p ~/.emacs.d/lisp ~/.emacs.d/straight/versions
	curl "$rdotfiles"/emacs/.emacs.d/early-init.el > ~/.emacs.d/early-init.el
	curl "$rdotfiles"/emacs/.emacs.d/init.el > ~/.emacs.d/init.el
	curl "$rdotfiles"/emacs/.emacs.d/awaken.org > ~/.emacs.d/awaken.org
	curl "$rdotfiles"/emacs/.emacs.d/lisp/noct-util.el \
		 > ~/.emacs.d/lisp/noct-util.el
	curl "$rdotfiles"/emacs/.emacs.d/straight/versions/default.el \
		 > ~/.emacs.d/straight/versions/default.el

	mkdir -p ~/.emacs.d/yasnippet/{snippets,templates}
	# github doesn't support git-archive
	# however, it will convert to svn repo in backend
	# this can be used to get a specific folder
	svn checkout "$svn_dotfiles"/emacs/.emacs.d/etc/yasnippet/snippets \
		~/.emacs.d/yasnippet/snippets
	svn checkout "$svn_dotfiles"/emacs/.emacs.d/etc/yasnippet/templates \
		~/.emacs.d/yasnippet/templates
)

install_emacs_anywhere() {
	if [[ ! -d ~/.emacs_anywhere/.git ]]; then
		git clone https://github.com/zachcurry/emacs_anywhere ~/.emacs-anywhere
	fi
	# cp -Rf ~/.emacs-anywhere/"Emacs Anywhere".workflow ~/Library/Services}
}

# * Shell
shell_config_setup() {
	curl "$rdotfiles"/terminal/.zshrc > ~/.zshrc
	mkdir -p ~/.config/{kitty,tmux}
	curl "$rdotfiles"/terminal/.config/tmux/tmux.conf > ~/.config/tmux/tmux.conf
	curl "$rdotfiles"/terminal/.config/kitty/kitty.conf \
		 > ~/.config/kitty/kitty.conf
}

# * Stow
stow_dotfiles() {
	# shellcheck disable=1090
	source ~/dotfiles/scripts/aliases/stow.sh
	message "Symlinking config files."
	restow || errm "Symlinking config files failed."
}

# * VS Code Setup
vscode_setup() {
	message "Setting up VS Code"
	grep --invert-match '^#' ~/dotfiles/editing/vscode-extensions.txt \
		| xargs -L1 code --install-extension \
		|| errm "VS Code setup failed."
}

# * Services
services_setup() {
	message "Enabling services."
	sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist
	# brew services start emacs
	brew services start skhd
}

# * Git Config Setup
gitconfig_setup() {
	if [[ ! -f ~/.gitconfig ]] || ! grep --quiet email ~/.gitconfig; then
		echo "Enter the email address to use for git:"
		read -r email
		echo "[user]
	name = Fox Kiester
	email = $email
# probably won't use any of these besides dotfiles
# [includeIf \"gitdir:~/school/**\"]
#	path = .gitconfig-school
[includeIf \"gitdir:~/src/emacs/**\"]
	path = .gitconfig-personal
[includeIf \"gitdir:~/src/forks/**\"]
	path = .gitconfig-personal
[includeIf \"gitdir:~/dotfiles/**\"]
	path = .gitconfig-personal
" >> ~/.gitconfig
	fi

	if ! grep --quiet "[pull]" ~/.gitconfig 2> /dev/null; then
		echo "[pull]
	# require manual selection of rebase or merge if ff pull won't work
	ff = only
" >> ~/.gitconfig
	fi

	if [[ ! -f ~/.gitconfig-personal ]]; then
		echo "Enter the email address to use for commiting to the dotfilse repo:"
		read -r email
		echo "[user]
	email = $email
" >> ~/.gitconfig-personal
	fi
}

# * Main
setup_help() {
    echo "usage: [options] [subcommand]

By default (no args specified) or if \"all\" is given as the subcommand, run all
setup functions. To run a specific setup function, you can specify it, e.g.
\"emacs_setup\" to get the latest Emacs configuration.

Here are a list of available commands:
$(declare -F | awk '!/(message|errm|main|setup_help)/{print "- " $NF}')

options:
  -h or --help			print this help text
"
}

all() {
	install_packages
	yarn_global_install
	pip_global_install
	emacs_setup || errm "Emacs setup failed."
	install_emacs_anywhere || errm "Installing Emacs Anywhere failed."
	shell_config_setup
	stow_dotfiles
	vscode_setup
	services_setup
	gitconfig_setup
}

main() {
	if [[ $1 =~ ^(-h|--help)$ ]]; then
		setup_help
	elif [[ -z $1 ]]; then
		all
	else
		"$@"
	fi
}

main "$@"
