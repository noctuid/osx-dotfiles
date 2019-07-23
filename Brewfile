# * Taps
tap "d12frosted/emacs-plus"
tap "homebrew/bundle"
tap "homebrew/cask"
tap "homebrew/cask-fonts"
tap "homebrew/core"
tap "homebrew/services"
tap "valelint/vale"

# * Basic Utilities
brew "atool"
brew "avfs"
brew "cloc"
# needed for libvterm, for example
brew "cmake"
# for gls, for example
brew "coreutils"
cask "docker"
brew "ext4fuse"
brew "imagemagick"
brew "ispell"
brew "p7zip"
brew "trash"
brew "wget"
brew "valelint/vale/vale"
cask "osxfuse"
cask "virtualbox"

# Window Switching
cask "hotswitch"

# * Remapping
# hotkey daemon
# TODO why does this work with brew install but fail with brew bundle??
cask "koekeishiya/formulae/skhd", restart_service: :changed

# remapping
cask "karabiner-elements"

# keyboard layout editing
cask "ukelele"

# * Browsers
# cask "firefox"
# cask "google-chrome"

# * Fonts
cask "font-office-code-pro"
cask "font-fira-code"
cask "font-fira-mono"

# * Shells
brew "fish"
cask "powershell"
brew "zsh"

# * Terminals
cask "iterm2"
cask "kitty"

# * TUI
brew "ranger"

# * Search Programs
brew "fd"
brew "fzf"
brew "ripgrep"

# * Editors
# --HEAD not officially supported but it works
brew "emacs-plus", args: ["HEAD", "without-spacemacs-icon"]
brew "neovim"

# * Programming
# ** Bash
brew "shellcheck"

# ** Javascript/Typescript
brew "node"
brew "yarn"

# ** Python
brew "python"
brew "ipython"
