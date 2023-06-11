# intended to be bash and zsh compatible
# * Exports
export EDITOR='emacsclient -a "" -c'
export ALTERNATE_EDITOR=
export EA_EDITOR='emacsclient -a "" -c'

# * Brew
if [[ -f /opt/homebrew/bin/brew ]]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# * Pyenv
if hash pyenv 2> /dev/null; then
	# set up pyenv
	export PYENV_ROOT="$HOME/.pyenv"
	command -v pyenv > /dev/null \
		|| export PATH="$PYENV_ROOT/bin:$PATH"
	# add pyenv shims
	eval "$(pyenv init --path)"
fi

# * Nvm
# set up nvm
export NVM_DIR="$HOME"/.nvm
# very slow; only do in interactive shell for now (don't need for
# exec-path-from-shell)
if tty -s && hash brew 2> /dev/null; then
	nvm_file="$(brew --prefix nvm)"/nvm.sh
	if [ -f "$nvm_file" ]; then
		# shellcheck disable=SC1090
		source "$nvm_file"
	fi
fi

# * Path
pathdirs="
$HOME/bin
$HOME/.local/bin
$HOME/.poetry/bin:$PATH
"

while read -r dir; do
    if [[ -n $dir ]] && [[ ! ${dir:0:1} == '#' ]]; then
        PATH="$PATH":"$dir"
    fi
done <<< "$pathdirs"

# https://nix-community.github.io/home-manager/index.html#sec-install-nix-darwin-module
# home-manager says these are necessary, but so far they haven't
# been... possibly because zsh is at the system level through nix-darwin?
# . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
# . "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh"

# Local Variables:
# sh-shell: bash
# End:
