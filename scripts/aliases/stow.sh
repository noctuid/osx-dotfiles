restow() {
	# keyboard layouts can't be symlinked
	cd ~/dotfiles || return 1
	stow --ignore="Keyboard Layouts" -Rvt ~/ browsing editing remap scripts \
		 terminal wm
	cp -Rf ~/dotfiles/remap/Library/"Keyboard Layouts"/ColemakDH-ansi.bundle \
	   ~/Library/"Keyboard Layouts"
}

unstow() {
	cd ~/dotfiles || return 1
	stow --ignore="Keyboard Layouts" -Dvt ~/ browsing editing remap scripts \
		 terminal wm
}
