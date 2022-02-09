export EDITOR='emacsclient -a "" -c'
export ALTERNATE_EDITOR=
export EA_EDITOR='emacsclient -a "" -c'

# set up pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# set up nvm
export NVM_DIR="$HOME"/.nvm
source "$(brew --prefix nvm)"/nvm.sh

export PATH="/Applications/cov-analysis-macosx-2021.03/bin/:$PATH"

export PATH="$HOME/.poetry/bin:$PATH"
