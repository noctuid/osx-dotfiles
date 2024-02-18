# * Taps
# no longer necessary
# tap "homebrew/core"
# tap "homebrew/cask"
tap "d12frosted/emacs-plus"
tap "homebrew/bundle"
tap "homebrew/cask-fonts"
tap "homebrew/services"
# tap "clojure-lsp/brew"
# TODO this recipe is broken
# tap "valelint/vale"
# skhd/yabai
tap "koekeishiya/formulae"
# sketchybar
tap "FelixKratz/formulae"

# * Basic Utilities
brew "aspell"
brew "hunspell"
# need for jinx
brew "enchant"
brew "atool"
brew "unzip"
brew "zip"
brew "p7zip"
# look inside archives; not currently available on Apple Silicon
# brew "avfs"
brew "bat"
brew "cloc"
brew "make"
# needed for libvterm, for example
brew "cmake"
# for gls, for example
brew "coreutils"
brew "gawk"

cask "docker"
brew "docker-compose"
brew "exa"
# not currently available on Apple Silicon
# brew "ext4fuse"
brew "imagemagick"
brew "ispell"
brew "p7zip"
brew "stow"
brew "trash"
brew "wget"
# brew "valelint/vale/vale"
# NOTE: this is succeeded by macfuse, which is installed in pre-setup.sh
# cask "osxfuse"
# cask "virtualbox"
# cask "virtualbox-extension-pack"
brew "direnv"
brew "progress"
brew "pv"

# for fzf_preview script with fzf-tab
brew "lesspipe"

# brew "neofetch"

# keep mac awake; may not work
# cask "caffeine"
# cask "keepingyouawake"

# Window Switching; not using
# bound to command+. by default
# cask "hotswitch"

brew "yabai"
brew "sketchybar"

# launcher
cask "raycast"
# cask "alfred"

# for getting github auth token
brew "gh"

# * Remapping
# hotkey daemon
brew "skhd"

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
cask "font-fontawesome"
cask "font-office-code-pro"
cask "font-fira-code-nerd-font"
cask "font-fira-mono-nerd-font"
cask "font-delugia-complete"
cask "sf-symbols"

# * Shells
brew "fish"
cask "powershell"
brew "zsh"
# default bash is extremely out-of-date
brew "bash"

# * Terminals
cask "wezterm"
# backup
cask "iterm2"
cask "kitty"

# * TUI
# brew "ranger"
# these aren't as important; use dired
# TODO pistol (scope.sh replacement)
# video preview
# brew "ffmpegthumbnailer"
# ranger info; alternative exiftool
# cask "mediainfo"
# TODO xlsx2csv

# TODO ueberzug


# not currently using
# brew "chafa"

# * Image
# extremely fast thumbnail creation for dirvish
brew "vips"

# * Tmux
brew "tmux"
brew "reattach-to-user-namespace"

# * Search Programs
# kind of a search program
brew "fd"
brew "fzf"
brew "ripgrep"

# * Editors
# or with-modern-black-dragon-icon
# NOTE:
# - light/dark detection patch is enabled by default
# - fix window role patch is enabled by default
brew "emacs-plus@30", args: ["with-modern-doom3-icon", "with-native-comp", "with-poll", "with-no-frame-refocus"]
# required to grab specific emacs config files from github
brew "svn"

# https://github.com/railwaycat/homebrew-emacsmacport/issues/174
# child frame borders work; emoji support; horrible focus switching issues
# only targets stable releases, which is a non-starter for me; have no issues
# with emacs-plus
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
# TODO fails
# cask "basictex"

# * Programming
# ** General
brew "tree-sitter"

# ** Github
# run github actions locally
brew "act"

# ** Diff Tools
brew "git-delta"
brew "difftastic"

# ** Format Parsing
brew "jq"
# TODO this is a different program than what want
# brew "fq"
brew "miller"
# emacs-pet uses
brew "dasel"

# ** Requests
brew "curl"
brew "wget"
cask "postman"

# ** Database
cask "pgadmin4"

# ** Bash
brew "shellcheck"

# ** Clojure
# leiningen
# clojure-lsp-native

# ** Javascript/Typescript
# brew "node"
brew "yarn"
# brew "nvm"
# infinitely faster
brew "fnm"

# ** Python
brew "pyenv"
brew "python"
# TODO better way to install this?
brew "poetry"
brew "ipython"
# language server
brew "pyright"
brew "pipx"

# ** Rust
# use cargo to build some tools use
brew "rust"

# ** Taoml
brew "taplo"

# ** Lisp
# brew "roswell"
