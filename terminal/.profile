# intended to be bash and zsh compatible
# * Exports
export EDITOR='emacsclient -a "" -c'
export ALTERNATE_EDITOR=
export EA_EDITOR='emacsclient -a "" -c'

# * Brew
if [[ -f /opt/homebrew/bin/brew ]]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# * Path
pathdirs="
$HOME/bin
$HOME/.local/bin
$HOME/.cargo/bin
$HOME/.poetry/bin
"

while read -r dir; do
	if [[ -n $dir ]] && [[ ! ${dir:0:1} == '#' ]]; then
		export PATH="$PATH":"$dir"
	fi
done <<< "$pathdirs"

# https://nix-community.github.io/home-manager/index.html#sec-install-nix-darwin-module
# home-manager says these are necessary, but so far they haven't
# been... possibly because zsh is at the system level through nix-darwin?
# . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
# . "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh"

# * Pyenv
if hash pyenv 2> /dev/null; then
	# set up pyenv
	export PYENV_ROOT="$HOME/.pyenv"
	command -v pyenv > /dev/null \
		|| export PATH="$PATH:$PYENV_ROOT/bin"
	# putting at end of PATH so faster rust pyenv-python shim takes precedence;
	# --no-push-path will prevent adding it to PATH again
	PATH="$(echo "$PATH" | sed -E "s;$HOME/.pyenv/shims:?;;"):$HOME/.pyenv/shims"
	export PATH
	# add zsh completion and pyenv shell command
	eval "$(pyenv init - --no-rehash --no-push-path)"
fi

# * Fnm
eval "$(fnm env --use-on-cd)"

# Local Variables:
# sh-shell: bash
# End:
