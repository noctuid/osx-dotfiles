# shellcheck disable=1090
source ~/dotfiles/scripts/aliases/stow.sh

alias vm='~/src/jabberwocky/vertexhmi/version-manager/version-manager'
alias vmb='~/src/jabberwocky/vertexb/version-manager/version-manager'

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

export PATH="/Applications/cov-analysis-macosx-2021.03/bin/:$PATH"

restartkarabiner() {
    service=org.pqrs.karabiner.karabiner_console_user_server
    launchctl stop "$service" && launchctl start "$service"
}
