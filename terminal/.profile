export EDITOR='emacsclient -a "" -c'
export ALTERNATE_EDITOR=
export EA_EDITOR='emacsclient -a "" -c'

# set up pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
# add pyenv shims
eval "$(pyenv init --path)"

# set up nvm
export NVM_DIR="$HOME"/.nvm
# very slow; only do in interactive shell for now (don't need for
# exec-path-from-shell)
if tty -s; then
    source "$(brew --prefix nvm)"/nvm.sh
fi

export PATH="/Applications/cov-analysis-macosx-2021.12.2/bin:$PATH"

export PATH="$HOME/.poetry/bin:$PATH"
