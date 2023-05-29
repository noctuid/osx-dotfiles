# NOTE this is currently for backup only
# plan on removing

# * Taps
tap "d12frosted/emacs-plus"
tap "homebrew/bundle"
tap "homebrew/cask"
tap "homebrew/cask-fonts"
tap "homebrew/core"
tap "homebrew/services"
tap "clojure-lsp/brew"
# TODO this recipe is broken
# tap "valelint/vale"

# * Basic Utilities
brew "aspell"
brew "atool"
# look inside archives
brew "avfs"
brew "bat"
brew "cloc"
# needed for libvterm, for example
brew "cmake"
# for gls, for example
brew "coreutils"
cask "docker"
brew "exa"
brew "ext4fuse"
brew "imagemagick"
brew "ispell"
brew "p7zip"
brew "stow"
brew "trash"
brew "wget"
brew "valelint/vale/vale"
cask "osxfuse"
cask "virtualbox"
cask "virtualbox-extension-pack"
brew "direnv"
brew "progress"

# keep mac awake; may not work
# cask "caffeine"
# cask "keepingyouawake"

# Window Switching
# bound to command+. by default
cask "hotswitch"

# launcher
cask "alfred"

# for getting github auth token
brew "gh"

# * Remapping
# hotkey daemon
brew "koekeishiya/formulae/skhd", restart_service: :changed

# remapping
cask "karabiner-elements"

# keyboard layout editing
cask "ukelele"

# * Browsers
# currently installed manually
cask "firefox"
# pre-installed
# cask "google-chrome"

# * Fonts
cask "font-office-code-pro"
cask "font-fira-code-nerd-font"
cask "font-fira-mono-nerd-font"
cask "font-delugia-complete"

# * Shells
brew "fish"
cask "powershell"
brew "zsh"

# * Terminals
cask "iterm2"
cask "kitty"

# * TUI
brew "ranger"

# * Tmux
brew "tmux"
brew "reattach-to-user-namespace"

# * Search Programs
# kind of a search program
brew "fasd"
brew "fd"
brew "fzf"
brew "ripgrep"

# * Editors
# or with-modern-black-dragon-icon
brew "emacs-plus@28", args: ["with-modern-doom3-icon", "with-native-comp"]
# required to grab specific emacs config files from github
brew "svn"

# https://github.com/railwaycat/homebrew-emacsmacport/issues/174
# child frame borders work; emoji support; horrible focus switching issues
# doesn't support Emacs 28 at time of comment; only targets stable releases
# brew "emacs-mac", args: ["HEAD", "with-spacemacs-icon", "with-jansson"]
# emacs-mac is generally considered better but not if you need the latest Emacs

# Emacs package management tool
# TODO conflicts with emacs-plus?
# brew "cask"
brew "neovim"
cask "visual-studio-code"

brew "editorconfig"

# * TeX
# includes pdflatex
cask "basictex"

# * Programming
# ** Bash
brew "shellcheck"

# * Clojure
leiningen
clojure-lsp-native

# ** Javascript/Typescript
brew "node"
brew "yarn"

# ** Python
brew "pyenv"
brew "python"
brew "ipython"
# language server
brew "pyright"
brew "pipx"

# ** Lisp
brew "roswell"
