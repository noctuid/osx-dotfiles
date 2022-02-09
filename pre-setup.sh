#!/usr/bin/env bash

# many packages write here and will fail to install by default
sudo chown -R "$(whoami)" /usr/local/share/man /usr/local/share/man/man1 \
     /usr/local/share/zsh /usr/local/share/zsh/site-functions
chmod u+w /usr/local/share/man /usr/local/share/man/man1 /usr/local/share/zsh \
      /usr/local/share/zsh/site-functions

# macfuse required for various packages (e.g. avfs and extfuse)
brew install coreutils macfuse
