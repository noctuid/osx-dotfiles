# shellcheck disable=1090
source ~/dotfiles/scripts/aliases/stow.sh

restartkarabiner() {
    service=org.pqrs.karabiner.karabiner_console_user_server
    launchctl stop "$service" && launchctl start "$service"
}

dots() {
    ~/dotfiles/setup.sh "$@"
}

integresql() {
    PGUSER=postgres PGPASSWORD=postgres $HOME/go/bin/server
}
