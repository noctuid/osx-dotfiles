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

# Local Variables:
# sh-shell: bash
# End:
